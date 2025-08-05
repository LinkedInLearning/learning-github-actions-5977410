# 03_05 Deploying

We’ve reached the final stage of the CI/CD pipeline: deployment.

In this lesson, you’ll learn how to take the container image built and tested in previous jobs and deploy it to a cloud platform—in this case, Google Cloud Platform (GCP).

You’ll configure your GitHub Actions workflow to authenticate with GCP, push the container image to the GCP Artifact Registry, and deploy it using Cloud Run.

## Overview

This lab walks you through:

* Preparing your secrets for GCP authentication
* Reviewing the `deploy` job configuration in the existing workflow
* Understanding how the workflow pushes the container to GCP
* Watching how the deployment is performed via GitHub Actions
* Verifying the live application with a final test step

TODO: ADD AN ESCAPE_HATCH FOR USERS THAT CHOSE NOT TO DEPLOY TO GCP

---

## Instructions

> [!IMPORTANT]
> Before proceeding with this lab, please complete the steps in the previous lesson: [Testing](../03_04_testing/README.md))

### Step 1: Add Google Cloud Secrets to the Repository

TODO: ADD STEPS FOR CREATING GCP CREDENTIALS

1. In GitHub, go to your repository's **Settings** tab.
2. Navigate to **Secrets and variables > Actions > Repository secrets**.
3. Add the following secrets:

| Secret Name                      | Description                                              |
| -------------------------------- | -------------------------------------------------------- |
| `GCP_WORKLOAD_IDENTITY_PROVIDER` | The workload identity provider string for your GCP setup |
| `GCP_SERVICE_ACCOUNT`            | The email of your GCP service account                    |
| `GCP_PROJECT_ID`                 | Your GCP project ID                                      |
| `GCP_REGION`                     | The region for Cloud Run (e.g., `us-central1`)           |
| `GCP_REGISTRY_NAME`              | Your Artifact Registry name (e.g., `mascot-registry`)    |

### Step 2: Update the workflow file

Add the following job to the workflow file:

TODO: ADD DEPLOY JOB

```yaml
```

In the `pipeline.yml`, scroll to the `deploy` job section and review the following:

* **Job Dependencies**: The `deploy` job runs *after* the `test-image` job (`needs: test-image`).
* **Permissions**: The job requires `packages: read` and `id-token: write` for authentication and access.
* **Steps**:

  * Logs into GitHub Container Registry.
  * Authenticates to Google Cloud using the provided secrets.
  * Sets up the GCP CLI and configures Docker for GCP.
  * Pulls the image built earlier.
  * Tags and pushes the image to GCP Artifact Registry.
  * Deploys the image to a Cloud Run service.
  * Tests the live deployment with HTTP requests to validate the service is running correctly.


### Step 5: Run the Workflow

1. Push your changes to GitHub.
2. Go to the **Actions** tab and monitor the run titled **Pipeline**.
3. Expand the `deploy` job and review each step as it completes.
4. Confirm that the final step (testing the live app) completes successfully.


### Step 6: Troubleshooting Notes

* Warnings may appear in the GitHub web editor when viewing the `deploy` job; check the exercise notes for clarification. TODO: ADD NOTES.
* Be sure that your GCP service account has permission to deploy services and push images.  Use the "Escape Hatch" if you can't get GCP to authenticate. TODO: ADD ESCAPE_HATCH SECTION

## SHENANIGANS

Right now the lab is set up to work with GCP.  In the future, the following may be added:

* TODO: ADD STEPS FOR AUTHENTICATING WITH AWS AND DEPLOYING TO APP RUNNER
* TODO: ADD STEPS FOR AUTHENTICATING WITH AZURE AND DEPLOYING TO AZURE CONTAINER SERVICES

<!-- FooterStart -->
---
[← 03_04 Testing](../03_04_testing/README.md) | [03_06 Add a Workflow Status Badge →](../03_06_add_a_workflow_status_badge/README.md)
<!-- FooterEnd -->
