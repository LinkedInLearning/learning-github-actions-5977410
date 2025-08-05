# 00_05 Workflow and Action Attributes

Before you begin building your own custom workflows and actions in GitHub Actions, it's helpful to understand the key attributes that define how workflows behave.

This lesson summarizes the most common attributes used in a GitHub Actions workflow.

## References

- [Workflow Syntax](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax)
- [Workflow Contexts](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts)
- [GitHub Actions Cheat Sheet](../../github-actions-cheat-sheet.pdf)

## Example Workflow

Use the following workflow as an example for the attribute reference.

- [hello.yml](./hello.yml)

```yaml
name: Hello

# Controls when the workflow will run
on:
  # Triggers the workflow on push or pull request events
  push:
  pull_request:

# A workflow run is made up of one or more jobs
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - uses: actions/checkout@v4

      # Runs a single command using the runners shell
      - name: Run a one-line script
        run: echo Hello, world!

      # Runs a set of commands using the runners shell
      - name: Run a multi-line script
        run: |
          echo Add other actions to build,
          echo test, and deploy your project.
```

## Attribute Reference

### `name` (Workflow-level)

- **Purpose**: Gives a human-readable name to the workflow.
- **Best Practice**: Use descriptive names, especially when managing multiple workflows in one repo.
- **Optional**: If omitted, GitHub will default to using the file path and filename as the workflow name.

### `on`

- **Purpose**: Specifies the event(s) that trigger the workflow.
- **Required**: Yes. Without it, the workflow will not run.
- **Examples of Events**:
  - `push`, `pull_request`, `release`
  - Webhook events like `issues`, `create`, `delete`, `member`
  - Scheduled events using `schedule` with `cron` syntax

### `jobs`

- **Purpose**: Defines jobs in the workflow.
- **Required**: Yes. At least one job must be defined.
- **Format**: Each job is an identifier you choose, and must:
  - Start with a letter or underscore
  - Contain only alphanumeric characters, dashes, or underscores

### `runs-on`

- **Purpose**: Specifies the type of virtual machine (runner) the job will run on.
- **Common GitHub-hosted runners**:
  - `ubuntu-latest`
  - `windows-latest`
  - `macos-latest`

Use the following links for more information on GitHub hosted runners:

- **[Available Images](https://github.com/actions/runner-images?tab=readme-ov-file#available-images)**
- **Installed Software**
  - [Windows](https://github.com/actions/runner-images/blob/main/images/windows/Windows2022-Readme.md)
  - [Ubuntu (Linux)](https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md#installed-software)
  - [macOS](https://github.com/actions/runner-images/blob/main/images/macos/macos-14-Readme.md)

### `steps`

- **Purpose**: A sequence of tasks within a job.
- **Details**:
  - Can be either actions (`uses`) or shell commands (`run`)
  - Each step runs in its own process
  - Steps share the same virtual environment and filesystem

### `uses`

- **Purpose**: Indicates an Action to use in a step.
- **Format**:
  - From same repo: `./path-to-action`
  - From another public repo: `owner/repo@ref`
  - From a container registry: `docker://image`

### `run`

- **Purpose**: Executes shell commands directly in the runner's environment.
- **Use Case**: When you want to perform tasks using commands like `npm install`, `echo`, `python script.py`, etc.

### `name` (Step-level)

- **Purpose**: Gives a distinct label to a step.
- **Optional**: If omitted, the step will default to the command or Action string as the display name.

## Next Steps

Now that you’ve reviewed the core attributes of a GitHub Actions workflow, you're ready to begin developing your own custom workflows. Refer to this guide as you build, experiment, and troubleshoot.

<!-- FooterStart -->
---
[← 00_04 Your First Action](../00_04_your_first_action/README.md) | [01_01 Create a Workflow →](../../ch1_actions_and_workflows/01_01_create_a_workflow/README.md)
<!-- FooterEnd -->
