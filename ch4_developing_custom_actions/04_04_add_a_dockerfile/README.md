# 04_04 Add a Dockerfile

# 04_04 – Add a Dockerfile

Now that we’ve defined the objective of our custom GitHub Action, it’s time to begin building it. In this lesson, we’ll focus on adding the Dockerfile that defines the container environment for our action.

GitHub Codespaces provides everything we need to build and test our action without needing to install any tools locally.

## References

- <https://github.com/codespaces>
- <https://docs.github.com/en/billing/concepts/product-billing/github-codespaces>

## Overview

In this lesson, you will:

- Open a GitHub Codespace for your public action repository.
- Create the `.github/workflows` directory.
- Upload the provided workflow file to test the action.
- Upload the provided `Dockerfile` to define the container image.
- Review the Dockerfile to understand each instruction.


## Instructions

### Step 1: Open your GitHub repository in a Codespace

1. Navigate to your public GitHub repository for the custom action.
2. Select the `Code` dropdown and choose **Codespaces > Create codespace on main**.

### Step 2: Create the workflows directory

1. In the Codespace editor, open the file explorer.
2. Right-click the root directory and choose **New Folder**.
3. Name the folder: `.github`
4. Right-click on the `.github` folder and create a subfolder named: `workflows`

### Step 3: Upload the workflow file

1. In the file explorer, open `.github/workflows`.
2. Select the “Upload Files” button (or drag and drop the file).
3. Upload the file `custom-action-workflow.yml` (provided in the exercise files).
4. Confirm the upload by committing the changes to the repository.

### Step 4: Upload the Dockerfile

1. At the root of your repository (outside of any folders), select “Upload Files.”
2. Upload the provided `Dockerfile` (included in the lesson folder `04_04_add_a_dockerfile`).
3. Commit the uploaded Dockerfile to your repository.

### Step 5: Review the Dockerfile contents

Once the file is in place, open the `Dockerfile` in the editor and review the following sections:

- **`FROM ubuntu:22.04`**
  This sets the base image for the container to Ubuntu 22.04.

- **`RUN apt update && apt install`**
  This installs essential packages:
  - `bash` for scripting
  - `curl` for making HTTP requests
  - `jq` for parsing JSON

- **`COPY entrypoint.sh /usr/local/bin/`**
  This adds the `entrypoint.sh` script (which you’ll upload in the next lesson) to the container’s binary path.

- **`ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]`**
  This tells the container what script to run when the action is triggered.

Once you've reviewed the Dockerfile, you're ready to move on to the next step—adding the `entrypoint.sh` script that will contain the logic for your action.

<!-- FooterStart -->
---
[← 04_03 Dockerfile Review](../04_03_dockerfile_review/README.md) | [04_05 Add an Entry-Point Script →](../04_05_add_an_entrypoint_script/README.md)
<!-- FooterEnd -->
