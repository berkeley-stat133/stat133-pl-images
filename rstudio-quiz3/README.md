# Quiz 3 RStudio workspace image

Custom PrairieLearn RStudio workspace image for Quiz 3, extending
`prairielearn/workspace-rstudio` with:

- **`tidyverse`** -- dplyr, ggplot2, readr, tidyr, forcats, stringr, purrr, tibble
  (lectures 12, 14, 15, 16).
- **`palmerpenguins`** -- the `penguins` dataset (lecture 14).
- **`sf`**, **`lwgeom`**, **`rnaturalearth`**, **`rnaturalearthdata`** (added in
  `:1.1`, for Quiz 5) -- simple features and geometry operations (lectures 23
  and 24) and country maps that load without internet access
  (`ne_countries(country = "norway", returnclass = "sf")`).
- **`tidymodels`**, **`kknn`**, **`kernlab`** (added in `:1.2`, for Quiz 6) --
  prediction and classification with tidymodels (lectures 31 and 32), and the
  `spam` data set from PS 6.
- **`httr2`**, **`jsonlite`** (added in `:1.2`) -- the APIs lectures (33, 34).
- **`devtools`**, **`usethis`**, **`roxygen2`**, **`testthat`**, **`babynames`**
  (added in `:1.2`) -- building, documenting, and testing a package (lecture 29).

Lecture 17 content (themes, scale transforms, `forcats::fct_reorder`) is out
of scope for Quiz 3, so nothing from that lecture was added.

The built image is consumed by `pl-ucb-stat133`'s `questions/r-studio/info.json`
(`workspaceOptions.image`), which points at
`ghcr.io/berkeley-stat133/stat133-pl-images-rstudio-quiz3:1.2` (`:1.1` is the
Quiz 5 image, without the Quiz 6 packages; `:1.0` is the
Quiz 3 and 4 image, without the spatial packages; it also bundled a `zev`
data set in a local `stat133data` package, removed in `:1.1` because no
question used it).

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

Bump the tag (e.g. `:1.2`, and update it in `pl-ucb-stat133`'s
`questions/r-studio/info.json`) on any change to the Dockerfile, rather
than relying solely on one tag, so a bad build can't
silently replace what's running mid-quiz.

## Verifying

```sh
docker run --rm --network none --entrypoint R \
  ghcr.io/berkeley-stat133/stat133-pl-images-rstudio-quiz3:1.2 \
  -e 'library(tidyverse); library(palmerpenguins); library(sf); library(rnaturalearth); library(tidymodels); library(kknn); library(httr2); library(devtools); str(penguins); ne_countries(country = "norway", returnclass = "sf")'
```

The workflow's smoke test runs the same checks with networking off.
