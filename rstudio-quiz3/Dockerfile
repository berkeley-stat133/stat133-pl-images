# Custom PrairieLearn RStudio workspace image for Quiz 3.
#
# Adds: tidyverse, palmerpenguins, and a small local "stat133data" package
# that bundles the `ev` dataset (the "County" sheet of the ZEV project's
# New_ZEV_Sales_*.xlsx) so students can load it with a plain `data(ev)` call
# -- no readxl, file path, or internet access needed during the quiz.
#
# Build (from this directory):
#   docker build -t ghcr.io/berkeley-stat133/pl-stat133-rstudio-quiz3:1.0 .
# Push (see README.md for the one-time login/visibility steps):
#   docker push ghcr.io/berkeley-stat133/pl-stat133-rstudio-quiz3:1.0
# questions/r-studio/info.json's workspaceOptions.image already points at
# this tag.

FROM prairielearn/workspace-rstudio

# The base image runs as a non-root user by default (PrairieLearn always
# launches workspace containers with --user 1001:1001 in production anyway,
# so this doesn't change runtime behavior). Root is needed here for
# apt-get and so later COPY'd files can be cleaned up.
USER root

# System libraries required to compile the full tidyverse from source
# (not present in the base image): libcurl (curl/httr), libxml2 (xml2/
# rvest), fontconfig+freetype (systemfonts/ragg/textshaping), zlib (haven),
# libuv (fs).
RUN apt-get update && apt-get install -y --no-install-recommends \
      libcurl4-openssl-dev \
      libssl-dev \
      libxml2-dev \
      zlib1g-dev \
      libuv1-dev \
      libfontconfig1-dev \
      libfreetype6-dev \
      libharfbuzz-dev \
      libfribidi-dev \
      libpng-dev \
      libtiff5-dev \
      libjpeg-dev \
  && rm -rf /var/lib/apt/lists/*

# Pin CRAN to a snapshot for reproducible builds. The trailing library()
# calls make a silent partial-install (install.packages() alone doesn't
# fail the shell on a per-package dependency error) turn into a hard
# Docker build failure instead.
RUN R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/2026-09-30')); \
  install.packages(c('tidyverse', 'palmerpenguins', 'remotes')); \
  library(tidyverse); library(palmerpenguins)"

COPY stat133data /tmp/stat133data
RUN R -e "remotes::install_local('/tmp/stat133data', dependencies = FALSE, upgrade = 'never')" \
  && rm -rf /tmp/stat133data

USER 1001
