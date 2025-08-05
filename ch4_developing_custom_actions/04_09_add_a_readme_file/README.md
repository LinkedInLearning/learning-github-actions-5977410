# 04_09 Add a README File

A clear, well-written README helps others understand what your custom GitHub Action does and how to use it.

In this lesson, you’ll upload a README file that documents the `test-scout` action.


## Overview

In this lesson, you will:

- Upload the provided README file and rename it to `README.md`.
- Review the key components that should be included in any GitHub Action README.
- Understand how documentation improves usability and supports marketplace publishing.


## Instructions

### Step 1: Open your repository in a GitHub Codespace

1. Open your public repository in GitHub.
2. Launch a Codespace from the `Code > Codespaces` menu.

### Step 2: Upload the README file

1. At the root of your repository, click “Upload Files.”
2. Upload the provided file named `CUSTOM_ACTION_README.md` from the folder `04_09_add_a_readme_file`.
3. After uploading, rename the file to `README.md`.
   - If renaming in the GitHub web UI, you can edit the filename in the commit window.
   - Alternatively, rename it using the editor in your Codespace.
4. Commit the file to your repository.

### Step 3: Review the README contents

Open `README.md` and confirm it includes the following sections:

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

### Step 4: Consider the purpose of the README

Even though a README isn’t required unless you publish your action to the GitHub Marketplace, it’s considered a best practice. It helps other developers:

- Understand what the action does
- Know how to configure it
- Quickly see working usage examples

A good README can make the difference between an action that’s reused widely and one that gets ignored.


With the README file in place, your action is now documented and ready for others to discover and use.

<!-- FooterStart -->
---
[← 04_08 Add a Metadata File](../04_08_add_a_metadata_file/README.md) | [04_10 Deploy a Custom Action →](../04_10_deploy_a_custom_action/README.md)
<!-- FooterEnd -->
