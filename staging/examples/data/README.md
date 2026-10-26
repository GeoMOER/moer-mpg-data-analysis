# Instructor data and Unit 03 rendering

The active Unit 03 land-use examples now use the public, attributed Destatis 2024 files in `docs/assets/data/`. Their preparation is documented by `prepare-land-use-2024.R` and `destatis-land-use-2024-source.txt`; the prepared RDS has 16 state-level observations for one year. The teaching CSV and RDS use English headers and region names; the original German workbook and dictionary crosswalk preserve the source labels. Rebuild the English CSV with `python3 staging/examples/translate_land_use_2024.py` from the repository root before regenerating the RDS.

For a portable learner render, copy the Unit 03 land-use files into a `Data/` folder in a temporary project and render `unit03-04_csv_io.Rmd` or `unit03-06_exploration.Rmd` with that project as `knit_root_dir`. `unit03-03_visualization.Rmd` uses built-in R datasets. Instructor renders may set the option `mpg.unit03.fig.path` to an isolated output directory. Inspect new rendered Markdown and figures before publishing them; the Jekyll frontmatter, links and image paths are maintained separately.

Any older ILIAS data copies in this directory are ignored and are not the active Unit 03 examples. They must not be committed to the public repository. Later regional-data exercises retain their separate source dependencies until their own review is completed.
