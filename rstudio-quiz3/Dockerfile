# Custom PrairieLearn RStudio workspace image for the Stat 133 quizzes (first
# built for Quiz 3; every quiz's r-studio workspace uses it).
#
# Adds: tidyverse and palmerpenguins.
# 1.1 adds the spatial packages for Quiz 5 (Spatial Data I and II): sf,
# lwgeom, rnaturalearth, and rnaturalearthdata (offline country maps).
#
# Build (from this directory):
#   docker build -t ghcr.io/berkeley-stat133/stat133-pl-images-rstudio-quiz3:1.1 .
# The GitHub Actions workflow builds and pushes it (see README.md).
# pl-ucb-stat133's questions/r-studio/info.json points workspaceOptions.image
# at the tag in use.

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
  install.packages(c('tidyverse', 'palmerpenguins')); \
  library(tidyverse); library(palmerpenguins)"

# Spatial packages for Quiz 5. sf and lwgeom link against GDAL, GEOS, PROJ,
# and udunits. They install as precompiled binaries from Posit Package
# Manager for this image's Ubuntu release, at the same snapshot date as the
# tidyverse above, so the build stays well inside the workflow's timeout.
# The -dev packages pull in the runtime libraries the binaries need.
RUN apt-get update && apt-get install -y --no-install-recommends \
      libgdal-dev \
      libgeos-dev \
      libproj-dev \
      libudunits2-dev \
      libsqlite3-dev \
  && rm -rf /var/lib/apt/lists/*

RUN codename=$(. /etc/os-release && echo "$VERSION_CODENAME") \
  && R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/${codename}/2026-09-30')); \
  install.packages(c('sf', 'lwgeom', 'rnaturalearth', 'rnaturalearthdata')); \
  library(sf); library(lwgeom); library(rnaturalearth); library(rnaturalearthdata)"

USER 1001
