# 04_06 Use Runtime Environment Resources

Every GitHub Actions workflow runs inside a virtual environment.

In this lesson, we explore the built-in resources that your custom action can take advantage of—such as environment variables, compute resources, and event payloads.

Understanding these runtime resources will help you write smarter and more flexible actions.

## Summary

When a workflow runs, GitHub provides a containerized virtual environment with:

- **Compute power**: A virtual machine with CPU and memory for running actions.
- **Storage**: Up to 100 GB of temporary disk space, including a home directory and workspace.
- **Environment variables**: Predefined variables for accessing GitHub metadata, tokens, and event payloads.

These resources can be used by your action's script to retrieve information about the repository, the event that triggered the workflow, and other contextual data.

## Key Variables

| Variable | Description |
|----------|-------------|
| `GITHUB_TOKEN` | A short-lived auth token used to access the GitHub API. Must be passed explicitly to steps or scripts. |
| `GITHUB_REPOSITORY` | A string in the format `owner/repo`, helpful for constructing API requests. |
| `GITHUB_EVENT_PATH` | The path to a local JSON file that contains the event payload (e.g., push, pull request, issue). |

## Tip

You can explore the payloads for supported GitHub events by visiting:
[GitHub Events and Payloads Documentation](https://docs.github.com/en/webhooks-and-events/webhooks/webhook-events-and-payloads)

<!-- FooterStart -->
---
[← 04_05 Add an Entry-Point Script](../04_05_add_an_entrypoint_script/README.md) | [04_07 Test an Action →](../04_07_test_an_action/README.md)
<!-- FooterEnd -->
