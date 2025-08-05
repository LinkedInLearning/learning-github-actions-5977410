# 04_03 Dockerfile Review

This lesson provides a refresher on Dockerfiles and explains how they serve as the foundation for building custom container-based GitHub Actions.

## Summary

A Dockerfile outlines how to build a container image.

For our custom action, the Dockerfile ensures that all dependencies and logic are bundled in a consistent, repeatable way.

Key Docker instructions include:

- `FROM` – sets the base image
- `RUN` – executes commands and installs dependencies
- `COPY` – adds files into the image
- `ENTRYPOINT` – defines the default command to run

We’ll use these instructions to build the container for our `test-scout` action.

## Key Concepts

- Dockerfiles are **plain text configuration files** used to create container images.
- Consistency in builds comes from **declaring exact steps** in the Dockerfile.
- Dockerfiles used in GitHub Actions help define **runtime environments for custom logic**.

<!-- FooterStart -->
---
[← 04_02 Your Custom Action Objective](../04_02_your_custom_action_objective/README.md) | [04_04 Add a Dockerfile →](../04_04_add_a_dockerfile/README.md)
<!-- FooterEnd -->
