# Repository Guidelines

## Project Structure & Module Organization
`SKILL.md` is the runtime entrypoint and the main source of truth for companion behavior. `README.md` and `README.zh.md` document installation, usage, and the persistence contract. Reference data lives in `references/` (`sprites.md` for ASCII art, `personalities.md` for naming and tone). Design notes and change planning live under `docs/superpowers/specs/` and `docs/superpowers/plans/`. Automated checks currently live in `tests/`, with `tests/skill-growth-contract.sh` validating required growth-related documentation.

## Build, Test, and Development Commands
There is no build step for this repository; changes are mostly Markdown and shell-based validation.

- `sh tests/skill-growth-contract.sh`: verifies that `SKILL.md` and `README.md` still include required growth-system terms.
- `git diff --check`: catches whitespace errors before opening a PR.
- `rg "pattern" .`: preferred way to find command names, persisted keys, or wording across docs.

## Coding Style & Naming Conventions
Keep edits Markdown-first, concise, and implementation-facing. Use ATX headings (`## Heading`), short paragraphs, and fenced blocks for examples. Preserve persisted field names exactly as lower_snake_case, for example `hatchedAt`, `streak_days`, and `last_active_on`, to avoid breaking documented contracts. Shell scripts should stay POSIX `sh` unless the repo explicitly adopts Bash-only features.

## Testing Guidelines
Run `sh tests/skill-growth-contract.sh` after any change to `SKILL.md`, `README.md`, or persistence/growth language. When behavior changes, update the contract test in the same change so documentation and validation stay aligned. Name new test scripts descriptively, following the current pattern of hyphenated shell filenames in `tests/`.

## Commit & Pull Request Guidelines
Recent history favors short, imperative subjects, often with a conventional prefix such as `docs:` or `feat:`. Follow that style when possible, for example `docs: clarify persistence fallback` or `feat: expand buddy mood rules`. PRs should include a brief summary, the reason for the change, and the exact checks run. If output visible to users changes, include a small terminal example or README snippet showing the new behavior.

## Agent-Specific Notes
This repository is meant to be installed as a filesystem-backed skill. Keep `SKILL.md`, `README.md`, and `references/` consistent, and do not rename core files or documented persistence keys without updating every affected document and test.
