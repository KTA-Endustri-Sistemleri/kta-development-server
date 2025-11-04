# Contributing

Thanks for considering contributing!

## Getting Started
- Fork this repo and create a feature branch from `main`.
- Use VSCode **Dev Containers** to ensure a consistent environment.
- Start services with the provided compose via Dev Container.

## Development Workflow
1. Run Dev Container.
2. Install bench/site if needed:
   ```bash
   python installer.py -v -s kta-dev.localhost -b kta-dev -d mariadb -a admin
3.	Commit using conventional commits (e.g., feat:, fix:, docs:).
4.	Ensure pre-commit hooks (optional) and tests pass.

## Pull Requests
1. Keep PRs small and focused.
2. Link any related issues.
3. Update docs if behavior ch
