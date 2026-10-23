# Unit 03 source data

For local instructor renders, place unchanged copies of the following ILIAS files in this directory. The data files themselves are not part of the public repository.

- `AI001_gebiet_flaeche.txt`: Regional Database Germany / German statistical offices, Regionalatlas indicator AI001, observations through 2014. The original file is ISO-8859-1 encoded.
- `lu_clean.rds`: course-prepared land-use data derived from the same regional statistics, observations from 1996 to 2014.

The published examples instruct students to use their ILIAS downloads. Source: [Regional Database Germany](https://www.regionalstatistik.de/genesis/online/). Credit the Federal Statistical Office and the statistical offices of the Länder when reusing the data.

To render the matching instructor R Markdown sources from the repository root, use `rmarkdown::render("staging/examples/rmd/unit03-04_csv_io.Rmd", knit_root_dir = getwd())` or replace the filename with `unit03-06_exploration.Rmd`. The published Jekyll pages and image paths are maintained separately; inspect a new render before copying it into `docs/`.
