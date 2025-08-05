# 03_06 Add a Workflow Status Badge

Now that your CI/CD pipeline is fully functional, it's time to showcase it.

In this lesson, you’ll learn how to add a GitHub Actions **status badge** to your repository’s README file. A badge provides a visual indicator of your workflow's current state—whether it's passing, failing, or in progress.

## Overview

You will:

- Generate a status badge using GitHub’s built-in tools
- Copy the badge's Markdown code
- Paste the badge into your repository’s README file
- Preview and commit the change

## References

- [Adding a workflow status badge](https://docs.github.com/en/actions/how-tos/monitor-workflows/add-a-status-badge)
  - [Status for branches](https://docs.github.com/en/actions/how-tos/monitor-workflows/add-a-status-badge#using-the-branch-parameter)
  - [Status for events](https://docs.github.com/en/actions/how-tos/monitor-workflows/add-a-status-badge#using-the-branch-parameter)

## Instructions

> [!IMPORTANT]
> Before proceeding with this lab, please complete the steps in the previous lesson: [Deploying](../03_05_deploying/README.md).

### Step 1: Open the Workflow Page

1. Go to your repository on GitHub.
1. Select on the **Actions** tab.
1. From the list of workflows on the left, select the one you want to track (e.g., `Pipeline`).

### Step 4: Create a Status Badge

1. In the top-right corner of the workflow’s page, select the **three-dot menu** next to the “Filter workflow runs” search box.
1. From the dropdown menu, select **Create status badge**.
1. Choose the branch and event you want the badge to reflect (default is `main`).
1. Select the **Copy Markdown** button to copy the generated badge code.

### Step 3: Add the Badge to the README File

1. Return to the **Code** tab of your repository.
1. Open the `README.md` file.
1. Select the **pencil icon** to edit the file.
1. At the top of the file (or wherever you prefer), paste the Markdown snippet you copied earlier.

### Step 4: Preview and Commit

1. Select the **Preview changes** tab to make sure the badge renders correctly.
1. If everything looks good, commit the file and include a commit message (e.g., “Add workflow status badge”).
1. Choose **Commit directly to the `main` branch** and select **Commit changes**.

### Step 5: Verify

- Go back to the **repository home page** and confirm that the badge now appears in the README.
- The badge should reflect the current status of your latest workflow run.

<!-- FooterStart -->
---
[← 03_05 Deploying](../03_05_deploying/README.md) | [03_07 Challenge: Develop a CI/CD Pipeline for a Python Script →](../03_07_challenge_develop_a_cicd_pipeline_for_a_python_script/README.md)
<!-- FooterEnd -->
