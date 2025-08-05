# 04_02 Your Custom Action Objective

This lesson defines the goal of the custom GitHub Action that we’ll build in the upcoming lessons.

## Summary

We’re building an action called **`test-scout`**.

This action will:

- Scan a repository for Python test files
- Generate a short summary report
- Optionally fail the workflow if no tests are found (based on a flag)
- Support custom patterns for test file names

By defining the objective up front, we can guide the rest of the development process more efficiently.

## Key Concepts

- Define a **clear, reusable objective** before writing code.
- Allow **configuration via inputs** to make your action flexible.

<!-- FooterStart -->
---
[← 04_01 Plan a Custom Action](../04_01_plan_a_custom_action/README.md) | [04_03 Dockerfile Review →](../04_03_dockerfile_review/README.md)
<!-- FooterEnd -->
