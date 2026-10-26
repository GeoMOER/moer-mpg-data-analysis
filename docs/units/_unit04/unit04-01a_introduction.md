---
title: Introduction
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Check, clean and document a dataset so that its observations, values and limitations are clear before analysis.

<!--more-->

## Learning objectives

At the end of this unit you should be able to

- define an observation and identify a suitable key;
- inspect types, source symbols and missing values before conversion;
- sort complete rows without separating measurements from their identifiers;
- split compound labels without guessing missing administrative information;
- reshape a table and explain what a row represents before and afterward;
- match tables by keys and identify duplicates or unmatched records;
- save a reproducible wide analysis table and document unresolved cases.

## How this unit is organized

Build on [Unit 03's local-file workflow]({{ site.baseurl }}/unit03/unit03-01_look_at_your_data.html): keep your Rmd beside the `.Rproj`, downloaded inputs in `Data/`, and generated results in `Output/`.

Start with [Cleaning 101]({{ site.baseurl }}/unit04/unit04-01b_clean_your_data.html), then work through [missing values]({{ site.baseurl }}/unit04/unit04-02_na.html) and [sorting]({{ site.baseurl }}/unit04/unit04-04_sorting.html). The focused examples on [splitting text]({{ site.baseurl }}/unit04/unit04-04a_text.html), [reshaping and grouped summaries]({{ site.baseurl }}/unit04/unit04-04b_reshaping.html) and [matching tables]({{ site.baseurl }}/unit04/unit04-04c_merging.html) introduce operations used in the [worked land-use example]({{ site.baseurl }}/unit04/unit04-05_cleaning.html). The [crop assignment]({{ site.baseurl }}/unit04/unit04-07_assignment.html) transfers them to another source file.

The separate [date/time example]({{ site.baseurl }}/unit04/unit04-03_datetime.html) prepares you for the station observations in Units 09–10. The annual regional tables here require integer reporting years rather than full date-time values.

Additional explanations are available in [sorting and combining data in Base R](https://geomoer.github.io/moer-base-r/unit08/unit08-01_Intro.html).

## Data for Units 04–07 {#data-for-units-04-07}

We retain two historical regional datasets because they provide real cleaning problems and support the later modeling tasks. The English teaching copies translate headings, introductory text and regional descriptors while retaining the source values, IDs, years, indentation, decimal commas and symbols. They are teaching translations, not newer official English exports. Proper place names remain in their source spelling.

Download the English file specified by the worked example or assignment into `Data/`, keeping its filename. The same files are available on ILIAS. If your browser displays a text file, use **Save As** and move it into `Data/`.

| Input | Coverage and role | File layout |
|---|---|---|
| <a href="{{ site.baseurl }}/assets/data/unit04/regional-land-use-1996-2014.txt" download="regional-land-use-1996-2014.txt">regional-land-use-1996-2014.txt</a> | 5,250 region-year records; four land-use percentages; worked cleaning example. | UTF-8; semicolons; four introductory lines; header line 5. |
| <a href="{{ site.baseurl }}/assets/data/unit04/regional-crop-yields-1999-2015.txt" download="regional-crop-yields-1999-2015.txt">regional-crop-yields-1999-2015.txt</a> | 8,925 region-year records; ten crop yields; independent cleaning assignment. | UTF-8; semicolons; six introductory lines; header line 7; five footer lines. |

The attributed sources are GENESIS/Regional Atlas **AI001** (`AI001_gebiet_flaeche.txt`) and **115-46-4** (`115-46-4_feldfruechte.txt`), supplied by the course instructors from the [Regional Database Germany](https://www.regionalstatistik.de/genesis/online/). The unchanged exports are provenance, rather than extra required learner downloads. The [English crosswalk]({{ site.baseurl }}/assets/data/unit04/regional-data-english-crosswalk.csv) records the original headings and translated labels; [source and preparation notes]({{ site.baseurl }}/assets/data/unit04/regional-data-source.txt) explain the files. `-`, `.` and `/` are retained; preserve them separately before making a numerical conversion decision. A reported `0,0` remains an explicit zero.

The extracts contain several geographic levels and years; they are neither independent district-only samples nor newer versions of Unit 03's small 2024 state table. In the historical land-use file, `Settlement` **includes transport**; `Recreation`, `Agriculture` and `Forest` are also percentages of total area. Do not transfer the different 2024 ALKIS category definitions to this file.

Crop yields use **decitonnes per hectare** (`dt/ha`; 1 dt = 100 kg). The English source headings distinguish *rye and winter mixed cereals* and *winter rapeseed*; do not describe these as unrestricted rye or rapeseed categories.

### Generated outputs and later use

| Output | Where it comes from | Reused in |
|---|---|---|
| `Output/lu_clean.rds` | Wide land-use table generated in the worked example, with source cells and unresolved metadata saved separately. | Units 05–06. |
| `Output/cp_clean.rds` | Wide crop table generated in your unmarked assignment, with original source tokens retained separately. | Unit 07. |

Prepared instructor RDS files are alternative checkpoints, not unexplained additional sources. The current checkpoints use the same English metadata rules and output schema as these lessons. Inspect their provenance and structure before using them; unresolved regional types remain explicitly unavailable.

If you need a prepared checkpoint, download <a href="{{ site.baseurl }}/assets/data/unit04/lu_clean.rds" download="lu_clean.rds">lu_clean.rds</a> or <a href="{{ site.baseurl }}/assets/data/unit04/cp_clean.rds" download="cp_clean.rds">cp_clean.rds</a> and save it in `Output/`. These are alternatives to generating your own output, not additional required inputs.

## Comments?

You can leave comments below if you have questions about the text or code. Include the relevant line to make the question easier to answer.

<script src="https://utteranc.es/client.js" repo="GeoMOER/moer-mpg-data-analysis" issue-term="moer-mpg-data-analysis_unit04" theme="github-light" crossorigin="anonymous" async> </script>
