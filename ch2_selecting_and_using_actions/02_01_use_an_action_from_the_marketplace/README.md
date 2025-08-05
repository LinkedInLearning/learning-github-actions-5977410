# 02_01 Use an Action From the Marketplace

In this lesson, you'll learn how to use an action from the GitHub Marketplace. GitHub Actions provides thousands of pre-built actions that can automate tasks like code scanning, testing, deployment, and more.

You'll explore the Marketplace interface, install an action to scan a CloudFormation template, and trigger a workflow to view the results.

## Overview

You will complete the following steps:

* Create the required `.github/workflows` directory
* Upload a sample CloudFormation template
* Upload a pre-written workflow file
* Use the GitHub Marketplace to find and install a relevant action
* Update the workflow with the selected action
* Commit your changes and view the results in the Actions tab


## Instructions

### Step 1: Create the Workflows Directory

1. In your repository, create a new folder named `.github`.
2. Inside `.github`, create another folder named `workflows`.

> Your final directory path should look like `.github/workflows`.


### Step 2: Upload the Provided Files

Upload the following files to the root of your repository:

* `cloudformation-template.yml` (you can find this in your exercise files)

Also upload the following workflow file to the directory you just created:

* `scan-cloudformation-template.yml` → Place this in `.github/workflows/`

> Be sure to include any hidden files (such as `.gitignore` or `.dockerignore`) if they’re provided with your exercise files. These files are important for workflow behavior and exclusions.


### Step 3: Open the Workflow File in GitHub

1. Navigate to the `.github/workflows` directory in your GitHub repository.
2. Select the `scan-cloudformation-template.yml` file.
3. Select the pencil icon in the upper-right corner to open the file for editing.


### Step 4: Use the GitHub Marketplace to Find an Action

1. In the right-hand panel of the editor, look for the **Marketplace** sidebar.
2. Scroll to the bottom to view **Featured Categories** like "Code Quality" and others.
3. Scroll back up and select into the **Search bar**.
4. Type `AWS` to filter actions related to AWS.
5. Type `SCAN` to further narrow the list.
6. Select the **AWS Sustainability Scanner** from the list.


### Step 5: Add the Action to Your Workflow

1. From the Marketplace preview panel, locate the **stacked squares icon** (copy snippet button) under the Installation section.
2. Select the icon to copy the YAML snippet for the action.
3. Back in the YAML editor, paste the snippet inside the `steps` section of the `scan` job.
4. Fix any indentation errors shown by the syntax checker (GitHub will highlight the problem lines).
5. Remove the `with:` block and its parameters—these are optional and not needed for now.


### Step 6: Review the Full Marketplace Listing (Optional)

1. Select **View full Marketplace listing** to open the action's dedicated page in a new tab.
2. Review example workflows, repository links, and documentation.
3. Use the green **Use Latest Version** button if you want to copy the snippet again from this page.


### Step 7: Commit Your Changes

1. Return to the GitHub editor tab.
2. Scroll down and enter a commit message, such as “Added AWS Sustainability Scanner”.
3. Select **Commit changes** to save and push your updates to the repository.


### Step 8: Run and Review the Workflow

1. Go to the **Actions** tab in your repository.
2. Wait for the `Scan CloudFormation Template` workflow to complete.
3. Select the most recent run from the list.
4. Expand the job titled **AWS Sustainability Scanner GitHub Action** by selecting the twist arrow.
5. Review the output. If successful, you’ll see green check marks and a section showing suggestions for improvements to your CloudFormation template.

<!-- FooterStart -->
---
[← 01_09 Solution: Develop a Multi-Job Workflow](../../ch1_actions_and_workflows/01_09_solution_develop_a_multijob_workflow/README.md) | [02_02 Use an Action From a Repository →](../02_02_use_an_action_from_a_repository/README.md)
<!-- FooterEnd -->
