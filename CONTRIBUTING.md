# Contributing

Contributions are welcome — new projects, bug fixes, or improvements to existing guides.

## Before you start

For a **new project idea**, open an [Issue](https://github.com/techiescamp/devops-projects/issues) first so we can align on scope before you start building. This avoids wasted work on a project that doesn't fit the repo's direction.

For **bug fixes or doc improvements**, feel free to open a PR directly.

## Project structure

Each project lives in its own numbered folder (e.g. `01-jenkins-setup/`) and must include:

- A `README.md` with a step-by-step guide, prerequisites, and a "What you will learn" section
- Working code (Terraform, Ansible, scripts, etc.) that has been tested end-to-end
- A cleanup/destroy script so resources don't run unnecessarily after practice

## Submitting a pull request

1. Fork the repository
2. Create a branch for your change: `git checkout -b add-my-project`
3. Commit your changes with a clear message describing what and why
4. Push to your fork and open a PR against `main`
5. Link the related Issue in your PR description if one exists

## Code style

- Keep Terraform/Ansible code modular and commented where logic isn't obvious
- Use descriptive variable names — avoid abbreviations that aren't self-evident
- Test your project from a clean environment before submitting

## License

By contributing, you agree that your code contributions are licensed under the [MIT License](LICENSE) and your documentation contributions are licensed under [CC BY-NC 4.0](LICENSE-CONTENT).
