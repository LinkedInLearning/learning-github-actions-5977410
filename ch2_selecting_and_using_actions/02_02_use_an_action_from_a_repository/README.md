# 02_02 Use an Action From a Repository

GitHub Actions aren’t limited to the Marketplace. You can load actions directly from other repositories—or even reference container images from a registry.

This lesson explores the different ways to use actions that live outside the Marketplace, giving you more flexibility to customize your workflows.


## Overview

This lesson covers the following high-level concepts:

* Referencing actions located within the same repository
* Using actions from any public repository on GitHub
* Referencing Docker container images as actions
* Understanding the syntax and reference format required for each approach


## Notes

### Actions from the Same Repository

* You can reference an action stored inside the same repository as your workflow.
* Use a **relative file path** that begins with `./`.
* Example:

  ```yaml
  - uses: ./scripts/code_checker
  ```


### Actions from a Public Repository

* You can load actions from any public repository on GitHub.
* Use the format:

  ```yaml
  - uses: user-or-org/repo@ref
  ```

* `user-or-org` is the GitHub username or organization.
* `repo` is the name of the public repository.
* `ref` can be:

  * a branch name (`main`, `stable`)
  * a tag (`v1.2.3`)
  * a SHA commit hash

#### If the action is not in the root directory

* Add the relative path to the action inside the repository:

  ```yaml
  - uses: user/repo/path/to/action@ref
  ```

#### Example

```yaml
- name: Octocat’s Cool Action
  uses: octocat/my-cool-action@main
```


### Actions from Docker Image Registries

* You can use **precompiled container images** as actions.
* Use the `docker://` prefix to reference the image:

  ```yaml
  - uses: docker://image:tag
  ```

* GitHub defaults to **Docker Hub** if no hostname is specified.

#### Example (from Docker Hub)

```yaml
- uses: docker://python:3.14
```

#### Example (from another public image registry)

```yaml
- uses: docker://host.example.com/image:tag
```

<!-- FooterStart -->
---
[← 02_01 Use an Action From the Marketplace](../02_01_use_an_action_from_the_marketplace/README.md) | [02_03 Pass Arguments to an Action →](../02_03_pass_arguments_to_an_action/README.md)
<!-- FooterEnd -->
