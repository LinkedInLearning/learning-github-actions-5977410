# 04_10 Deploy a Custom Action

With all the supporting files in place—Dockerfile, entrypoint script, metadata, and README—it’s time to use your custom action inside a real GitHub Actions workflow.


## Overview

In this lesson, you will:

- Upload a sample workflow file that uses your custom action.
- Trigger the workflow manually or by pushing to the repository.
- Review the results of the action run and verify its output.


## Instructions

### Step 1: Open your repository in a GitHub Codespace

1. Navigate to your public GitHub repository.
2. Launch a Codespace using the **Code > Codespaces** menu.

### Step 2: Upload the workflow file

1. In the Codespace, open the `.github/workflows` directory.
2. Upload the file named `custom-action-workflow.yml` from the lesson folder `04_10_deploy_a_custom_action`.
3. Commit the uploaded workflow file to your repository.

### Step 3: Review the workflow file

Open `custom-action-workflow.yml` and examine the contents:

- **Trigger**
  The workflow will run on both `push` events and when triggered manually via the `workflow_dispatch` event.

- **Job: `check-tests`**
  This job runs on `ubuntu-latest`, checks out the repository code using `actions/checkout@v4`, and runs your `test-scout` action using a reference to your own repo.

```yaml
uses: YOUR_USERNAME/YOUR_CUSTOM_ACTION_REPO_NAME@main
with:
  pattern: 'test_*.py'
  strict_mode: 'false'
```

> ✏️ Replace `YOUR_USERNAME/YOUR_CUSTOM_ACTION_REPO_NAME` with your actual GitHub username and the repository name where the custom action is defined (if not already done).

### Step 4: Trigger the workflow

You can trigger the workflow in one of two ways:

- **Option A: Manual trigger**

  1. Go to the **Actions** tab in your GitHub repo.
  2. Select the workflow and click **Run workflow**.

- **Option B: Push trigger**

  1. Make a small change to your repo (e.g., add a comment in the README).
  2. Commit and push the change to the main branch.

### Step 5: Verify the action output

1. In the Actions tab, select the most recent workflow run.
2. Expand the **Run test-scout** step in the job log.
3. You should see output like:

   - Number of Python files found
   - Number of test files matching the pattern
   - Whether the script failed or passed based on `strict_mode`

This confirms that:

- The container built from your Dockerfile ran successfully.
- The `entrypoint.sh` logic executed properly.
- The metadata in `action.yml` configured the action correctly.


TODO: FIX THIS -> You’ve now successfully deployed and tested your custom action inside a GitHub Actions workflow. In the next lesson, we’ll walk through the steps required to publish your action to the GitHub Marketplace.

<!-- FooterStart -->
---
[← 04_09 Add a README File](../04_09_add_a_readme_file/README.md) | [04_11 Publish an Action to the Marketplace →](../04_11_publish_an_action_to_the_marketplace/README.md)
<!-- FooterEnd -->
