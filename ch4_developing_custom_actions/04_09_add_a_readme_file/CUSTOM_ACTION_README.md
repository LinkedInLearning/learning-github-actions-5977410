# Test Scout

**A GitHub Action that scans Python repositories for test files and reports test coverage based on a customizable pattern.**

This action helps teams enforce or encourage test coverage by identifying when Python source files exist but no matching test files are found.

It can be used passively to generate reports or actively to fail workflows using `strict_mode`.

## Inputs

| Name | Description | Required | Default |
|------|-------------|----------|---------|
| `pattern` | File glob pattern used to detect test files | No | `test_*.py` |
| `strict_mode`| If set to `true`, the action fails when no test files are found | No | `false` |

## Outputs

> [!IMPORTANT]
> This action does not currently set any outputs.

## Example Usage

```yaml
name: Python Project

on: [push]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Check for test files
        uses: YOUR_GITHUB_USER_NAME/test-scout@v1
        with:
          pattern: 'test_*.py'
          strict_mode: 'true'
