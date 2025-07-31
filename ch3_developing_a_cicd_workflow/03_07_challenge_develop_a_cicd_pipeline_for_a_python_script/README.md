# 03_07 Challenge: Develop a CI/CD Pipeline for a Python Script

In this challenge, you’ll develop a GitHub Actions workflow for a Python script.

The goal is to build a full CI/CD pipeline that includes linting and tests, artifact creation, and artifact testing.

You’ll also configure your workflow to use the GitHub Container Registry (GHCR) to store and retrieve the image.

## Overview

You will complete the following steps in this challenge:

1. **Create a new GitHub repository** using the Python `.gitignore` template
2. **Use the repository in the GitHub Web Editor** to add code and workflows
3. **Add the provided files**:

   - [`hello.py`](./hello.py) (Python script)
   - [`Dockerfile`](./Dockerfile) (for building the image)
   - [`.dockerignore`](./.dockerignore) (for building the image)
   - [`python-pipeline.yml`](./python-pipeline.yml) (your CI/CD workflow)

4. **Implement a three-stage pipeline**:

   - Lint and test the Python code
   - Build and push the container image to GHCR
   - Pull and run the image to verify output

    ```mermaid
    graph LR
        A[Lint and test the Python code] --> B[Build and push the container image to GHCR]
        B --> C[Pull and run the image to verify output]
    ```

5. **Push changes to the repository** and confirm the workflow runs successfully

This challenge should take about 15 minutes to complete.

<!-- FooterStart -->
---
[← 03_06 Add a Workflow Status Badge](../03_06_add_a_workflow_status_badge/README.md) | [03_08 Solution: Develop a CI/CD Pipeline for a Python Script →](../03_08_solution_develop_a_cicd_pipeline_for_a_python_script/README.md)
<!-- FooterEnd -->
