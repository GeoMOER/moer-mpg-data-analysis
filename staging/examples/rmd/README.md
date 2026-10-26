# Course example sources

Published Markdown in `docs/units/` is the course reference. Match a source by its content before rendering: historical source numbers do not always match published page numbers. Keep existing public URLs and figure paths. Review generated output before incorporating it into a course page.

## Active sources for Units 04–12

| Rmd source | Published Markdown under `docs/units/` | Maintenance note |
|---|---|---|
| `unit04-02_na.Rmd` | `_unit04/unit04-02_na.md` | Current English lesson. |
| `unit04-03_datetime.Rmd` | `_unit04/unit04-03_datetime.md` | Current explicit-time-zone example. |
| `unit04-04_sorting.Rmd` | `_unit04/unit04-04_sorting.md` | Current complete-row sorting example. |
| `unit04-04a_text.Rmd` | `_unit04/unit04-04a_text.md` | Current text-splitting example. |
| `unit04-04b_reshaping.Rmd` | `_unit04/unit04-04b_reshaping.md` | Current reshaping/grouped-summary example. |
| `unit04-06_merging.Rmd` | `_unit04/unit04-04c_merging.md` | Source keeps its older filename. |
| `unit04-05_cleaning.Rmd` | `_unit04/unit04-05_cleaning.md` | Current worked regional-data workflow. |
| `unit05-02_linear_regression.Rmd` | `_unit05/unit05-03_linear_regression.md` | Anscombe example; plot descriptions are synchronized. |
| `unit06-02_cross_validation.Rmd` | `_unit06/unit06-02_cross_validation.md` | Associated historical source; its setup/method review remains M1. |
| `unit07-02_variable_selection.Rmd` | `_unit07/unit07-02_variable_selection.md` | Associated source; model-selection/evaluation review remains M1. |
| `unit08-02_generalized_additive_models.Rmd` | `_unit08/unit08-02_generalized_additive_models.md` | Plot descriptions added; historical RNG/results remain M2. |
| `unit09-02_time_series.Rmd` | `_unit09/unit09-02_time_series.md` | Historical source targets a 2015 DWD layout; published data handling is newer. Align in D4/M3 before rerendering. |
| `unit09-03_arima.Rmd` | `_unit09/unit09-03_arima.md` | Historical source has a different time window and chunk layout; descriptions follow its own plot calls. Align in D4/M3. |
| `unit10-02_time_series_analysis.Rmd` | `_unit10/unit10-02_time_series_analysis.md` | Historical source has an older time window; includes unpublished trend-test material. Align in D4/M3. |
| `unit10-03_time_series_clustering.Rmd` | `_unit10/unit10-03_time_series_clustering.md` | Historical source has an older time window; descriptions do not assert unchanged group membership. Align in D4/M3. |
| `unit11-02_colours.Rmd` | `_unit12/unit12-02_colours.md` | Current prose/code and figure descriptions synchronized; the legacy `e11-02` image directory is intentional. |
| `unit12-03_colour_maps.Rmd` | `_unit12/unit12-03_colour_maps.md` | Created from the current published lesson on 26.10.2026; no historical map Rmd was found. Uses Natural Earth boundaries and simulated values. |

Units 04–12 introductions, assignments, MOHA links and external-resource pages are maintained directly as Markdown unless listed above. Unit 12's workshop and R Graph Gallery links point to external material; the historical drafts below are not their sources.

## Historical drafts

| Source | Status |
|---|---|
| `unit11-01_plotting_advanced.Rmd` | Mixed crop/disaster draft with unresolved objects; no active published counterpart. |
| `unit11-03_plotting_tics.Rmd` | Matches the unpublished `staging/unit12-04_plotting_tics.md` draft. |
| `unit11-04_wide_long_format.Rmd` | Historical regional-data/lattice example; no active Unit-12 counterpart. The current Unit-04 reshaping source is listed separately. |

Keep these drafts separate from active course sources. Their preservation does not authorize publishing or blindly rendering them over current lessons.

## Figures and accessibility

Published plot images remain at their existing paths. Informative images have descriptions of their variables, panels and relevant patterns. Matching source chunks carry `fig.alt`, including a vector of descriptions where one chunk creates several figures. Nearby prose explains complex comparisons.

The two current Unit-12 sources accept `options(mpg.unit12.fig.path = "<temporary-figure-directory>/")` for isolated output. Their default `figures/` paths are portable; published asset URLs stay separate. The accessibility pass does not refresh historical datasets, RNG, model fits or raster files.
