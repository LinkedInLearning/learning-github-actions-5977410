# 04_13 Solution: Create a Custom Action

In this challenge, you'll develop and test a custom GitHub Action that reports details about the repository where the action is run.

## Overview

You will complete the following steps in this challenge:

1. **Create a new GitHub repository** to store the files that make up your custom action.
1. **Add the provided files**:

   - Script: [`entrypoint.sh`](./entrypoint.sh)
   - Docker spec: [`Dockerfile`](./Dockerfile)
   - Metadata file: [`action.yml`](./action.yml)

1. **Create a workflow** triggered by `push` and `workflow_dispatch` events that runs your custom action.
1. **Push changes to the repository** to trigger the workflow.
1. **Review the workflow output logs** to confirm the action executed successfully.

This challenge should take about 15 minutes to complete.

## Instructions

### Create a New Repository

1. Go to [https://github.com](https://github.com) and select **New repository**.
1. Name the repository (e.g., `custom-action-challenge`).
1. Choose **Public** visibility.
1. Select **Create repository**.
1. In your new repository, press the `.` key on your keyboard to open the Web Editor, or change the URL from `github.com` to `github.dev`.

### Upload the Provided Files

Add the following files to your repository:

- [`entrypoint.sh`](./entrypoint.sh)

```shell
#!/bin/bash
set -e

echo "👤 Actor       : $GITHUB_ACTOR"
echo "🆔 Commit SHA  : $GITHUB_SHA"
echo "▶️ Event type  : $GITHUB_EVENT_NAME"
echo -n "🔎 Visibility  : "

VISIBILITY=$(jq -r '.repository.visibility' "$GITHUB_EVENT_PATH")

if [[ "$VISIBILITY" == "private" ]]; then
   echo "🔒 This is a PRIVATE repository."
else
  echo "🌍 This is a PUBLIC repository."
fi
```

- [`Dockerfile`](./Dockerfile)

```Dockerfile
# Use Ubuntu as the base image
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the entrypoint script into the image
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make sure the entrypoint script is executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the default command
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
```

- [`action.yml`](./action.yml)

```yaml
name: "Print GitHub Actor and Repo Details"
description: "A custom action that shows details about the repo where the action is running."
runs:
  using: "docker"
  image: "Dockerfile"
```

### Create the Workflow File

1. In the Web Editor, create a new folder: `.github/workflows/`
1. Inside this folder, create a new file named `test-custom-action.yml`.

```yaml
name: Test Custom Action

on: [push, workflow_dispatch]

jobs:
  run-custom-action:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Run custom action
        uses: YOUR_GITHUB_USER_NAME/YOUR_GITHUB_REPO_NAME@main
```

### Push Changes to the Repository

1. In the Web Editor, stage and commit your changes.
1. Push your changes to your repository's default branch (usually `main`). This push will trigger the workflow automatically.

### Review Workflow Results

1. Go to your repository on GitHub and select the **Actions** tab.
1. Select the most recent run triggered by your push.
1. Review the output from the job `run-custom-action`. It should display:

- Actor who triggered the workflow
- Commit SHA
- Event type (`push` or `workflow_dispatch`)
- Repository visibility (public or private)

Ensure the workflow output matches your expectations for the custom action.

<!-- FooterStart -->
---
[← 04_12 Challenge: Create a Custom Action](../04_12_challenge_create_a_custom_action/README.md) | [05_01 Additional Resources for GitHub Actions →](../../ch5_conclusion/05_01_additional_resources_for_github_actions/README.md)
<!-- FooterEnd -->
