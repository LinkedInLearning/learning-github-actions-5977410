# 01_04 Run a Workflow

With a complete workflow configured with a trigger, jobs, actions, and commands, it’s time to run it and view the results.

In this lesson, you’ll commit the workflow file to your repository to trigger a run, and then explore the GitHub Actions tab to see job and step outputs.

## Overview

In this lesson, you will:

- Commit and push the workflow file to trigger the workflow.
- Navigate to the Actions tab to monitor the workflow run.
- Inspect individual jobs and steps for success indicators and output.
- Compare output differences between Ubuntu and Windows runners.

## Instructions

1. In the GitHub web editor, select the **Source Control** tab from the menu on the left-hand side.
1. Enter a commit message. For example, `add first workflow`.
1. Select the **Commit & Push** button.

    Note: The exact button label might vary depending on your setup, but it will typically include "Commit".

1. At the top of the left-hand navigation panel, select **Go to Repository**.
1. In the repository view, select the **Actions** tab.
1. You should see a workflow run listed with a label matching your commit message.
1. Select that workflow run to open the details.
1. You’ll see both jobs listed with green checkmarks—this indicates success.
1. Select the **First Job** to expand its details.
1. Expand **Step One** by selecting the twist arrow next to it. You’ll see output from the `checkout` action syncing the repo to the runner.
1. Expand **Step Two** to view the results of the `env | sort` command. This output reflects environment variables from the Ubuntu runner.
1. Select the **Second Job**.
1. Expand **Step Two** to view the output of `Get-ChildItem Env: | Sort-Object Name`.
1. Confirm that the output reflects a Windows environment (e.g., file paths that include `C:\`).

Your workflow has run two jobs in parallel—one on Ubuntu and one on Windows—with each executing the defined steps and commands.

In the next lesson, you'll learn how to set job dependencies so that jobs can run in a specific order instead of in parallel.

<!-- FooterStart -->
---
[← 01_03 Add Actions to a Workflow](../01_03_add_actions_to_a_workflow/README.md) | [01_05 Add Dependencies Between Jobs →](../01_05_add_dependencies_between_jobs/README.md)
<!-- FooterEnd -->
