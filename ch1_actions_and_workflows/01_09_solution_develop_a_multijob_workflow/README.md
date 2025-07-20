# 01_09 Solution: Develop a Multi-Job Workflow

In this challenge, you’ll create a GitHub Actions workflow that compiles and runs Go code across multiple operating systems.

You’ll also add a final job that performs cross-compilation to build binaries for multiple platforms.

## Overview

You will complete the following steps in this challenge:

1. **Create a new GitHub repository** using the Go `.gitignore` template.
2. **Open the repository in the GitHub Web Editor** to add code and workflows.
3. **Create the file `main.go` file**.
4. **Add a multi-job workflow** triggered by `push` events with four jobs:

   * One job each for Ubuntu, Windows, and macOS.
   * A fourth job that runs after the first three jobs complete.

5. **Push changes to the repository** to trigger the workflow.
6. **Review the Actions tab** to confirm the workflow executed successfully on all platforms.

This challenge should take about 15 to 20 minutes to complete.

### Instructions

#### Create a New Repository

1. Go to [https://github.com](https://github.com) and select **New repository**.
2. Name the repository (e.g., `multi-job-workflow`).
3. Choose **Public** or **Private** visibility.
4. Select **Add .gitignore** and choose the **Go** template.
5. Leave other options as default and select **Create repository**.

#### Open the Repository in the GitHub Web Editor

1. In your new repository, press the `.` key on your keyboard to open the Web Editor. Alternatively, change the URL from `github.com` to `github.dev` (e.g., `https://github.dev/your-username/multi-job-workflow`).

#### Create the `main.go` File

1. In the Web Editor, create a new file in the root of the repository named `main.go`.
2. Copy and paste the following Go code into the file and save it.

```go
package main

import (
 "fmt"
 "time"
)

type AWSRegion struct {
 Name     string
 Timezone string
}

func main() {
 // AWS regions in order from West to East
 awsRegions := []AWSRegion{
  // Americas
  {"us-west-1", "America/Los_Angeles"},
  {"us-west-2", "America/Los_Angeles"},
  {"ca-central-1", "America/Toronto"},
  {"us-east-1", "America/New_York"},
  {"us-east-2", "America/New_York"},
  {"sa-east-1", "America/Sao_Paulo"},

  // Europe
  {"eu-west-1", "Europe/Dublin"},
  {"eu-west-2", "Europe/London"},
  {"eu-west-3", "Europe/Paris"},
  {"eu-central-1", "Europe/Berlin"},
  {"eu-north-1", "Europe/Stockholm"},

  // Asia-Pacific
  {"ap-south-1", "Asia/Kolkata"},
  {"ap-southeast-1", "Asia/Singapore"},
  {"ap-northeast-2", "Asia/Seoul"},
  {"ap-northeast-1", "Asia/Tokyo"},
  {"ap-southeast-2", "Australia/Sydney"},
 }

 // Get current UTC time
 now := time.Now()

 fmt.Println("=========================================")
 fmt.Println("Current UTC Time:", now.Format("2006-01-02 15:04:05 MST"))
 fmt.Println("=========================================")
 fmt.Println()
 fmt.Println("=============================")
 fmt.Println("AWS Data Center Current Times")
 fmt.Println("=============================")

 // Display times in the order specified
 for _, region := range awsRegions {
  loc, err := time.LoadLocation(region.Timezone)
  if err != nil {
   fmt.Printf("Error loading timezone for %s: %v\n", region.Name, err)
   continue
  }

  regionalTime := now.In(loc)
  fmt.Printf("%-15s | %s | %s\n",
   region.Name,
   regionalTime.Format("2006-01-02 15:04:05 MST"),
   region.Timezone)
 }
}
```

#### Add the Workflow File

1. In the Web Editor, create the `.github/workflows/` folder.
2. Create a new file named `multi-job.yml`.
3. Use the following instructions to create the workflow configuration step-by-step.

#### Define the Trigger and Jobs

1. Name the workflow `Multi-Job Workflow`.
2. Configure the workflow to trigger on `push` events.
3. Define four jobs:

   * `ubuntu` (runs on `ubuntu-latest`)
   * `windows` (runs on `windows-latest`)
   * `macos` (runs on `macos-latest`)
   * `cross-compile` (runs on `ubuntu-latest` and depends on the first three)
4. Use `runs-on` to configure the runner for each job.

```yaml
name: Multi-Job Workflow
on: [push]

jobs:
  ubuntu:
    runs-on: ubuntu-latest

  windows:
    runs-on: windows-latest

  macos:
    runs-on: macos-latest

  cross-compile:
    runs-on: ubuntu-latest
```

#### Configure Jobs 1–3 (Ubuntu, Windows, macOS)

For each of the first three jobs:

1. Under each job, add the following steps:

   * **Checkout the code**: `- uses: actions/checkout@v4`
   * **Set up Go environment**: `- uses: actions/setup-go@v5.5`
   * **Compile the Go file**: `- run: go build -o main main.go`
     1. **Note:** For the `windows` job, use `main.exe` instead of `main`.
   * **Run the compiled binary**: `- run: ./main`
     1. **Note:** For the `windows` job, use `.\main.exe` instead of `./main`.

Ubuntu and macOS:

```yaml
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v5.5.0
        with:
          go-version: "1.20"

      - name: Build Go binary
        run: go build -o main main.go

      - name: Run binary
        run: ./main
```

Windows:

```yaml
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v5.5.0
        with:
          go-version: "1.20"

      - name: Build Go binary
        run: go build -o main.exe main.go

      - name: Run binary
        run: .\main.exe
```

#### Configure the Fourth Job (Cross-Compile)

1. Define the fourth job with `runs-on: ubuntu-latest`.
2. Add the `needs` attribute so that it waits for the three previous jobs to finish: `needs: [ubuntu, windows, macos]`

3. Add the following steps:

   * **Checkout the code:** `- uses: actions/checkout@v4`
   * **Set up Go environment:** `- uses: actions/setup-go@v5.5`
   * **Use a multi-line** `run` **command to build binaries for each platform**.

```yaml
  cross-compile:
    runs-on: ubuntu-latest
    needs: [ubuntu, windows, macos]
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v5.5.0
        with:
          go-version: "1.20"

      - name: Cross-compile for all platforms
        run: |
          echo "Cross compiling for all platforms:"
          GOOS=linux GOARCH=amd64 go build -o main-linux main.go
          GOOS=windows GOARCH=amd64 go build -o main-windows.exe main.go
          GOOS=darwin GOARCH=amd64 go build -o main-macos-intel main.go

```

#### The Complete Workflow

Your complete workflow should be similar to the following:

```yaml
name: Multi-Job Workflow
on: [push]

jobs:
  build-ubuntu:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v5.5
        with:
          go-version: "1.20"

      - name: Build Go binary
        run: go build -o main main.go

      - name: Run binary
        run: ./main

  build-windows:
    runs-on: windows-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v5.5.0
        with:
          go-version: "1.20"

      - name: Build Go binary
        run: go build -o main.exe main.go

      - name: Run binary
        run: .\main.exe

  build-macos:
    runs-on: macos-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v5.5.0
        with:
          go-version: "1.20"

      - name: Build Go binary
        run: go build -o main main.go

      - name: Run binary
        run: ./main

  cross-compile:
    runs-on: ubuntu-latest
    needs: [ubuntu, windows, macos]
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v5.5.0
        with:
          go-version: "1.20"

      - name: Cross-compile for all platforms
        run: |
          echo "Cross compiling for all platforms:"
          GOOS=linux GOARCH=amd64 go build -o main-linux main.go
          GOOS=windows GOARCH=amd64 go build -o main-windows.exe main.go
          GOOS=darwin GOARCH=amd64 go build -o main-macos-intel main.go
```

#### Push Changes to the Repository

1. In the Web Editor, stage and commit all your changes.
2. Push the changes to your repository’s default branch (usually `main`).
3. This push will trigger the workflow automatically.

#### Review Workflow Results

1. Go to your repository on GitHub and select the **Actions** tab.
   ![View the Actions tab][image1]
2. Select the most recent run triggered by your push.
   ![View the most recent workflow][image2]
3. Review the logs for each job.
   ![Review the logs for each job - part 1][image3]
   ![Review the logs for each job - part 2][image4]

[image1]: images/01_08_chlg_and_01_09_soln_1.png
[image2]: images/01_08_chlg_and_01_09_soln_2.png
[image3]: images/01_08_chlg_and_01_09_soln_3.png
[image4]: images/01_08_chlg_and_01_09_soln_4.png

<!-- FooterStart -->
---
[← 01_08 Challenge: Develop a Multi-Job Workflow](../01_08_challenge_develop_a_multijob_workflow/README.md) | [02_01 Use an Action From the Marketplace →](../../ch2_selecting_and_using_actions/02_01_use_an_action_from_the_marketplace/README.md)
<!-- FooterEnd -->
