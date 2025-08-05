# 04_05 Add an Entry-Point Script

In this lesson, we’ll add the main script that powers our custom action.

## Overview

In this lesson, you will:

- Upload the `entrypoint.sh` script provided with this lesson.
- Review the basic structure of the script and how it’s executed.
- Understand how to configure the shell environment and exit behavior.

## Instructions

> [!IMPORTANT]
> Before proceeding with this lab, please complete the steps to create a Codespace as described in [Add a Dockerfile](../04_04_add_a_dockerfile/README.md).

### Step 1: Upload the `entrypoint.sh` script

1. At the root of your repository, select “Upload Files.”
2. Upload the file named [`entrypoint.sh`](./entrypoint.sh).
3. Commit the uploaded file to the repository.

### Step 2: Review the `entrypoint.sh` file

Open the file and review the structure of the script:

- **Shebang line (`#!/bin/bash`)**

  This tells the container to use the Bash shell when executing the script.

- **`set -e`**

  This option causes the script to exit immediately if any command returns a non-zero status. This helps fail fast when there are issues.

- **Script Outline (Comments)**

  The remainder of the script is structured with comments and placeholders for the logic we’ll add next:

  - Count all Python files
  - Count test files matching a pattern
  - Warn or fail if test files are missing
  - Report summary output

We’ll add the actual logic to this script in the next lesson. For now, make sure the file is in place and executable.

<!-- FooterStart -->
---
[← 04_04 Add a Dockerfile](../04_04_add_a_dockerfile/README.md) | [04_06 Use Runtime Environment Resources →](../04_06_use_runtime_environment_resources/README.md)
<!-- FooterEnd -->
