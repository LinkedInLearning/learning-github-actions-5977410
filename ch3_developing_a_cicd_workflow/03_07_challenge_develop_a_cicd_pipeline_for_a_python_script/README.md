# 03_07 Challenge: Develop a CI/CD Pipeline for a Python Script

## Develop a CI/CD Pipeline for a Python Script

In this challenge, you’ll develop a GitHub Actions workflow for a Python script.

The goal is to build a full CI/CD pipeline that includes linting and tests, artifact creation, and artifact testing.

You’ll also configure your workflow to use the GitHub Container Registry (GHCR) to store and retrieve the image.

### Overview

You will complete the following steps in this challenge:

1. **Create a new GitHub repository** using the Python `.gitignore` template
2. **Use the repository in the GitHub Web Editor** to add code and workflows
3. **Add the provided files**:

   - `hello.py` (Python script)
   - `Dockerfile` (for building the image)
   - `.github/workflows/python-pipeline.yml` (your CI/CD workflow)

4. **Implement a three-stage pipeline**:

   - Lint and test the Python code
   - Build and push the container image to GHCR
   - Pull and run the image to verify output

5. **Push changes to the repository** and confirm the workflow runs successfully

This challenge should take about 15 minutes to complete.

### Instructions

#### Create a New Repository

1. Go to [https://github.com](https://github.com) and select **New repository**
2. Name the repository (e.g., `python-ci-cd`)
3. Choose **Public** or **Private** visibility
4. Select **Add .gitignore** and choose the **Python** template
5. Select **Create repository**

#### Add Files to the Repository in the GitHub Web Editor

1. Press the `.` key in your new repo or navigate to `https://github.dev/your-user-name/you-repo-name`
1. Add the following files to the root of your repo:

`hello.py`

```python
print("Hello, world")
```

`Dockerfile`

```Dockerfile
FROM python:3.13-slim

COPY hello.py .

CMD ["python", "hello.py"]
```

`.github/workflows/python-pipeline.yml`

```yaml
name: Python CI/CD Pipeline

on: [push, workflow_dispatch]

env:
  SERVICE: hello

jobs:
  lint-and-test:
    name: Lint and Test
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.13"

      - name: Lint hello.py
        run: |
          pip install flake8 pylint
          flake8 hello.py
          pylint hello.py

      - name: Test the script
        run: python hello.py | grep -i hello || exit 1

  build-and-push:
    name: 📦 Build and Push Container
    runs-on: ubuntu-latest
    needs: lint-and-test
    permissions:
      packages: write
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Docker buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to GitHub Container Registry
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      # Extract metadata (tags, labels) for Docker
      # https://github.com/docker/metadata-action
      - name: Extract Docker metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=sha,format=short,prefix=,suffix=
            type=sha,format=long,prefix=,suffix=
            type=ref,event=branch,prefix=,suffix=

      # Build and push Docker image with Buildx (don't push on PR)
      # https://github.com/docker/build-push-action
      - name: Build and push Docker image
        id: build-and-push
        uses: docker/build-push-action@v5
        with:
          context: .
          platforms: linux/amd64, linux/arm64
          push: ${{ github.event_name != 'pull_request' }}
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}


  test-image:
    name: 🔁 Pull and Test Container
    runs-on: ubuntu-latest
    needs: build-and-push
    steps:
      - name: Log in to GitHub Container Registry
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Pull and Run Docker Image
        run: |
          docker pull ${{ env.IMAGE_NAME }}
          docker run --rm ${{ env.IMAGE_NAME }}
```

#### Commit the Files to the Repository

1. Commit all files to your repo and push the changes
2. Go to the **Actions** tab to confirm the workflow starts
3. Once completed, verify that:

   - Linting and test stages passed
   - The image was pushed to GHCR
   - The final job pulled and successfully ran the image, printing `Hello, world`

<!-- FooterStart -->
---
[← 03_06 Add a Workflow Status Badge](../03_06_add_a_workflow_status_badge/README.md) | [03_08 Solution: Develop a CI/CD Pipeline for a Python Script →](../03_08_solution_develop_a_cicd_pipeline_for_a_python_script/README.md)
<!-- FooterEnd -->
