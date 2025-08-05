# 04_09 Add a README File

A clear, well-written README helps others understand what your custom GitHub Action does and how to use it.

In this lesson, you’ll create a README file that documents the `test-scout` action.

## References

- [Mastering GitHub Markdown: Basic writing and formatting syntax](https://guides.github.com/features/mastering-markdown/)

## Overview

In this lesson, you will:

- Review the key components that should be included in any GitHub Action README.
- Understand how documentation improves usability and supports marketplace publishing.

## Instructions

> [!IMPORTANT]
> Before proceeding with this lab, please complete the steps to create a Codespace as described in [Add a Dockerfile](../04_04_add_a_dockerfile/README.md).

### Step 1: Upload the README file

1. At the root of your repository, upload the file named [`CUSTOM_ACTION_README.md`](./CUSTOM_ACTION_README.md).
1. After uploading, rename the file to `README.md`.
1. Commit the file to your repository.

### Step 2: Review the README contents

Open `README.md` and review the following content:

- **Title and Description**

  At the top, there's a clear title (`Test Scout`) and a sentence describing the action’s purpose.

- **Inputs Table**

  The README includes a table that describes the optional inputs:

  - `pattern`: file glob pattern used to detect test files (default: `test_*.py`)
  - `strict_mode`: controls whether the action fails when no test files are found

- **Outputs**

  The action currently doesn’t define any outputs, which is noted clearly.

- **Example Usage**

  A YAML snippet shows how to use the action in a GitHub workflow. This example includes setting both the `pattern` and `strict_mode` inputs.

### Step 3: Consider the purpose of the README

Even though a README isn’t required unless you publish your action to the GitHub Marketplace, it’s considered a best practice.

A well structured README file helps other developers:

- Understand what the action does
- Know how to configure the action in a workflow
- Quickly see working examples

With the README file in place, your action is now documented and ready for others to discover and use.

<!-- FooterStart -->
---
[← 04_08 Add a Metadata File](../04_08_add_a_metadata_file/README.md) | [04_10 Deploy a Custom Action →](../04_10_deploy_a_custom_action/README.md)
<!-- FooterEnd -->
