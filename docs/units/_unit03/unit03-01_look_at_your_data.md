---
title: Look at Your Data
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics){:target="_blank"}'
---

Become familiar with reading and writing data, computing summary statistics, and exploring data visually as the basics of data analysis.

<!--more-->

## Learning objectives
At the end of this unit you should be able to
* organize local data files and use paths relative to your RStudio project,
* read a function call and use its help page to choose arguments,
* import and export tabulated data while checking types, identifiers, and units,
* explain how a prepared RDS file relates to its source data,
* compute and interpret basic summary statistics,
* choose and justify a plot for a distribution, category comparison, time course, or relationship.

Additional material is available in the accompanying [Base R course](https://geomoer.github.io/moer-base-r/), particularly [data input/output](https://geomoer.github.io/moer-base-r/unit06/unit06-01_Intro.html) and [simple visualizations](https://geomoer.github.io/moer-base-r/unit09/unit09-01_Intro.html).

## How this unit is organized

This unit builds on the R Markdown workflow from [Unit 01]({{ site.baseurl }}/unit01/unit01-05_Rmd_html.html) and the data types and indexing from [Unit 02]({{ site.baseurl }}/unit02/unit02-01_first_things_second.html).

We complete data I/O before moving on to visualization. In each part, start with the general explanation and small examples, then apply them to a real dataset.

1. [Tabulated Data I/O]({{ site.baseurl }}/unit03/unit03-02_data_io.html): understand text files, data frames and saved R objects.
2. [Organize Your Data Files]({{ site.baseurl }}/unit03/unit03-02a_organize_your_data_files.html): download a small practice file and locate it inside your project.
3. [R Syntax and Help]({{ site.baseurl }}/unit03/unit03-02a_r_syntax_and_help.html): read the practice file and connect function syntax with the help page.
4. [Example: CSV I/O]({{ site.baseurl }}/unit03/unit03-04_csv_io.html): import, inspect and prepare the official land-use data, then save the result.
5. [Visualization]({{ site.baseurl }}/unit03/unit03-03_visualization.html): choose plots for different questions and try small examples.
6. [Example: Visual Data Exploration]({{ site.baseurl }}/unit03/unit03-06_exploration.html): explore the prepared land-use data and arrange plots in a four-panel figure.
7. [Marked Assignment: Read and Plot]({{ site.baseurl }}/unit03/unit03-07_assignment.html): apply the workflow independently to timber harvest data.

## Data files (reference) {#data-files-on-ilias}

Download files when you reach the relevant page, keeping their original names:

- **Syntax practice:** the file-organization page provides `example.txt`, a small invented table that you download into `Data/`.
- **Land-use example:** the CSV I/O page links the English teaching CSV derived from Destatis 2024 and its original workbook, dictionary and source notes. It shows how to create the prepared RDS used in visual exploration; a prepared download and preparation script are also available there.
- **Plotting practice:** `pressure` and `Orange` are included with R.
- <span id="timber-data-on-ilias"></span>**Marked assignment:** obtain `hessen_holzeinschlag_2003-2025.csv` from ILIAS. [Assignment 03]({{ site.baseurl }}/unit03/unit03-07_assignment.html#harvest-in-hessen) explains its groups, units, file layout and official sources, including the [Destatis quality report (PDF, German)](https://www.destatis.de/DE/Methoden/Qualitaet/Qualitaetsberichte/Land-Forstwirtschaft-Fischerei/holzeinschlagsstatistik.pdf?__blob=publicationFile). Assignment 08 reuses this file.
- <span id="data-for-later-units"></span>**Later units:** cleaning and regression use separate regional datasets. Consult the [Unit 04 file guide]({{ site.baseurl }}/unit04/unit04-01a_introduction.html#data-for-units-04-07) for their filenames and category definitions.

## Comments?
You can leave comments below if you have questions or remarks about any of the text or code in this unit. 
Please copy the corresponding line into your comment to make it easier to answer your question.

<script src="https://utteranc.es/client.js" repo="GeoMOER/moer-mpg-data-analysis" issue-term="moer-mpg-data-analysis_unit03" theme="github-light" crossorigin="anonymous" async> </script> 
