# stat133-pl-images

Public Docker images used by STAT 133's PrairieLearn course (`pl-ucb-stat133`) for
workspaces and external graders.

This repo is intentionally separate from the course content repos
(`pl-ucb-stat133`, `fall-2026-private`). PrairieLearn's workspace images must be
pullable without credentials, so the repo that builds and publishes them needs
to be public -- it does not need to be the course content repo itself, and
keeping it separate avoids depending on `pl-ucb-stat133`'s GitHub Actions
permissions (that repo is owned by the `PrairieLearn` org, where course staff
have collaborator but not admin access).

## Images

- [`rstudio-quiz3/`](rstudio-quiz3/) -- Quiz 3's custom RStudio workspace image
  (`prairielearn/workspace-rstudio` + tidyverse + palmerpenguins + a small
  `stat133data` package providing `data(zev)`). Published to
  `ghcr.io/berkeley-stat133/stat133-pl-images-rstudio-quiz3`.

## Publishing

Each image subdirectory has its own build instructions; the workflows live in
`.github/workflows/` at the repo root and build and push to GHCR using this
repo's own `GITHUB_TOKEN` -- no PAT or repo secrets required, since GHCR
packages are namespaced by repo owner (`berkeley-stat133`), which this repo's
default token already has write access to.

After any new image's first publish, go to
`github.com/orgs/berkeley-stat133/packages`, find the package, and set its
visibility to **Public** -- PrairieLearn's workspace host must pull images
without credentials, and GHCR packages default to private regardless of the
source repo's own visibility.
