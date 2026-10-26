"""Rebuild the English teaching CSV from the unchanged Destatis workbook.

Run with Python 3 from any directory. Uses only the standard library; the
dictionary supplies the complete original-to-English column crosswalk.
"""

import csv
from decimal import Decimal
from io import StringIO
from pathlib import Path
from xml.etree import ElementTree as ET
from zipfile import ZipFile


NS = {"s": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}
REL = "{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id"
STATES = {
    "0": "Germany", "01": "Schleswig-Holstein", "02": "Hamburg",
    "03": "Lower Saxony", "04": "Bremen", "05": "North Rhine-Westphalia",
    "06": "Hesse", "07": "Rhineland-Palatinate", "08": "Baden-Württemberg",
    "09": "Bavaria", "10": "Saarland", "11": "Berlin", "12": "Brandenburg",
    "13": "Mecklenburg-Western Pomerania", "14": "Saxony",
    "15": "Saxony-Anhalt", "16": "Thuringia",
}


def source_table(workbook):
    """Read A1:BL18 of the source worksheet, retaining empty cells."""
    with ZipFile(workbook) as archive:
        strings = ["".join(item.itertext()) for item in
                   ET.fromstring(archive.read("xl/sharedStrings.xml"))]
        relations = {item.attrib["Id"]: item.attrib["Target"] for item in
                     ET.fromstring(archive.read("xl/_rels/workbook.xml.rels"))}
        book = ET.fromstring(archive.read("xl/workbook.xml"))
        sheet = next(item for item in book.find("s:sheets", NS)
                     if item.attrib["name"] == "csv-33111-03")
        target = relations[sheet.attrib[REL]]
        sheet_path = target.lstrip("/") if target.startswith("/") else "xl/" + target
        source = ET.fromstring(archive.read(sheet_path))
        result = [[""] * 64 for _ in range(18)]
        for row in source.findall("s:sheetData/s:row", NS):
            for cell in row:
                reference = cell.attrib["r"]
                letters = "".join(char for char in reference if char.isalpha())
                column = 0
                for letter in letters:
                    column = column * 26 + ord(letter) - ord("A") + 1
                number = int("".join(char for char in reference if char.isdigit()))
                if number > 18 or column > 64:
                    continue
                value = cell.find("s:v", NS)
                if value is not None:
                    value = value.text or ""
                    if cell.attrib.get("t") == "s":
                        value = strings[int(value)]
                else:
                    value = "".join(cell.find("s:is", NS).itertext()) if cell.find("s:is", NS) is not None else ""
                result[number - 1][column - 1] = value
    return result


def translate(data_dir):
    original = source_table(data_dir / "destatis-land-use-2024.xlsx")
    with (data_dir / "destatis-land-use-2024-dictionary.csv").open(
            encoding="utf-8", newline="") as handle:
        dictionary = list(csv.DictReader(handle, delimiter=";"))
    headers = [item["english_column"] for item in dictionary]
    if len(dictionary) != 64 or len(set(headers)) != 64:
        raise ValueError("Expected 64 distinct English column names")
    if original[0] != [item["source_column"] for item in dictionary]:
        raise ValueError("Workbook headers do not match the documented source")
    result = [headers]
    for source in original[1:]:
        code = str(int(Decimal(source[3])))
        code = "0" if code == "0" else code.zfill(2)
        if int(Decimal(source[2])) != 2024:
            raise ValueError("Unexpected reference year")
        row = ["Survey of land area by actual use",
               "Table 33111-3.1: Land-use shares of total area in 2024 by region",
               "2024", code, STATES[code], str(int(Decimal(source[5])))]
        for value in source[6:]:
            row.append(format(Decimal(value).quantize(Decimal("0.1")), "f").replace(".", ",")
                       if value else "")
        result.append(row)
    if len(result) != 18 or sum(value == "" for row in result[1:] for value in row) != 94:
        raise ValueError("Unexpected source dimensions or missing-cell count")
    if [row[3] for row in result[1:]] != list(STATES):
        raise ValueError("Unexpected state order or identifiers")
    output = StringIO(newline="")
    csv.writer(output, delimiter=";", quoting=csv.QUOTE_ALL,
               lineterminator="\n").writerows(result)
    (data_dir / "destatis-land-use-2024.csv").write_text(output.getvalue(), encoding="utf-8")


if __name__ == "__main__":
    translate(Path(__file__).resolve().parents[2] / "docs/assets/data")
