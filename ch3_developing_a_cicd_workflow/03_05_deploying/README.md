# 03_05 Deploying

We’ve reached the final stage of the CI/CD pipeline: deployment.

In this lesson, you’ll learn how to take the container image built and tested in previous jobs and deploy it to a cloud platform—in this case, Google Cloud Platform (GCP).

You’ll configure your GitHub Actions workflow to authenticate with GCP, push the container image to the GCP Artifact Registry, and deploy it using Cloud Run.

## Overview

This lab walks you through:

- Preparing your secrets for GCP authentication
- Reviewing the `deploy` job configuration in the existing workflow
- Understanding how the workflow pushes the container to GCP
- Watching how the deployment is performed via GitHub Actions
- Verifying the live application with a final test step

## Instructions

> [!IMPORTANT]
> Before proceeding with this lab, please complete the steps in the previous lesson: [Testing](../03_04_testing/README.md))

> [!IMPORTANT]
> If you are not planning to use a cloud service (ie, Google Cloud) in this lab, skip steps 1 and 2 below and fast forward to the ["Escape Hatch"](#escape-hatch) step.

### Step 1: Add Google Cloud Secrets to the Repository

TODO: ADD STEPS FOR CREATING GCP CREDENTIALS

1. In GitHub, go to your repository's **Settings** tab.
1. Navigate to **Secrets and variables > Actions > Repository secrets**.
1. Add the following secrets:

| Secret Name                      | Description                                              |
| -------------------------------- | -------------------------------------------------------- |
| `GCP_WORKLOAD_IDENTITY_PROVIDER` | The workload identity provider string for your GCP setup |
| `GCP_SERVICE_ACCOUNT`            | The email of your GCP service account                    |
| `GCP_PROJECT_ID`                 | Your GCP project ID                                      |
| `GCP_REGION`                     | The region for Cloud Run (e.g., `us-central1`)           |
| `GCP_REGISTRY_NAME`              | Your Artifact Registry name (e.g., `mascot-registry`)    |

### Step 2: Update the workflow file

Add the following job to the workflow file:

```yaml
  deploy:
    needs: test-image
    runs-on: ubuntu-latest

    permissions:
      packages: read
      id-token: write

    steps:
    - name: Log into ghcr.io
      uses: docker/login-action@v3
      with:
        registry: ghcr.io
        username: ${{ github.actor }}
        password: ${{ secrets.GITHUB_TOKEN }}

    - name: Authenticate to Google Cloud
      id: auth
      uses: google-github-actions/auth@v2
      with:
        workload_identity_provider: ${{ secrets.GCP_WORKLOAD_IDENTITY_PROVIDER }}
        service_account: ${{ secrets.GCP_SERVICE_ACCOUNT }}

    - name: Set up Google Cloud CLI
      uses: google-github-actions/setup-gcloud@v2

    - name: Configure Docker
      run: gcloud auth configure-docker ${{ secrets.GCP_REGION }}-docker.pkg.dev

    - name: Pull the image from GitHub Container Registry
      run: docker pull ghcr.io/${{ github.repository }}:${{ github.sha }}

    - name: Tag the image for GCP Container Registry
      run: |
        docker tag ghcr.io/${{ github.repository }}:${{ github.sha }} \
          ${{ secrets.GCP_REGION }}-docker.pkg.dev/${{ secrets.GCP_PROJECT_ID }}/${{ secrets.GCP_REGISTRY_NAME }}/${{ env.SERVICE_NAME }}:${{ github.sha }}
        docker image ls

    - name: Push the tagged image to GCP Container Registry
      run: docker push ${{ secrets.GCP_REGION }}-docker.pkg.dev/${{ secrets.GCP_PROJECT_ID }}/${{ secrets.GCP_REGISTRY_NAME }}/$SERVICE_NAME:${{ github.sha }}

    - name: Deploy to Cloud Run service
      uses: google-github-actions/deploy-cloudrun@v2
      with:
        service: ${{ env.SERVICE_NAME }}
        region: ${{ secrets.GCP_REGION }}
        image: ${{ secrets.GCP_REGION }}-docker.pkg.dev/${{secrets.GCP_PROJECT_ID}}/${{ secrets.GCP_REGISTRY_NAME }}/${{ env.SERVICE_NAME }}:${{ github.sha }}
        flags: '--allow-unauthenticated'

    - name: Test the Live Application
      run: |
        DEPLOY_URL=$(gcloud run services describe $SERVICE_NAME --platform=managed --region=${{ secrets.GCP_REGION }} --format='value(status.url)')
        echo "Testing DEPLOY_URL: ${DEPLOY_URL}"
        curl --silent --fail ${DEPLOY_URL}/health
        curl --silent --fail ${DEPLOY_URL}/05024756-765e-41a9-89d7-1407436d9a58
```

In the `pipeline.yml`, scroll to the `deploy` job section and review the following:

- **Job Dependencies**: The `deploy` job runs *after* the `test-image` job (`needs: test-image`).
- **Permissions**: The job requires `packages: read` and `id-token: write` for authentication and access.
- **Steps**:

  - Logs into GitHub Container Registry.
  - Authenticates to Google Cloud using the provided secrets.
  - Sets up the GCP CLI and configures Docker for GCP.
  - Pulls the image built earlier.
  - Tags and pushes the image to GCP Artifact Registry.
  - Deploys the image to a Cloud Run service.
  - Tests the live deployment with HTTP requests to validate the service is running correctly.

### Escape Hatch

If you're not deploying to a cloud platform, you can replace the `deploy` job in your workflow file with this simulated version.

It skips the authentication and deployment steps but still demonstrates how deployment jobs are structured.

```yaml
  deploy:
    needs: test-image
    runs-on: ubuntu-latest

    permissions:
      packages: read
      id-token: write

    steps:
    - name: Log into GitHub Container Registry
      uses: docker/login-action@v3
      with:
        registry: ghcr.io
        username: ${{ github.actor }}
        password: ${{ secrets.GITHUB_TOKEN }}

    - name: Pull the image from GitHub Container Registry
      run: docker pull ghcr.io/${{ github.repository }}:${{ github.sha }}

    - name: Tag the image
      run: |
        echo "Tag image for cloud deployment"
        docker tag ghcr.io/${{ github.repository }}:${{ github.sha }} fake.registry.local/${{ github.repository }}:${{ github.sha }
        docker image ls

    - name: Simulate Pushing to Remote Registry
      run: |
        echo "Push fake.registry.local/${{ github.repository }}:${{ github.sha }"
        sleep 2

    - name: Deploy to cloud service 😉
      run: |
        echo "Deploy to cloud service..."
        sleep 2
        echo "Deployment complete."

    - name: Test the Live Application
      run: |
        echo "Check live application"
        echo "HTTP 200 OK - /health"
        echo "HTTP 200 OK - /05024756-765e-41a9-89d7-1407436d9a58"
```

This approach ensures the pipeline runs end-to-end without error, making it ideal for including a `deploy` job without connecting to a real cloud environment.

### Step 3: Run the Workflow

1. Push your changes to GitHub.
1. Go to the **Actions** tab and monitor the run titled **Pipeline**.
1. Expand the `deploy` job and review each step as it completes.
1. Confirm that the final step (testing the live app) completes successfully.

### Step 4: Troubleshooting Notes

- **Warnings in the GitHub web editor for secret variables**:  When viewing the `deploy` job in the GitHub web editor, warnings will appear under variables using the YAML syntax for secrets.  The message will read: "Context access might be invalid: ...".  This is caused by the editor not being able to determine the scope of the variable being referenced as a secret.  *These warnings can be safely ignored*.

  ![Warning in GitHub Web Editor for Secrets](./images/03_05_warnings_in_github_web_ide_for_secrets.png)

- Be sure that the GCP service account used for the workflow authentication has permission to deploy services and push images.  Review the TODO: ADD STEPS FOR CREATING GCP CREDENTIALS or use the ["Escape Hatch"](#escape-hatch) deploy job if you can't get your workflow steps to authenticate.

## SHENANIGANS

Right now the lab is set up to work with GCP.  In the future, directions for the following may be added:

- TODO: ADD STEPS FOR AUTHENTICATING WITH AWS AND DEPLOYING TO APP RUNNER
- TODO: ADD STEPS FOR AUTHENTICATING WITH AZURE AND DEPLOYING TO AZURE CONTAINER SERVICES

<!-- FooterStart -->
---
[← 03_04 Testing](../03_04_testing/README.md) | [03_06 Add a Workflow Status Badge →](../03_06_add_a_workflow_status_badge/README.md)
<!-- FooterEnd -->
