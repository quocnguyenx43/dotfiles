# CHANGELOG

All notable changes to this project will be documented in this file.

## Will do
- Fix apt and brew packages
- Fix OS script
- Docker-in-Docker: create a Linux container => mount this /var/run/docker.sock into the container => it works
- Fix work_scripts: ./common/work
- Add secrets template

## [0.1.0] - 2025-12-01

### Added
- Restructured repository layout.
- Documented usage of `config/paths.json` and repository layout in `README.md`.
- Added `config/secrets_example.json` as a template for local secrets configuration.
- Added `scripts/check_env.sh` for environment health checks on macOS and Ubuntu.
- Set up `pre-commit` with `shfmt`, `shellcheck`, and `stylua` for shell and Neovim Lua files.
