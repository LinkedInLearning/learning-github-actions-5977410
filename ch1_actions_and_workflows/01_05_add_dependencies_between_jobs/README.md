# 01_05 Add Dependencies Between Jobs

In the previous lesson, you created a workflow where two jobs ran in parallel.

But what if one job depends on the output of another?

In this lecture, you’ll learn how to use the `needs` attribute in a GitHub Actions workflow to define dependencies between jobs. This allows you to control the order in which jobs run, making it possible to build more complex workflows.

## Overview

In this lesson, you will:

- Understand how jobs run in parallel by default.
- Learn how to use the `needs` attribute to make one job wait for another.
- See an example of a job that depends on multiple others.

## 1. Default Job Execution

- By default, all jobs in a workflow run in parallel.
- This can cause issues if one job relies on the output of another.

## 2. Add the `needs` Attribute to Define a Dependency

- Use the `needs` attribute to specify that a job depends on the successful completion of another.
- Consider the following workflow snippet:

    ```yaml
    jobs:
      job1:
      job2:
        needs: job1
    ```

- In this example, `job2` will not run until `job1` has completed successfully.

### 3. Chain Multiple Jobs with Dependencies

- You can build longer sequences or more complex execution trees by chaining jobs.
- When multiple jobs are specified for the `needs` attribute, use a bracketed list.
- Consider the following workflow snippet:

    ```yaml
    jobs:
      job1:
      job2:
        needs: job1
      job3:
        needs: [job1, job2]
    ```

- In this example, `job1` and `job2` will run in parallel.
- `job3` will only run after both `job1` and `job2` have completed successfully.
- This design pattern is useful for workflows with testing, building, and deployment phases.

<!-- FooterStart -->
---
[← 01_04 Run a Workflow](../01_04_run_a_workflow/README.md) | [01_06 Specify Branches for Workflow Events →](../01_06_specify_branches_for_workflow_events/README.md)
<!-- FooterEnd -->
