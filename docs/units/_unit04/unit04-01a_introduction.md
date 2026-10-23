---
title: Introduction
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Check the integrity of datasets and clean them up to ensure that the data basis for your analysis is consistent.

<!--more-->

## Learning objectives
At the end of this unit you should be able to
* identify some common problems in the structure of data frames,
* subset, merge, and split data frames to clean them.



For a quick introduction to [sorting and combining data](https://geomoer.github.io/moer-base-r/unit08/unit08-01_Intro.html){:target="_blank"}  in R 
check out our own material in the accompanying 
[Base R course](https://geomoer.github.io/moer-base-r/units.html){:target="_blank"}.



## Data for Units 04–07 {#data-for-units-04-07}

These exercises use regional extracts supplied on ILIAS, separate from Unit 03's small 2024 state table. The extracts mix several administrative levels and years; they are not a newer version of the Unit 03 file. Keep the filename specified by each example or assignment.

| File | Contents and role |
|---|---|
| `AI001_gebiet_flaeche.txt` | Land-use shares through 2014; raw text for the detailed cleaning example. |
| `lu_clean.rds` | Prepared land-use shares, 1996–2014, for the later regression assignments. |
| `115-46-4_feldfruechte.txt` | Crop yields, 1999–2015; raw text for the crop-cleaning assignment. |
| `cp_clean.rds` | Prepared crop-yield data for the feature-selection assignment. |

In these filenames, *Gebiet und Fläche* means *region and area*, and *Feldfrüchte* means *field crops*. In this land-use extract, `Settlement` includes transport area, and `Recreation`, `Agriculture`, and `Forest` are percentages of total area. This definition differs from Unit 03's ALKIS `Settlement` category, which excludes the separate transport category. Do not transfer category definitions between the files.

Crop yields are measured in decitonnes per hectare (`dt/ha`; 1 dt = 100 kg). The prepared crop file retains two misspelled column names: `Potatos` means potatoes, and `Suggar_beets` means sugar beet. The raw headings `Winterweizen`, `Roggen`, `Wintergerste`, `Sommergerste`, `Hafer`, `Winterraps`, and `Silomais` mean winter wheat, rye, winter barley, spring barley, oats, winter rapeseed, and silage maize. German place names are identifiers, not terms to translate.

## Comments?
You can leave comments below if you have questions or remarks about any of the text or code in this unit. 
Please copy the corresponding line into your comment to make it easier to answer your question.

<script src="https://utteranc.es/client.js" repo="GeoMOER/moer-mpg-data-analysis" issue-term="moer-mpg-data-analysis_unit04" theme="github-light" crossorigin="anonymous" async> </script> 

