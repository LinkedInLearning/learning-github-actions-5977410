# 00_02 What You Should Know

## What You Should Know

This document covers the prerequisites you need for getting the most out of this course.

## GitHub

Before diving into GitHub Actions, you should have some  experience using GitHub.

Specifically, you’ll need:

- A [**GitHub account**](https://github.com/join).
- Familiarity with creating and using Git repositories on github.com.
- An understanding of how to work with repository branches.
- The ability to push updated code to a repository as a commit.

If you need a primer on working with GitHub, you can find courses here on LinkedIn Learning to get you up to speed.

- [Learning GitHub (18719601)](https://www.linkedin.com/learning/learning-github-18719601)
  - Duration: 1h 3m
  - Skill level: Beginner

- [GitHub Essential Training: 1 The Basics (4378192)](https://www.linkedin.com/learning/github-essential-training-1-the-basics)
  - Duration: 1h 2m
  - Skill level: Beginner

## YAML

GitHub workflows are defined using **YAML**, a human-readable data serialization format.

- Familiarity with YAML is helpful, but not required.
- If you haven’t worked with YAML before, don’t worry — it’s easy to learn, and we’ll review the basics throughout the course.

## Containers and Scripting

- **Containers** play a key role in creating custom GitHub Actions.

  If you’re already comfortable with using a `Dockerfile` to describe a container image, you’ll be ready to create your own actions.

  We’ll also cover the essential concepts and keywords you need to know.

- **Scripting** plays a big part in creating the plans that call GitHub Actions.

  It will help if you’re familiar with scripting for Bash or PowerShell or programming in a higher level language like Python or Ruby.

## Using the Exercise Files

To help you get the most out of this course, **exercise files** are available for you to use as you follow along with the course content.

Find the exercise files in the following GitHub repository:

- [Learning GitHub Actions (5977410)](https://github.com/LinkedInLearning/learning-github-actions-5977410/tree/main)

### Downloading the Repository as a ZIP File

Use the following steps to download the files from the repository:

1. Visit the repository link above.
2. Select the green **Code** button.
3. Choose **Download ZIP** from the dropdown.
4. Extract the contents of the ZIP file to a folder on your local machine.

### Uploading the Exercise Files to a New GitHub Repository

Some lessons will require you to create a new repository and upload the files for that lesson.

Here's how to do that using GitHub's integrated interface:

1. **Create a new repository** on GitHub:

   - Go to [github.com](https://github.com).
   - Select the **\+** icon in the top-right corner and choose **New repository**.
   - Name your repository and choose whether it should be public or private.
   - Select **Create repository**.

2. **Upload the exercise files**:

   - After creating the repository, select **Add file \> Upload files**.
   - Drag and drop your extracted exercise files into the upload area or select them using the file browser.
   - **Important:** GitHub does not support uploading entire folders directly through the web interface. This means lessons with files in subfolders may require multiple uploads or files may need to be moved into place after they are uploaded.

### Using GitHub's Integrated Development Environment

We’ll also be using GitHub’s web-based development tools to view and modify files.

Using the integrated development tools makes it easy to follow along with the course without needing to install anything on your local machine.

- [**GitHub.dev**](https://github.dev/github/dev):
  - GitHub.dev provides a lightweight editor, allowing you to modify code and push updates to your repository without leaving your browser.
  - To open a repository in GitHub.dev, press the **`.`** key while viewing the repo on GitHub.
- [**Codespaces**](https://github.com/features/codespaces):
  - Codespaces provides a secure, configurable, and dedicated development environment in the browser.  Along with a code editor, it provides access to a terminal and development tools.
  - To open a repository in Codespaces, select **Code** -> **Codespaces** -> **Create codespace on main**

## Software Versions

This section describes the software versions that were used in the most recent update of this course.

### Windows

- Windows Server 2022, 10.0.20348 Build 3932

### macOS

- macOS 14.7.6 (23H626)

### Linux

- Ubuntu 24.04.2 LTS

### GitHub Actions

- actions/checkout@v4.2.2
- actions/download-artifact@v4.3.0
- actions/setup-go@v5.5.0
- actions/setup-java@v3.14.1
- actions/setup-python@v5.6.0
- actions/upload-artifact@v4.6.2
- aws-actions/configure-aws-credentials@v4.2.1
- docker/build-push-action@v6.18.0
- docker/login-action@v3.4.0
- docker/metadata-action@v5.8.0
- docker/setup-buildx-action@v3.11.1
- google-github-actions/auth@v2.1.12
- google-github-actions/deploy-cloudrun@v2.7.4
- google-github-actions/setup-gcloud@v2.1.5
- oven-sh/setup-bun@v2.0.2

<!-- FooterStart -->
---
[← 00_01 Automating With GitHub Actions](../00_01_automating_with_github_actions/README.md) | [00_03 Working With YAML Files →](../00_03_working_with_yaml_files/README.md)
<!-- FooterEnd -->
