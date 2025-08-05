# 01_07 Workflow and Action Limits

## References

- [GitHub Actions Limits](https://docs.github.com/en/actions/reference/limits): Provides a comprehensive list of the limits applied to the GitHub Actions platform.

## Summary

> [!IMPORTANT]
> These limits are subject to change.

| **Category**  | **Limit**| **Details**|
| ------------- | ----------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Workflows** | Concurrent workflow runs      | Maximum of 20 workflows can run at the same time per repository. Additional workflows will queue.    |
| **Jobs**      | Concurrent jobs               | Depends on your GitHub plan. For the free plan, limit is 20 concurrent jobs across all repositories. |
|               | Job runtime                   | Each job can run for a maximum of 6 hours. Longer-running jobs are automatically stopped.            |
| **Actions**   | GitHub API rate limit         | Actions using the GitHub API are limited to 1,000 API requests per hour per repository.              |
|               | Actions can’t trigger other Workflows | This helps avoid infinite loops |
|               | Log output size               | Each step’s log output is truncated at 64 KB. Excess log content is cut off.                         |

<!-- FooterStart -->
---
[← 01_06 Specify Branches for Workflow Events](../01_06_specify_branches_for_workflow_events/README.md) | [01_08 Challenge: Develop a Multi-Job Workflow →](../01_08_challenge_develop_a_multijob_workflow/README.md)
<!-- FooterEnd -->
