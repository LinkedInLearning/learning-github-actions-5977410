# 00_02 What You Should Know

TODO: COPY FINAL VERSION FROM GOOGLE DOCS

This document covers the prerequisites you need for getting the most out of this course.

## GitHub

Before diving into GitHub Actions, you should have some  experience using GitHub.

Specifically, you’ll need:

- A **[GitHub account](https://github.com/join)**.
- Familiarity with creating and using Git repositories on github.com.
- An understanding of how to work with repository branches.
- The ability to push updated code to a repository as a commit.
- Experience working with pull requests — including how to open one and merge it into a branch.

If you need a primer on working with GitHub, you can find courses here on LinkedIn Learning to get you up to speed.

- TODO: LIST COURSES HERE

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

- [Learning GitHub Actions](https://github.com/LinkedInLearning/learning-github-actions-5977410/tree/main)

### Download the Repository as a ZIP File

Download the files directly:

1. Visit the repository link above.
1. Select the green **Code** button.
1. Choose **Download ZIP** from the dropdown.
1. Extract the contents of the ZIP file to a folder on your local machine.

### Uploading the Exercise Files to a New GitHub Repository

Some lessons will require you to create a new repository and upload the files for that lesson.

Here's how to do that using GitHub's integrated interface:

1. **Create a new repository** on GitHub:
   - Go to [github.com](https://github.com).
   - Select the **+** icon in the top-right corner and choose **New repository**.
   - Name your repository and choose whether it should be public or private.
   - Select **Create repository**.

2. **Upload the exercise files**:
   - After creating the repository, select **Add file > Upload files**.
   - Drag and drop your extracted exercise files into the upload area.
   - **Important:** GitHub does not support uploading entire folders directly through the web interface. This means the `.github` folder (which contains workflows) may not appear if you try to upload it with drag-and-drop.
   - TODO: Add more specific steps for uploading files in directories as needed

### Using GitHub's Integrated Development Environment

We’ll be using GitHub’s integrated development tools via **GitHub.dev** to view and modify files.

> [!TIP]
> To open a repository in GitHub.dev, press the **`.`** key while viewing the repo on GitHub.

Using the integrated development environment makes it easy to follow along with the course without needing to install anything on your local machine.


<!-- FooterStart -->
---
[← 00_01 Automating With GitHub Actions](../00_01_automating_with_github_actions/README.md) | [00_03 Working With YAML Files →](../00_03_working_with_yaml_files/README.md)
<!-- FooterEnd -->
