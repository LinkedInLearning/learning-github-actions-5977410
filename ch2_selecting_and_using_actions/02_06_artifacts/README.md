# 02_06 Create and Use Artifacts

GitHub Actions allows workflows to save and share files called **artifacts**.

Artifacts can be anything from compiled binaries and log files to test results and deployment packages.

In this lesson, you’ll learn how to use artifacts to pass files between jobs in a GitHub Actions workflow. You’ll compile a Go web server for multiple platforms, store the resulting binaries as artifacts, and then download and test the binaries in separate jobs.

## Overview

This challenge will guide you through the following steps:

- Add the provided workflow file and Go program
- Run the workflow to:
  - upload artifacts using `actions/upload-artifact`
  - download artifacts using `actions/download-artifact`
- Observe how artifacts are used to share files between jobs

## Instructions

1. Create a new repository using the `Go` template for `.gitignore`.
1. Open the repo in the GitHub Web Editor.
1. Add the file [`web-server.go`](./web-server.go) to the root of your repository.

    The program defines a simple HTTP server that returns a random fun fact.

1. Create the `.github/workflows` directory in the root of your GitHub repository.
1. Add the file [`use-artifacts.yml`](./use-artifacts.yml) to the `.github/workflows` directory.
1. Examine the workflow:

    - Triggered on every push.
    - Contains three jobs: `build`, `test-linux`, and `test-windows`.

    1. `build`:

        - Checks out the repository
        - Compiles the `web-server.go` file for:
            - Linux (`web-server`)
            - Windows (`web-server.exe`)
        - Uploads both binaries as artifacts named `linux` and `windows` using the `actions/upload-artifact` action.

    1. `test-linux`:

        - Runs on `ubuntu-latest`
        - Waits for the `build` job to complete
        - Downloads the `linux` artifact using `actions/download-artifact`
        - Starts the Linux binary and makes test requests using `curl`

    1. `test-windows`:

        - Runs on `windows-latest`
        - Waits for the `build` job to complete
        - Downloads the `windows` artifact using `actions/download-artifact`
        - Runs the Windows binary directly

1. Commit your changes.
1. In your GitHub repository, go to the **Actions** tab and locate the latest workflow run for **Use Artifacts**.
1. Review the summary of the run:

   - Look for the **Artifacts** section to confirm that two artifacts were created.
   - Expand the **Build** job to view the steps where artifacts were uploaded.
   - Expand the **Test Linux** and **Test Windows** jobs to confirm that artifacts were downloaded and executed successfully.

<!-- FooterStart -->
---
[← 02_05 Use Secrets](../02_05_secrets/README.md) | [02_07 Challenge: Develop a Workflow That Creates Artifacts →](../02_07_challenge_develop_a_workflow_that_creates_artifacts/README.md)
<!-- FooterEnd -->
