# 01_03 Add Actions to a Workflow

In this lesson, you'll complete your workflow by adding **actions** and **commands** to the steps you defined earlier.

- **Actions** are reusable units of code packaged for GitHub workflows.
- **Commands** are shell commands run directly on the runner's operating system.

> [!TIP]
> `**[actions/checkout](https://github.com/actions/checkout)**` might be one of the most commonly used actions. Its used to check out the code in your repository into the runner’s filesystem so other steps in the same job can work with it.
> Because each job runs in an isolated environment, each job that needs the work with the repository code will have to run the `checkout` action.

Other useful actions include actions that setup specific versions for compilers and interpreters for programming languages, including:

- **[actions/setup-go](https://github.com/actions/setup-go)**
- **[actions/setup-python](https://github.com/actions/setup-python)**
- **[actions/setup-node](https://github.com/actions/setup-node)**
- **[actions/setup-java](https://github.com/actions/setup-java)**

## Overview

In this lesson, you will:

- Use the `uses` attribute to add a commonly used action.
- Use the `run` attribute to add OS-specific shell commands.

## Instructions

1. Open your `first.yml` file in the GitHub web editor.
1. Under **Job 1** and **Job 2**, in the `- name: Step One` block, add:

    ```yaml
        uses: actions/checkout@v4
    ````

1. Under **Job 1**, in the `- name: Step Two` block, add:

    ```yaml
        run: env | sort
    ```

    This command prints and alphabetizes all environment variables. On Ubuntu, this runs in the  Bash shell.

1. Under **Job 2**, in the `- name: Step Two` block, add:

    ```yaml
        run: "Get-ChildItem Env: | Sort-Object Name"
    ```

    This PowerShell command prints environment variables and sorts them by name. Quotation marks are required to avoid YAML parsing issues with the colon (`:`) character in the argument `Env:`.

Your complete workflow file should be similar to the following:

```yaml
name: first
on: [push]
jobs:
  job1:
    name: First Job
    runs-on: ubuntu-latest
    steps:
      - name: Step One
        uses: actions/checkout@v4
      - name: Step Two
        run: env | sort
  job2:
    name: Second Job
    runs-on: windows-latest
    steps:
      - name: Step One
        uses: actions/checkout@v4
      - name: Step Two
        run: "Get-ChildItem Env: | Sort-Object Name"
```

In the next lesson, you'll run this workflow, verify that each job completes successfully, and review the output for each step.

<!-- FooterStart -->
---
[← 01_02 Add Jobs and Steps to a Workflow](../01_02_add_jobs_steps_to_a_workflow/README.md) | [01_04 Run a Workflow →](../01_04_run_a_workflow/README.md)
<!-- FooterEnd -->
