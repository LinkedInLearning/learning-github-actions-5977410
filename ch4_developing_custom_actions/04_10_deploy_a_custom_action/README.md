# 04_10 Deploy a Custom Action

With all the supporting files in place—Dockerfile, entrypoint script, metadata, and README—it’s time to use your custom action inside a real GitHub Actions workflow.

## Overview

In this lesson, you will:

- Upload a sample workflow file that uses your custom action.
- Trigger the workflow manually or by pushing to the repository.
- Review the results of the action run and verify its output.

## Instructions

> [!IMPORTANT]
> Before proceeding with this lab, please complete the steps to create a Codespace as described in [Add a Dockerfile](../04_04_add_a_dockerfile/README.md).

### Step 1: Upload the workflow file

1. In the Codespace, create the `.github/workflows` directory.
2. Upload the file named [`custom-action-workflow.yml`](./custom-action-workflow.yml).
3. Commit the uploaded workflow file to your repository.

### Step 2: Review and edit the workflow file

Open `custom-action-workflow.yml` and examine the contents:

- **Trigger**

  The workflow will run on both `push` events and when triggered manually via the `workflow_dispatch` event.

- **Job: `check-tests`**

  This job:

  - runs on `ubuntu-latest`
  - checks out the repository code using `actions/checkout@v4`
  - and runs your `test-scout` action using a reference to your own repo.

> [!IMPORTANT]
> Replace `YOUR_USERNAME/YOUR_CUSTOM_ACTION_REPO_NAME` with your actual GitHub username and the repository name where the custom action is defined.

```yaml
uses: YOUR_USERNAME/YOUR_CUSTOM_ACTION_REPO_NAME@main
with:
  pattern: 'test_*.py'
  strict_mode: 'false'
```

### Step 5: Verify the action output

1. Commit the workflow to the repository.
1. In the Actions tab, select the most recent workflow run.
1. Expand the **Run test-scout** step in the job log.
1. You should see output like:

   - Number of Python files found
   - Number of test files matching the pattern
   - Whether the script failed or passed based on `strict_mode`

This confirms that:

- The container built from your Dockerfile ran successfully.
- The `entrypoint.sh` logic executed properly.
- The metadata in `action.yml` configured the action correctly.

Experiment with the workflow and custom action by:

- Adding files to the repo ending in `.py` and named `test_*.py`
- Enabling strict mode and viewing the results when no test files are present. _*Note: Use `true` (case sensitive!) to enable strict mode.*_

In the next lesson, we’ll walk through the steps required to publish your action to the GitHub Marketplace.

<!-- FooterStart -->
---
[← 04_09 Add a README File](../04_09_add_a_readme_file/README.md) | [04_11 Publish an Action to the Marketplace →](../04_11_publish_an_action_to_the_marketplace/README.md)
<!-- FooterEnd -->
