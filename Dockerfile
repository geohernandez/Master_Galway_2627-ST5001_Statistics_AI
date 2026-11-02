# rocker/tidyverse = R + RStudio Server + tidyverse, rmarkdown and the system
# libraries they need. Packages install as pre-built binaries (Posit Package
# Manager), so the build is fast.
FROM rocker/tidyverse:4.5.1

# git: so VS Code source control works inside the container
RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Extra R packages, one per line in r-packages.txt (lines starting with # are ignored)
COPY r-packages.txt /tmp/r-packages.txt
RUN install2.r --error --skipinstalled $(grep -v '^\s*#' /tmp/r-packages.txt | tr '\n' ' ')

# RStudio Server listens on 8787 (started by the image's default command, /init)
EXPOSE 8787
