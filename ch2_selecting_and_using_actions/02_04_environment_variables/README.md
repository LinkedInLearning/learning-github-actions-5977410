# 02_04 Use Environment Variables

Environment variables are an essential tool for customizing and controlling the behavior of your GitHub Actions workflows.

They allow you to store dynamic values—like configuration settings or runtime context—that can be used throughout your workflow.

In this lesson, you’ll learn how to use both default and custom environment variables, explore their scope, and understand the difference between accessing them via shell syntax and YAML syntax.

## Overview

In this lesson, you will:

- Create a workflow file to demonstrate the use of environment variables.
- Set environment variables at different levels: workflow, job, and step.
- Access environment variables using shell and YAML syntax.
- Run jobs on both Ubuntu and Windows runners to view environment variable behavior.

## Instructions

### Step 1: Create the workflow directory and file

1. **Create a new GitHub repository**.
1. **Open the repository in the GitHub Web Editor** to add code and workflows.
1. Create a new directory named `.github/workflows`.
1. Inside the `workflows` directory, add the exercise file [`environment-variables.yml`](./environment-variables.yml).

### 2. Review Key Steps and Arguments

The file [environment-variables.yml](./environment-variables.yml) is configured with environment variables set at three levels:

**Workflow level**: A global env block is declared near the top of the workflow file.

**Job level**: Each job (Ubuntu and Windows) overrides some of the workflow-level variables.

**Step level**: Individual steps override variables again, using either shell syntax or YAML interpolation.

### 3. Push the Changes, Trigger the Workflow, and Review the Logs

1. In the GitHub web editor, select the **Source Control** tab from the menu on the left-hand side.
1. Enter a commit message. For example, `add files to build tomcat`.
1. Select the **Commit & Push** button.

    _Note: The exact button label might vary depending on your setup, but it will typically include "Commit"._

1. At the top of the left-hand navigation panel, select **Go to Repository**.
1. In the repository view, select the **Actions** tab.
1. You should see a workflow run listed with a label matching your commit message.
1. Select that workflow run to open the details.
1. Expand the logs for for each job.

    **Ubuntu Job**
    - Observe how the default GitHub environment variables are echoed.
    - Review how job-level variables are printed using Bash-style syntax.
    - Review the final step, where step-level environment variables use YAML interpolation.

    **Windows Job**
    - Review the same sequence of steps used for the Ubuntu job.
    - Note how variable syntax differs (e.g., PowerShell uses $Env:VARIABLE_NAME).

You’ve now seen how to define and use environment variables in GitHub Actions. In the next lesson, you’ll learn about "secrets", a special kind of environment variable used for sensitive data.

<!-- FooterStart -->
---
[← 02_03 Pass Arguments to an Action](../02_03_pass_arguments_to_an_action/README.md) | [02_05 Use Secrets →](../02_05_secrets/README.md)
<!-- FooterEnd -->
