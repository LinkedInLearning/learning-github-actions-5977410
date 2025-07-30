# 02_05 Use Secrets

In this lesson, you'll learn how to securely use secrets in GitHub Actions workflows.

While environment variables are helpful for configuration, secrets are necessary when working with sensitive data like API keys or passwords. GitHub provides a secure way to store and reference these secrets during workflow execution without exposing their values.

> [!NOTE]
> Creating environments and environment-level secrets is beyond the scope of this course.

## Overview

This lesson walks you through:

- Creating a GitHub Actions workflow that uses AWS credentials.
- Storing AWS credentials and region values as encrypted secrets in a GitHub repository.
- Accessing those secrets securely within your workflow file.
- Running the workflow to confirm sensitive values remain protected.

## References

- [Using secrets in GitHub Actions](https://docs.github.com/en/actions/how-tos/writing-workflows/choosing-what-your-workflow-does/using-secrets-in-github-actions)
- [Secrets reference - GitHub Docs](https://docs.github.com/en/actions/reference/secrets-reference)
- [How to Create an AWS Account](https://aws.amazon.com/resources/create-account/)

## Instructions

1. Create a new GitHub repository and select the **Settings** menu tab.
1. In the left-hand menu, select **Secrets and variables**, then choose **Actions**.
1. Under the **Repository secrets** section, add the following secrets:

   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_REGION`

  _*NOTE: If you have an AWS account and actual access keys, feel free to use them.  Otherwise, using fake data for the key values will suffice.  However, **if the keys are not valid the workflow will fail**.  You'll still be able to confirm that the values you entered were protected as secrets.*_

1. In the root of your GitHub repository, create the `.github/workflows` directory.
1. Create a file named [`use-secrets.yml`](./use-secrets.yml) in the `.github/workflows` directory with the following contents:

    ```yaml
    name: Use Secrets

    # Trigger the workflow on push events
    on: [push]

    jobs:
    build:

        # Specify the environment where the job will run
        runs-on: ubuntu-latest

        steps:
        - name: Configure AWS Credentials
            # Use the aws-actions/configure-aws-credentials action to set up AWS credentials
            # https://github.com/marketplace/actions/configure-aws-credentials-action-for-github-actions
            uses: aws-actions/configure-aws-credentials@v4.2.1
            with:
            # Use secrets to store sensitive information
            aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
            aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

            # Create a secret named AWS_REGION to store the region value
            aws-region: us-west-2

        - name: Get caller identity
            # Run a command to get the details for the account in use
            run: aws sts get-caller-identity

        - name: List S3 Buckets
            # Run a command to list all S3 buckets
            run: aws s3api list-buckets
    ```

1. Replace the hard-coded region value `us-west-2` with the region secret:

    ```yaml
    aws-region: ${{ secrets.AWS_REGION }}
    ```

1. Select **Commit changes...**
1. Confirm the commit by selecting **Commit changes...** again.
1. Select the **Actions** tab at the top of your repository.
1. Choose the most recent workflow run.
1. Expand the job by selecting the entry under the **"use-secrets"** job.
1. Locate the **Configure AWS credentials** step and expand it.

You should see that the secrets passed into the action are protected: instead of showing the actual values, GitHub masks them using asterisks.

<!-- FooterStart -->
---
[← 02_04 Use Environment Variables](../02_04_environment_variables/README.md) | [02_06 Create and Use Artifacts →](../02_06_artifacts/README.md)
<!-- FooterEnd -->
