# 04_08 Add a Metadata File

GitHub Actions use metadata to define how an action runs, what inputs it expects, and how it’s presented in the marketplace.

In this lesson, you’ll add a file called `action.yml` to your repository to describe the behavior and configuration of the `test-scout` action.

## Overview

In this lesson, you will:

- Upload the provided metadata file to your repository.
- Review the required and optional metadata fields supported by GitHub.
- Understand how metadata links your action’s code to the GitHub workflow environment.

## References

- [Metadata syntax reference](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/metadata-syntax-for-github-actions)

## Instructions

> [!IMPORTANT]
> Before proceeding with this lab, please complete the steps to create a Codespace as described in [Add a Dockerfile](../04_04_add_a_dockerfile/README.md).

### Step 1: Upload the metadata file

1. At the root of your repository upload [`action.yml`](./action.yml).
1. Commit the uploaded file to your repository.

### Step 2: Review the contents of `action.yml`

Open the file in the editor and examine the key metadata fields:

- **Required fields**:
  - `name`: The display name of the action (`test-scout`)
  - `description`: A short summary of what the action does
  - `runs`: Specifies the runtime (in this case, `docker` and points to the `Dockerfile`)

- **Recommended field**:
  - `author`: Your name or organization to give credit

- **Optional fields**:
  - `inputs`: Allows customization by passing parameters (e.g., `pattern`, `strict_mode`)
  - `outputs`: Currently unused, but can be added in the future
  - `branding`: Sets the icon and color used if the action is published on the Marketplace

> [!TIP]
> Branding uses icons from [Feather Icons](https://feathericons.com/) and a fixed set of basic color names supported by GitHub (e.g., `blue`, `green`, `purple`).

### Step 3: Consider how metadata connects the pieces

The `action.yml` file serves as the glue between:

- Your action’s logic (`entrypoint.sh`)
- Its runtime environment (`Dockerfile`)
- The configuration used by developers in their workflows (inputs and outputs)

It also helps the GitHub Marketplace display your action professionally if you choose to publish it.

With the metadata file added, your action is now fully defined and ready for documentation in the next lesson.

<!-- FooterStart -->
---
[← 04_07 Test an Action](../04_07_test_an_action/README.md) | [04_09 Add a README File →](../04_09_add_a_readme_file/README.md)
<!-- FooterEnd -->
