# 01_06 Specify Branches for Workflow Events

By default, GitHub Actions workflows triggered by events like `push` or `pull_request` will run in response to those events on any branch.

However, GitHub gives us the ability to narrow that scope by specifying which branches (or tags) should trigger the workflow.

In this lesson, you’ll learn how to configure your workflow to target or exclude specific branches, use multiple event types, and understand the syntax rules around these filters.

## Overview

In this lesson, you will:

- Learn the default behavior of event triggers in workflows.
- Configure a workflow to run only for specific branches.
- Specify branch filters for workflows with multiple triggers.
- Use `branches-ignore` to exclude branches from triggering workflows.
- Apply similar filters using `tags` and `tags-ignore`.
- Handle special characters in branch or tag names.

## 1. Default Behavior

- A single `push` or `pull_request` trigger will respond to events on any branch unless you restrict it.

## 2. Use YAML Block Format for Events

- To customize trigger behavior, write the event as a block:

  ```yaml
  on:
    push:
  ```

## 3. Add the `branches` Attribute

- Add a `branches` attribute under the event to list specific branches:

  ```yaml
  on:
    push:
      branches:
        - main
        - develop
  ```

  ```yaml
  on:
    pull_request:
      branches:
        - main
  ```

## 4. Support for Multiple Events with Branch Filters

- You can only define `on:` once per workflow, so multiple triggers must be written as separate blocks:

  ```yaml
  on:
    push:
      branches:
        - main
    pull_request:
      branches:
        - main
  ```

## 5. Exclude Branches Using `branches-ignore`

- If you want to ignore certain branches instead:

  ```yaml
  on:
    push:
      branches-ignore:
        - experimental
  ```

> *Note: You cannot use `branches` and `branches-ignore` together under the same event.*

## 6. Use `tags` and `tags-ignore` the same way as branches

- Example for tag filtering:

  ```yaml
  on:
    push:
      tags:
        - 'v*'
  ```

## 7. Handling Special Characters

- Wrap branches or tags with special characters in quotes:

  ```yaml
  on:
    push:
      branches:
        - "feature/authentication"
        - 'release/*'
  ```

> [!TIP]
> For detailed pattern rules, refer to GitHub’s super-detailed [filter pattern cheat sheet](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/workflow-syntax-for-github-actions#filter-pattern-cheat-sheet).

<!-- FooterStart -->
---
[← 01_05 Add Dependencies Between Jobs](../01_05_add_dependencies_between_jobs/README.md) | [01_07 Workflow and Action Limits →](../01_07_workflow_action_limits/README.md)
<!-- FooterEnd -->
