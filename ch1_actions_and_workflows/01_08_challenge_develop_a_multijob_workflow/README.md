# 01_08 Challenge: Develop a Multi-Job Workflow

In this challenge, you’ll create a GitHub Actions workflow that compiles and runs Go code across multiple operating systems.

You’ll also add a final job that performs cross-compilation to build binaries for multiple platforms.

## Overview

You will complete the following steps in this challenge:

1. **Create a new GitHub repository** using the Go `.gitignore` template.
2. **Open the repository in the GitHub Web Editor** to add code and workflows.
3. **Create the file `main.go` file**.
4. **Add a multi-job workflow** triggered by `push` events with four jobs:

   * One job each for Ubuntu, Windows, and macOS.
   * A fourth job that runs after the first three jobs complete.

5. **Push changes to the repository** to trigger the workflow.
6. **Review the Actions tab** to confirm the workflow executed successfully on all platforms.

This challenge should take about 15 to 20 minutes to complete.

<!-- FooterStart -->
---
[← 01_07 Workflow and Action Limits](../01_07_workflow_action_limits/README.md) | [01_09 Solution: Develop a Multi-Job Workflow →](../01_09_solution_develop_a_multijob_workflow/README.md)
<!-- FooterEnd -->
