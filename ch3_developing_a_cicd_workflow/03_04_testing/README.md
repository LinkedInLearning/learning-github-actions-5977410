# 03_04 Testing

In a CI/CD pipeline, automated testing is the final safeguard before pushing code to production.

By running tests against artifacts built in the pipeline, you can catch errors early and maintain a reliable delivery process.

In this lesson, you’ll add a job that tests the container image built in the previous step.

## Overview

In this lesson, you will:

- Review how the pipeline progresses from building to testing
- Add a new `test-image` job to your workflow
- Configure the job to:

  - Pull the image from the GitHub Container Registry
  - Run the containerized application
  - Send test requests using `curl`
  - Stop the container after testing

- Confirm the `test-image` job runs successfully after the `build` job

## Instructions

> [!IMPORTANT]
> Before proceeding with this lab, please complete the steps in the previous lesson: [Building and Managing Artifacts](../03_03_building_managing_artifacts/README.md)

First, review the current state of your workflow.

Make sure your repository already contains:

- The `.github/workflows` directory
- A workflow file (e.g. [`pipeline.yml`](./pipeline.yml)) with:

  - A `lint-and-test` job
  - A `build` job that pushes a container image to GitHub Container Registry

> [!IMPORTANT]
> If you haven't completed these steps, revisit the previous lesson before continuing.

1. Open the repo in the GitHub Web Editor and navigate to the `.github/workflows` directory in your GitHub repository.
1. Open the workflow file (e.g., `pipeline.yml`).
1. Append the following job to the end of your workflow file:

    ```yaml
    test-image:
        needs: build
        runs-on: ubuntu-latest

        permissions:
        packages: read

        steps:
        - name: Log into ghcr.io
            uses: docker/login-action@v3
            with:
            registry: ghcr.io
            username: ${{ github.actor }}
            password: ${{ secrets.GITHUB_TOKEN }}

        - name: Pull the image from GitHub Container Registry
            run: docker pull ghcr.io/${{ github.repository }}:${{ github.sha }}

        - name: Start ${{ env.SERVICE_NAME }}
            run: |
            docker run \
                --rm --detach --publish 8080:8080 \
                --name $SERVICE_NAME ghcr.io/${{ github.repository }}:${{ github.sha }}
            sleep 3 # allow some time for the service to start

        - name: Run tests using the container image
            run: |
            docker exec $SERVICE_NAME \
                curl --silent --show-error --fail localhost:8080/health
            docker exec $SERVICE_NAME \
                curl --silent --show-error --fail localhost:8080/05024756-765e-41a9-89d7-1407436d9a58

        - name: Stop ${{ env.SERVICE_NAME }}
            run: docker stop $SERVICE_NAME
    ```

    This job:

    - Depends on the `build` job
    - Authenticates with GitHub Container Registry
    - Pulls the image generated in the `build` step
    - Starts the container
    - Executes tests using `curl` to confirm the app is running correctly
    - Stops the container after tests complete

1. Commit your updated workflow file to the repository.
1. Go to the **Actions** tab of your repository.
1. Select the most recent workflow run triggered by your push.
1. Verify the workflow includes a `test-image` job that runs after `build`.

    ![view of pipeline with `test-image` stage after `build`](./images/03_04_01_pipeline_view.png)

1. Expand the `test-image` job to confirm that all steps completed successfully, especially the **Run tests using the container image** step.

    ![output from `Run tests using the container image`](./images/03_04_02_output_from_curl_test_step.png)

<!-- FooterStart -->
---
[← 03_03 Building and Managing Artifacts](../03_03_building_managing_artifacts/README.md) | [03_05 Deploying →](../03_05_deploying/README.md)
<!-- FooterEnd -->
