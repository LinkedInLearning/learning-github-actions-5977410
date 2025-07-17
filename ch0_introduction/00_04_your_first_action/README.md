# 00_04 Your First Action

In this lesson, you'll create and run your very first GitHub Actions workflow.

This example will introduce you to the GitHub Actions interface and demonstrate how a workflow is triggered by a push event. You'll start with a predefined example, make a few adjustments, and then execute a job that prints "Hello World" — the traditional start for any new project.

By the end of this lesson, you’ll understand how to create a workflow file, customize the workflow contents, commit the workflow file to the repository, and verify that the workflow runs as expected.

## Overview

You’ll complete the following steps to run your first GitHub Action:

1. Use a template to create a workflow.
1. Rename the workflow file and the workflow name.
1. Commit the workflow to trigger the action.
1. View the results of the job execution.

Use the following file for reference:

- [hello.yml](./hello.yml)

## Instructions

1. Open the Actions Tab

    - Navigate to your newly created GitHub repository.
    - Select the **Actions** tab at the top of the page.

1. Configure a Simple Workflow

    - On the Actions page, you’ll see sample workflows provided by GitHub.
    - Find the **Simple Workflow** example and select the **Configure** button.

1. Rename the Workflow File

    - At the top of the editor, GitHub names the file `blank.yml` by default.
    - Rename the file to `hello.yml`.

1. Collapse the Help Panel

    - To focus on the editor, collapse the help panel by selecting the icon on the right side of the screen.

1. Rename the Workflow

    - In the editor, find the line that reads `name: CI`.
    - Change the name to `hello`.

1. Review the Workflow Configuration.

    Take note of the following:

    - The workflow defines a job named `build`.
    - The job specifies a runner platform (`ubuntu-latest`).
    - Under `steps`, the job includes two script steps that print "Hello World".

1. Commit the Workflow File

    - Select the green **Commit changes** button.
    - On the confirmation dialog, select **Commit changes** again.
    - This writes the file to your repository and triggers a push event.

1. View the Workflow Run

    - Select the **Actions** tab again.
    - You should now see a new entry for your `hello` workflow.
    - Wait for the workflow to complete. You may need to refresh the page.
    - Look for the green check mark indicating success.

1. Inspect the Workflow Details

    - Select the `Create hello.yml` entry next to the green check mark.
    - On the next screen, you'll see the `build` job listed.
    - Select the **build** job to view the steps it executed.

1. Expand and Verify the Output

    - Expand the steps labeled:
        - `Run a one-line script`
        - `Run a multi-line script`
    - Review the output from each step.

<!-- FooterStart -->
---
[← 00_03 Working With YAML Files](../00_03_working_with_yaml_files/README.md) | [00_05 Workflow and Action Attributes →](../00_05_workflow_action_attributes/README.md)
<!-- FooterEnd -->
