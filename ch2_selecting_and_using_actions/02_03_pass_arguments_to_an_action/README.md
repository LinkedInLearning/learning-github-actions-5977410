# 02_03 Pass Arguments to an Action

Most actions in GitHub Actions work without any additional input, but there are times when you'll need to customize how an action behaves.

This lesson will show you how to pass arguments to actions using the `with` attribute.

## Overview

In this challenge, you will:

- Create a workflow to build Apache Tomcat with a custom user file
- Use the `with` attribute to pass arguments to actions
- Clone a different repository using the `actions/checkout` action
- Set up a custom Java environment using the `setup-java` action
- Confirm your actions and arguments worked as expected

## Instructions

### 1. Create the Workflow Directory and File

1. **Create a new GitHub repository** using the Java `.gitignore` template.
1. **Open the repository in the GitHub Web Editor** to add code and workflows.
1. Add the exercise file [`tomcat-users.xml`](./tomcat-users.xml) to the root of the repository.
1. Create a new directory named `.github/workflows`.
1. Inside the `workflows` directory, add the exercise file [`build-tomcat.yml`](./build-tomcat.yml).

### 2. Review Key Steps and Arguments

- **Check out tomcat-users.xml** gets the local repository files including `tomcat-users.xml`.
- **List project files and java version** prints the current files and Java version — the Ubuntu runner defaults to OpenJDK 17.
- **Checkout the Tomcat repo** pulls the Apache Tomcat source from the official GitHub repo using a `with` block:

  - `repository`: sets the repo to clone (`apache/tomcat`)
  - `ref`: specifies the branch (`main`)
  - `path`: sets the directory where the code will be checked out (`tomcat`)

- **Setup Java** uses the `with` block to define:

  - `java-version`: set to 21
  - `distribution`: set to `jdk`
  - `architecture`: set to `x64`

- The final steps:

  - Print updated file list and Java version
  - Copy the custom user XML file into the correct Tomcat config directory
  - Run the Tomcat build script

### 3. Push the Changes, Trigger the Workflow, and Review the Logs

1. In the GitHub web editor, select the **Source Control** tab from the menu on the left-hand side.
1. Enter a commit message. For example, `add files to build tomcat`.
1. Select the **Commit & Push** button.

    Note: The exact button label might vary depending on your setup, but it will typically include "Commit".

1. At the top of the left-hand navigation panel, select **Go to Repository**.
1. In the repository view, select the **Actions** tab.
1. You should see a workflow run listed with a label matching your commit message.
1. Select that workflow run to open the details.
1. Expand the logs for:

   - The first **List project files and java version** step to confirm the default JDK and only your initial files are present.
   - The second **List project files and java version** step to confirm the JDK has been updated to version 21 and the `tomcat` directory exists.

1. Confirm that all complete successfully.

Once you're done, you're ready to move on to the next lesson: using environment variables with actions.

<!-- FooterStart -->
---
[← 02_02 Use an Action From a Repository](../02_02_use_an_action_from_a_repository/README.md) | [02_04 Use Environment Variables →](../02_04_environment_variables/README.md)
<!-- FooterEnd -->
