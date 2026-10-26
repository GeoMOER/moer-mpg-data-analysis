#!/usr/bin/env python3
"""Create English teaching copies of the historical Unit 04 text exports.

Only headings, introductory text and comma-separated regional descriptors are
translated. Observation order, IDs, years, numerical tokens, missing-value
symbols, indentation and the crop footer remain unchanged. Original exports
stay outside this repository. No cleaned assignment solution is generated.
"""

import argparse
import csv
import hashlib
import json
from pathlib import Path


DESCRIPTORS = {
    "Kreisfreie Stadt": "Urban district",
    "krfr. Stadt": "Urban district",
    "krsfr. Stadt": "Urban district",
    "Landkreis": "District",
    "Kreis": "District",
    "Landeshauptstadt": "State capital",
    "Hansestadt": "Hanseatic city",
    "Universitätsstadt": "University city",
    "Regierungsbezirk": "Administrative district",
    "Stat. Region": "Statistical region",
    "Regionalverband": "Regional association",
    "NUTS 2-Region": "NUTS 2 region",
    "Stadt": "City",
}

FILES = [
    {
        "source": "AI001_gebiet_flaeche.txt",
        "target": "regional-land-use-1996-2014.txt",
        "header": 4,
        "intro": [
            "GENESIS table: AI001",
            "Regional Atlas Germany;;;;;;",
            "Indicators for region and area;;;;;;",
            "Regional Atlas - indicators;;;;;;",
        ],
        "columns": ["Year", "Region_ID", "Region_label",
                    "Settlement_and_transport_share", "Recreation_share",
                    "Agriculture_share", "Forest_share"],
        "unit": "percent of total reporting area",
    },
    {
        "source": "115-46-4_feldfruechte.txt",
        "target": "regional-crop-yields-1999-2015.txt",
        "header": 6,
        "intro": [
            "GENESIS table: 115-46-4",
            "Yields of selected agricultural field crops;;;;;;;;;;;;",
            "- Annual results - regional coverage: districts and urban districts;;;;;;;;;;;;",
            "Harvest statistics;;;;;;;;;;;;",
            "Yield (dt/ha);;;;;;;;;;;;",
            ";;;" + ";".join(["Crop type"] * 10),
        ],
        "columns": ["Year", "Region_ID", "Region_label", "Winter_wheat",
                    "Rye_and_winter_mixed_cereals", "Winter_barley",
                    "Spring_barley", "Oats", "Triticale", "Potatoes",
                    "Sugar_beet", "Winter_rapeseed", "Silage_maize"],
        "unit": "dt/ha (1 dt = 100 kg)",
    },
]


def translate_label(label):
    parts = label.split(",")
    if parts[0].strip() == "Deutschland":
        parts[0] = parts[0].replace("Deutschland", "Germany")
    for index in range(1, len(parts)):
        token = parts[index].strip()
        if token not in DESCRIPTORS:
            raise ValueError("Unmapped regional descriptor: " + repr(token))
        parts[index] = parts[index].replace(token, DESCRIPTORS[token])
    return ",".join(parts)


def create_copies(source_dir, output_dir):
    output_dir.mkdir(parents=True, exist_ok=True)
    mappings = []
    manifest = []
    for spec in FILES:
        source = source_dir / spec["source"]
        data = source.read_bytes()
        lines = data.decode("latin-1").splitlines()
        header = spec["header"]
        original_columns = next(csv.reader([lines[header]], delimiter=";"))
        output = spec["intro"] + [";".join(spec["columns"])]
        records = 0
        for line in lines[header + 1:]:
            fields = line.split(";")
            if len(fields) == len(spec["columns"]) and fields[0].isdigit():
                original_label = fields[2]
                fields[2] = translate_label(original_label)
                output.append(";".join(fields))
                mappings.append([spec["target"], "Region_label",
                                 original_label, fields[2], "Place names retained; descriptors translated"])
                records += 1
            else:
                output.append(line)
        target = output_dir / spec["target"]
        # New encoding is deliberate: the teaching copies are UTF-8.
        target.write_bytes(("\r\n".join(output) + "\r\n").encode("utf-8"))
        for original, translated in zip(original_columns, spec["columns"]):
            mappings.append([spec["target"], "column", original, translated,
                             spec["unit"] if translated not in spec["columns"][:3] else "identifier"])
        manifest.append({"source": spec["source"], "source_sha256": hashlib.sha256(data).hexdigest(),
                         "teaching_file": spec["target"], "teaching_sha256": hashlib.sha256(target.read_bytes()).hexdigest(),
                         "observations": records, "header_line": header + 1,
                         "encoding": "UTF-8", "unit": spec["unit"]})
    with (output_dir / "regional-data-english-crosswalk.csv").open("w", encoding="utf-8", newline="") as handle:
        writer = csv.writer(handle)
        writer.writerow(["teaching_file", "kind", "source_text", "english_text", "note"])
        writer.writerows(sorted({tuple(row) for row in mappings}))
    (output_dir / "regional-data-english-manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    (output_dir / "README.md").write_text(
        "# English teaching copies: historical regional data\n\n"
        "Sources: GENESIS/Regional Atlas AI001 (land use, 1996–2014) and "
        "115-46-4 (crop yields, 1999–2015), supplied by the course instructor. "
        "These are attributed teaching translations, not new official English exports.\n\n"
        "Only introductory text, column headings, Germany's name and regional "
        "descriptors after commas are translated. Proper place names, leading "
        "spaces, row order, IDs, years, decimal commas, numerical tokens and "
        "source symbols are retained. The crop copyright/footer is retained. "
        "The originals remain the provenance record. The crosswalk documents "
        "all original/translated headings and regional labels.\n\n"
        "Land use: four introductory lines; header line 5; 5,250 observations; "
        "shares in percent. Settlement includes transport. Crop yields: six "
        "introductory lines; header line 7; 8,925 observations; five footer "
        "lines; dt/ha. Both teaching files use semicolons and UTF-8.\n\n"
        "Do not infer administrative status from an absent label. The symbols "
        "-, . and / are preserved; their table-specific interpretation must be "
        "documented before analytical conversion. These copies intentionally "
        "retain the original cleaning problems.\n\n"
        "Create the files with translate_unit04_regional_data.py --source-dir "
        "<original-exports> --output-dir <teaching-package>. The script does "
        "not generate cleaned RDS files or an assignment solution.\n",
        encoding="utf-8")
    return manifest


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-dir", type=Path, required=True)
    parser.add_argument("--output-dir", type=Path, required=True)
    args = parser.parse_args()
    for item in create_copies(args.source_dir, args.output_dir):
        print(item["teaching_file"], item["observations"], "observations")
