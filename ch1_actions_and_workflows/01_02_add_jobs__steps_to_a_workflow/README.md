# 01_02 Add Jobs and Steps to a Workflow

A GitHub Actions workflow becomes functional by adding jobs and steps.

- **Jobs** are a collection of tasks that run in the same environment.
  - Each workflow must have at least one job,
  - Job identifiers must begin with a letter or underscore and contain only alphanumeric characters, dashes, or underscores.

- **Steps** are individual tasks within a job.
  - Each job must have at least one step

> [!TIP]
> Pay attention to the indentation in your workflow file to avoid errors caused by bad YAML formatting.

## Overview

In this lesson, you will:

- Define the `jobs` section of the workflow file.
- Add two jobs with unique identifiers and readable names.
- Specify runners for each job.
- Add steps to each job with descriptive names.

## Instructions

1: Open the Workflow File

1. In the GitHub web editor, open the `first.yml` file located at:

    ```bash

    .github/workflows/first.yml

    ````

1. Below the `on: [push]` line, add the `jobs` section:

    ```yaml
    jobs:
    ````

1. Indent beneath `jobs:` and add two job identifiers:

   ```yaml
     job1:
     job2:
   ```

1. Under `job1`, add:

    ```yaml
        name: First Job
        runs-on: ubuntu-latest
    ```

1. Under `job2`, add:

    ```yaml
        name: Second Job
        runs-on: windows-latest
    ```

1. Under `job1`, add a `steps` block with two named steps:

   ```yaml
       steps:
         - name: Step One
         - name: Step Two
   ```

1. Under `job2`, add the same `steps` block:

   ```yaml
       steps:
         - name: Step One
         - name: Step Two
   ```

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
      - name: Step Two
  job2:
    name: Second Job
    runs-on: windows-latest
    steps:
      - name: Step One
      - name: Step Two
```

In the next lesson, you'll continue updating the workflow by adding actions and commands.

<!-- FooterStart -->
---
[← 01_01 Create a Workflow](../01_01_create_a_workflow/README.md) | [01_03 Add Actions to a Workflow →](../01_03_add_actions_to_a_workflow/README.md)
<!-- FooterEnd -->
