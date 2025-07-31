# 03_02 Linting and Unit Tests

In this lesson, you'll take the first step toward building a reliable CI/CD pipeline by implementing linting and unit testing.

These early checks catch formatting errors, enforce coding standards, and ensure code correctness before any deployment happens.

Using GitHub Actions, you’ll run automated jobs that lint Python code and validate it with unit tests every time code is pushed to your repository.

## Overview

Follow along by completing these steps:

- Create a new repo and set up the `.github/workflows` directory.
- Upload the provided application files.
- Review the development requirements and test suite.
- Add the provided GitHub Actions workflow to run linting and unit tests.
- Trigger the workflow and review the results in the Actions tab.

## Instructions

### Setup

1. **Create a new GitHub repository** using the Python `.gitignore` template.
1. **Open the repository in the GitHub Web Editor**.
1. Upload the exercise files to the root of the repository.

    ```bash
    .dockerignore
    .gitignore
    data.json
    development-requirements.txt
    Dockerfile
    main.py
    Makefile
    pipeline.yml
    README.md
    requirements.txt
    test_cyclones.py
    test_main.py
    ```

1. Create a new directory named `.github/workflows`.
1. Move the workflow file [pipeline.yml](./pipeline.yml) into the `.github/workflows` directory.

### Review the development requirements

1. Open `development-requirements.txt`.
2. Confirm that it lists the following dependencies:

   - Flask
   - waitress
   - flake8
   - pylint
   - black
   - isort

3. These packages are required for developing the application and for the linting and testing steps in your workflow.

### Review the test suite

1. Open `test_main.py` and `test_cyclones.py`.
2. Review the unit tests that check specific functionality in the application without requiring the code to be compiled or deployed.

### Review the workflow

1. Open `pipeline.yml` in the `.github/workflows` directory.
2. Confirm that the workflow is triggered on both `push` and `workflow_dispatch` events.
3. Review the job named `lint-and-test`.
4. Within this job, observe the following steps:

   - The code is checked out using the `actions/checkout` action.
   - A Python environment is set up with version 3.13.
   - Development dependencies are installed using `pip install --requirement development-requirements.txt`.
   - Linting is performed using both `flake8` and `pylint`.
   - Unit tests are run using Python’s built-in `unittest` module.

### Commit and push your changes

1. Commit all of your changes, including the uploaded files and workflow.
1. Push the changes to your GitHub repository.

### Run and observe the workflow

1. Navigate to the **Actions** tab in your GitHub repository.
1. Look for a new workflow run triggered by your push.
1. Open the latest run and select the job named `lint-and-test`.

### Review the results

1. Select the step labeled **Lint code**.
1. Confirm that flake8 and pylint ran without any reported issues.
1. Select the step labeled **Run unit tests**.
1. Confirm that all unit tests passed.

<!-- FooterStart -->
---
[← 03_01 Plan Your CI/CD Pipeline](../03_01_plan_your_cicd_pipeline/README.md) | [03_03 Building and Managing Artifacts →](../03_03_building_managing_artifacts/README.md)
<!-- FooterEnd -->
