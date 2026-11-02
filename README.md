# vs-code-galway-Statistics_AI

A Docker-based R 4.5 environment for the Statistics for AI module, used from VS Code (Dev Containers) or from RStudio in the browser.

## Prerequisites

- Docker Desktop (with the WSL 2 backend on Windows), running
- VS Code with the **Dev Containers** extension (`ms-vscode-remote.remote-containers`)

## Project layout

```
.devcontainer/devcontainer.json   VS Code Dev Container config (uses the "lab" service)
Dockerfile                        rocker/tidyverse:4.5.1 (R + RStudio Server + tidyverse) + r-packages.txt
docker-compose.yml                service "lab": RStudio Server on 127.0.0.1:8787
r-packages.txt                    extra R packages
data/                             datasets (read-only inside the container, not in git)
scripts/                          R scripts and R Markdown files
src/                              helpers (src/check_env.R checks the setup)
figures/                          saved plots
report/                           report files
notes/                            study notes
```

## Setup

1. Put the datasets in `data/`. Inside the container it's mounted **read-only** at `/workspace/data`.

2. Choose **one** way to start the environment:

   **Option A: VS Code (recommended)**
   1. Open the folder `D:\DevContainers\vs-code-galway-Statistics_AI` in VS Code.
   2. Run **Dev Containers: Reopen in Container** from the Command Palette (Ctrl+Shift+P).
   3. The first build takes a few minutes. When it finishes, `src/check_env.R` runs automatically and prints the package versions.
   4. Open an `.R` file and press **Ctrl+Enter** to send the current line to the R terminal.

   **Option B: RStudio in the browser**
   1. From the project folder, run:
      ```
      docker compose up --build
      ```
   2. Open `http://127.0.0.1:8787` (no password; the port is only reachable from this computer).
   3. In RStudio, open the project files under `/workspace`.
   4. Stop it with Ctrl+C, then `docker compose down`.

   RStudio Server also runs while the VS Code container is open, so both can be used at the same time.

3. Check the environment at any time:
   ```
   docker compose run --rm lab Rscript src/check_env.R
   ```
   Or, inside the VS Code container terminal:
   ```
   Rscript src/check_env.R
   ```

## Updating packages

Edit `r-packages.txt`, then rebuild:
- In VS Code: **Dev Containers: Rebuild Container**
- From the command line: `docker compose build`

To try a package without rebuilding, run `install.packages("name")` in R. It is lost when the container is rebuilt, so add it to `r-packages.txt` to keep it.
