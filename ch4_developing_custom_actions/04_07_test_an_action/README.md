# 04_07 Test an Action

Before deploying your custom action in a workflow, it’s a good idea to test it locally.

In this lesson, we’ll use a `Makefile` to simplify local development and testing inside a GitHub Codespace.

## Overview

In this lesson, you will:

- Upload the `Makefile` provided with this lesson.
- Use `make` targets to build the image and test the script or container.
- Review updates to the `entrypoint.sh` script.
- Run tests from the integrated terminal in GitHub Codespaces.

## Instructions

> [!IMPORTANT]
> Before proceeding with this lab, please complete the steps to create a Codespace as described in [Add a Dockerfile](../04_04_add_a_dockerfile/README.md).

### Step 1: Upload the `Makefile`

1. At the root of your repository, upload the following files for this lesson:

    - [`Makefile`](./Makefile).
    - [`entrypoint.sh`](./entrypoint.sh)

1. Commit the uploaded files to your repository.

### Step 2: Review the `Makefile`

Open the `Makefile` and review the predefined targets:

- **Variable: `PATTERN = test_*.py`**

  This sets the default filename pattern used to detect test files.

- **`make build`**

  Builds the Docker image using the current directory and tags it as `test-scout`.

- **`make run`**

  Runs the image with the local project directory mounted into the container, allowing the container to access your repo files.

- **`make test-script`**

  Runs the `entrypoint.sh` script directly in the Codespace using the local environment.

- **`make test-image`**

  Runs the Docker container and executes the `entrypoint.sh` script inside it using the compiled image.

These targets make testing and iteration easier during development.

### Step 3: Review the updated `entrypoint.sh`

1. Open `entrypoint.sh` in the editor.
2. Scroll through the file and note the logic implemented:

   - Use of `$GITHUB_` environment variables
   - Count total Python files in the repo.
   - Count test files based on the provided pattern.
   - Report a warning if no tests are found.
   - Optionally fail the run if strict mode is enabled.

### Step 4: Run a local test

1. Open the **terminal** in your Codespace (View > Terminal).
1. Execute the script directly to test the logic:

   ```bash
   make test-script
   ```

1. Build the container image and run a test with the resulting image:

   ```bash
   make test-image
   ```

This allows you to quickly verify that your script and container image work before using the action in a workflow.

With the `Makefile` and test logic in place, you now have a fast, repeatable way to test and refine your custom GitHub Action during development.

<!-- FooterStart -->
---
[← 04_06 Use Runtime Environment Resources](../04_06_use_runtime_environment_resources/README.md) | [04_08 Add a Metadata File →](../04_08_add_a_metadata_file/README.md)
<!-- FooterEnd -->
