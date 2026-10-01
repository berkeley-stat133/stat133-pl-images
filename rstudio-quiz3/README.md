# Quiz 3 RStudio workspace image

Custom PrairieLearn RStudio workspace image for Quiz 3, extending
`prairielearn/workspace-rstudio` with:

- **`tidyverse`** -- dplyr, ggplot2, readr, tidyr, forcats, stringr, purrr, tibble
  (lectures 12, 14, 15, 16).
- **`palmerpenguins`** -- the `penguins` dataset (lecture 14).
- **`stat133data`** (local package, source in `stat133data/`) -- bundles the
  `ev` dataset: the **`County`** sheet of the ZEV project's
  `New_ZEV_Sales_Last_updated_07-17-2026_ada.xlsx` (77,898 rows: `Data Year`,
  `Quarter`, `COUNTY`, `FUEL_TYPE`, `MAKE`, `MODEL`, `Number of Vehicles`).
  It loads with a plain `data(ev)` call, matching how `data(sampson)` worked
  for the `lda` package on Quiz 2. No `readxl`, `library()` call, or
  file/URL read is required; R's `data()` searches all installed packages
  for a matching dataset name when `package` isn't specified. Column names
  keep their original spaces, so backtick-quoting (`` `Number of Vehicles` ``)
  still applies.

Lecture 17 content (themes, scale transforms, `forcats::fct_reorder`) is out
of scope for Quiz 3, so nothing from that lecture was added.

The built image is consumed by `pl-ucb-stat133`'s `questions/r-studio/info.json`
(`workspaceOptions.image`), which points at
`ghcr.io/berkeley-stat133/pl-stat133-rstudio-quiz3:1.0`.

## Build & publish

The GitHub Actions workflow at
`.github/workflows/build-rstudio-quiz3-image.yml` (repo root) builds this
directory and pushes to GHCR using this repo's own `GITHUB_TOKEN` -- no local
Docker, PAT, or repo secrets needed. Trigger it from this repo's Actions tab
("Run workflow"), or push a change under `rstudio-quiz3/` to trigger it
automatically.

After any push, confirm the package is set to **Public** visibility at
`github.com/orgs/berkeley-stat133/packages` -- PrairieLearn's workspace host
needs to pull it without credentials.

Bump the tag (e.g. `:1.1`, and update it in `pl-ucb-stat133`'s
`questions/r-studio/info.json`) on any change to the Dockerfile or
`stat133data`, rather than relying solely on `:1.0`, so a bad build can't
silently replace what's running mid-quiz.

## Verifying

```sh
docker run --rm ghcr.io/berkeley-stat133/pl-stat133-rstudio-quiz3:1.0 \
  R -e 'library(tidyverse); library(palmerpenguins); data(ev); data(penguins); str(ev); str(penguins)'
```

`ev` should be a 77,898-row data frame with columns `Data Year`, `Quarter`,
`COUNTY`, `FUEL_TYPE`, `MAKE`, `MODEL`, `Number of Vehicles`.

## Updating the `ev` dataset

Source data lives at
`fall-2026-private/projects/3-electric-vehicles/data/New_ZEV_Sales_Last_updated_07-17-2026_ada.xlsx`
(sheet `"County"`) in the course content repo. If it changes, regenerate
`stat133data/data/ev.rda` by re-running `stat133data/data-raw/create-ev.R`,
then rebuild and re-push the image (bumping the tag as above).
