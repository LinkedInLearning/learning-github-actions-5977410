# 01_01 Create a Workflow

To use GitHub Actions effectively, you need to understand how to create a workflow.

Workflows define the automation process within a GitHub repository with two primary purposes:

1. Specify which events should trigger a series of jobs
2. Specify the actions and commands those jobs should perform.

In this lesson, you'll begin creating your first GitHub Actions workflow from scratch using the GitHub web editor.

## Overview

In this lesson, you will:

- Create a new GitHub repository and open it using the GitHub web editor.
- Create the required `.github/workflows` directory.
- Create a new workflow YAML file.
- Define the workflow's name.
- Set up a `push` trigger event using the `on` keyword.

> [!TIP]
> It's a good practice to match the workflow name with the filename to keep things consistent.

## Instructions

1. Create or open a new repository on GitHub.
1. Launch the web editor by pressing `.` on your keyboard (this opens the repository in `github.dev`).
1. In the file explorer pane, right-click and select **New Folder**.
1. Enter the following folder path:

    ```bash
    .github/workflows
    ```

1. Make sure the `workflows` directory is selected.
1. Right-click and choose **New File**.
1. Name the file:

    ```bash
    first.yml
    ````

1. Inside `first.yml`, type the following to name your workflow:

    ```yaml
    name: first
    ````

1. On the next line, type the following to define the trigger:

   ```yaml
   on: [push]
   ```

> [!TIP]
> You can list one or more trigger events using bracket notation. Even if you're using only one event, this format allows for easily adding additional events in the future.

At this point, your workflow is set up to run whenever code is pushed to the repository.

In the next lesson, you'll add jobs, steps, and actions to define what the workflow actually does.

<!-- FooterStart -->
---
[← 00_05 Workflow and Action Attributes](../../ch0_introduction/00_05_workflow_action_attributes/README.md) | [01_02 Add Jobs and Steps to a Workflow →](../01_02_add_jobs_steps_to_a_workflow/README.md)
<!-- FooterEnd -->
