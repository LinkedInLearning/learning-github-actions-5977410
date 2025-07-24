# 02_08 Solution: Develop a Workflow That Creates Artifacts

In this challenge, you’ll develop a GitHub Actions workflow for a Javascript application.

The goal is to run jobs that create and use artifacts.

In addition, you will use an Action from the GitHub Marketplace to set up an environment to use the Bun Javascript runtime.

- [Github Marketplace: Setup Bun](https://github.com/marketplace/actions/setup-bun)

You will also configure actions with parameters to complete their required function.

## Overview

You will complete the following steps in this challenge:

1. **Create a new GitHub repository** using the Node `.gitignore` template.
2. **Open the repository in the GitHub Web Editor** to add code and workflows.
3. **Add the provided files** for the Javascript application along with updating `.gitignore` for the project.
4. **Create a multi-job workflow** triggered by `push` and `workflow_dispatch` events with three jobs that run in the order listed:

   - One job that tests the application code, saving the test report as an artifact
   - One job that creates executables from the application code, saving all executables  as artifacts
   - One job that tests the Linux executable, saving the test report as an artifact

5. **Push changes to the repository** to trigger the workflow.
6. **Review the Actions tab** to confirm the workflow executed successfully and that all artifacts were created

This challenge should take about 15 to 20 minutes to complete.

## Instructions

### Create a New Repository

1. Go to [https://github.com](https://github.com) and select **New repository**.
2. Name the repository (e.g., `create-artifacts`).
3. Choose **Public** or **Private** visibility.
4. Select **Add .gitignore** and choose the **Node** template.
5. Leave other options as default and select **Create repository**.

### Open the Repository in the GitHub Web Editor

1. In your new repository, press the `.` key on your keyboard to open the Web Editor. Alternatively, change the URL from `github.com` to `github.dev` (e.g., `https://github.dev/your-username/create-artifacts`).

### Upload the Javascript application files

1. Download the following files and add them to the root of the repository:
   - [random-number-generator.js](https://github.com/LinkedInLearning/learning-github-actions-5977410/blob/main/ch2_selecting_and_using_actions/02_07_challenge_develop_a_workflow_that_creates_artifacts/random-number-generator.js)
   - [package.json](https://github.com/LinkedInLearning/learning-github-actions-5977410/blob/main/ch2_selecting_and_using_actions/02_07_challenge_develop_a_workflow_that_creates_artifacts/package.json)
2. Edit `.gitignore` and add the following at the end of the file:

```shell
# Prevent project files from being tracked by git
*.bun-build
bun.lock
report.txt
package-lock.json
random-number-generator-*
```

### Create the Workflow File

1. In the Web Editor, create the `.github/workflows/` folder.
2. Create a new file named `create-artifacts.yml`.
3. Use the following instructions to create the workflow configuration step-by-step.

### Define the Trigger and Jobs

1. Name the workflow `Create Artifacts`.
2. Configure the workflow to trigger on `push` and `workflow_dispatch` events.
3. Define three jobs:

   - `test` (named `Test Code`, runs on `ubuntu-latest`)
   - `build` (named `Build Executables`, runs on `ubuntu-latest`)
   - `test-linux` (named `Test Linux Executable`, runs on `ubuntu-latest`)

4. Use `runs-on` to configure the runner for each job.
5. The `build` job should run after the `test` job. The `test-linux` job should run after the `build` job.

```yaml
name: Create Artifacts

on: [push, workflow_dispatch]

jobs:
  test:
    name: Test Code
    runs-on: ubuntu-latest

  build:
    name: Build Executables
    runs-on: ubuntu-latest
    needs: test

  test-linux:
    name: Test Linux Executable
    runs-on: ubuntu-latest
    needs: build
```

### Configure the `test` Job

1. **Checkout the code**: `- uses: actions/checkout@v4`
2. **Set up Bun environment**: `- uses: oven-sh/setup-bun@v2`
   1. **Note:** Add `with` to pass the parameter `bun-version: latest`.
3. **Install dependencies**: `run: bun install`
4. **Use a multi-line run step to run the commands**:
   1. `bun run random-number-generator.js`
   2. `bun run random-number-generator.js "test-seed"`
   3. `bun run random-number-generator.js 1906`
5. **Upload the file \`report.txt\` as an artifact named test-report**: `uses: actions/upload-artifact@v4`
   1. **Note:** Add `with` to pass the parameters:
      1. `name: test-report`
      2. `path: report.txt`

```yaml
 test:
    name: Test Code
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Bun
        uses: oven-sh/setup-bun@v2
        with:
          bun-version: latest

      - name: Install dependencies
        run: bun install

      - name: Test with different seeds
        run: |
          echo "Testing with no seed..."
          bun run random-number-generator.js
          echo ""

          echo "Testing with string seed..."
          bun run random-number-generator.js "test-seed"
          echo ""

          echo "Testing with numeric seed..."
          bun run random-number-generator.js 1906
          echo "Generated report:"
          cat report.txt

      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: test-report
          path: report.txt
```

### Configure the `build` Job

1. **Checkout the code**: `- uses: actions/checkout@v4`
2. **Set up Bun environment**: `- uses: oven-sh/setup-bun@v2`
   1. **Note:** Add `with` to pass the parameter `bun-version: latest`.
3. **Install dependencies**: `run: bun install`
4. **Create the executables**: `run: bun run build`
5. **List the executables created**: `run: ls -la random-number-generator-*`
6. **Create an artifact named `random-number-generator-executables`** using all that match the pattern `./random-number-generator-*`.
   1. **Note:** Add `with` to pass the parameters:
      1. `name: random-number-generator-executables`
      2. `path: ./random-number-generator-*`

```yaml
 build:
    name: Build Executables
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Bun
        uses: oven-sh/setup-bun@v2
        with:
          bun-version: latest

      - name: Install dependencies
        run: bun install

      - name: Build for all platforms
        run: bun run build

      - name: List executables
        run: ls -la random-number-generator-*

      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: random-number-generator-executables
          path: ./random-number-generator-*
```

### Configure the `test-linux` Job

1. **Download the artifact** named `random-number-generator-executables`: `uses: actions/download-artifact@v4`
2. **Make the linux binary executable:** `run: chmod +x random-number-generator-linux`
3. **Install dependencies**: `run: bun install`
4. **Use a multi-line run step to run the commands**:
   1. `./random-number-generator-linux`
   2. `./random-number-generator-linux "test-seed"`
   3. `./random-number-generator-linux 1906`
5. **Upload the file \`report.txt\` as an artifact named linux-test-report**: `uses: actions/upload-artifact@v4`
   1. **Note:** Add `with` to pass the parameters:
      1. `name: linux-test-report`
      2. `path: report.txt`

```yaml
 test-linux:
    name: Test Linux Executable
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Download artifacts
        uses: actions/download-artifact@v4
        with:
          name: random-number-generator-executables

      - name: Make binary executable
        run: chmod +x random-number-generator-linux

      - name: Test Linux executable
        run: |
          echo "Testing with no seed..."
          ./random-number-generator-linux
          echo ""

          echo "Testing with string seed..."
          ./random-number-generator-linux 1906 "test-seed"
          echo ""

          echo "Testing Linux executable with numeric seed..."
          ./random-number-generator-linux 1906

      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: linux-test-report
          path: report.txt
```

### The Complete Workflow

Your complete workflow should be similar to the following:

- [create-artifacts.yml](./create-artifacts.yml)

```yaml
name: Create Artifacts

on: [push, workflow_dispatch]

jobs:
  test:
    name: Test Code
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Bun
        uses: oven-sh/setup-bun@v2
        with:
          bun-version: latest

      - name: Install dependencies
        run: bun install

      - name: Test with different seeds
        run: |
          echo "Testing with no seed..."
          bun run random-number-generator.js
          echo ""

          echo "Testing with string seed..."
          bun run random-number-generator.js "test-seed"
          echo ""

          echo "Testing with numeric seed..."
          bun run random-number-generator.js 1906

      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: test-report
          path: report.txt

  build:
    name: Build Executables
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Bun
        uses: oven-sh/setup-bun@v2
        with:
          bun-version: latest

      - name: Install dependencies
        run: bun install

      - name: Build for all platforms
        run: bun run build

      - name: List executables
        run: ls -la random-number-generator-*

      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: random-number-generator-executables
          path: ./random-number-generator-*

  test-linux:
    name: Test Linux Executable
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Download artifacts
        uses: actions/download-artifact@v4
        with:
          name: random-number-generator-executables

      - name: Make binary executable
        run: chmod +x random-number-generator-linux

      - name: Test Linux executable
        run: |
          echo "Testing with no seed..."
          ./random-number-generator-linux
          echo ""

          echo "Testing with string seed..."
          ./random-number-generator-linux 1906 "test-seed"
          echo ""

          echo "Testing Linux executable with numeric seed..."
          ./random-number-generator-linux 1906
          echo ""

      - name: Upload artifacts
        uses: actions/upload-artifact@v4
        with:
          name: linux-test-report
          path: report.txt
```

### Push Changes to the Repository

1. In the Web Editor, stage and commit all your changes.
2. Push the changes to your repository’s default branch (usually `main`).
3. This push will trigger the workflow automatically.

   ![Commit changes to the repo][image1]

### Review Workflow Results

1. Go to your repository on GitHub and select the **Actions** tab.

   ![View the Actions tab][image2]

2. Select the most recent run triggered by your push.

   ![View the most recent workflow][image3]

3. Review the output for each job.

   ![Review the logs for the `test` job][image4]
   ![Review the logs for the `build` job][image5]
   ![Review the logs for the `test-linux` job][image6]

4. Go back to the Summary page of the workflow run.  Confirm the presence of the three artifacts: `linux-test-report`, `random-number-generator-executables`, and `test-report`.

   ![Review the artifacts on the summary page][image7]

[image1]: ./images/02_07_chlg_and_02_08_soln_1.png
[image2]: ./images/02_07_chlg_and_02_08_soln_2.png
[image3]: ./images/02_07_chlg_and_02_08_soln_3.png
[image4]: ./images/02_07_chlg_and_02_08_soln_4.png
[image5]: ./images/02_07_chlg_and_02_08_soln_5.png
[image6]: ./images/02_07_chlg_and_02_08_soln_6.png
[image7]: ./images/02_07_chlg_and_02_08_soln_7.png

<!-- FooterStart -->
---
[← 02_07 Challenge: Develop a Workflow That Creates Artifacts](../02_07_challenge_develop_a_workflow_that_creates_artifacts/README.md) | [03_01 Plan Your CI/CD Pipeline →](../../ch3_developing_a_cicd_workflow/03_01_plan_your_cicd_pipeline/README.md)
<!-- FooterEnd -->
