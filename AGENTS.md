# AGENTS.md

Guidance for AI coding agents working in this repository.

## What this is

Personal dotfiles for macOS. Shell is `zsh` with `oh-my-zsh` + `powerlevel10k`. This is an opinionated setup for coding in Python, JavaScript/TypeScript, and Go — keep that focus in mind when suggesting changes. There is no build system, no tests, and no package manager manifest other than the `Brewfile`.

## Layout

- `configs/` — dotfiles symlinked verbatim into `$HOME` by basename (`installer.sh` runs `ln -sf` on every file found here). Filenames intentionally start with `.`.
- `configs/zsh/` — zsh startup files: `.zshenv` (all shells), `.zprofile` (login), `.zshrc` (interactive), `.p10k.zsh` (theme).
- `scripts/` — zsh modules sourced by `.zshrc` (aliases, functions, history, keybindings, python setup).
- `installer.sh` — idempotent setup script. Installs oh-my-zsh/p10k/plugins, symlinks configs, optionally runs `brew bundle` and `mac_default.sh`.
- `mac_default.sh` — `defaults write` tweaks for macOS.
- `utils.zsh` — internal helpers (`__dotfile_*` logging/functions) for installer scripts only; refuses to load in interactive shells.
- `Brewfile` — Homebrew dependencies.
- `iterm-prof.json` — iTerm2 profile, imported manually.

## Conventions

- `$DOTFILES` points to the repo root (`$HOME/dotfiles`), set in `.zshenv`.
- Keep the loading order straight: env vars for everything → `.zshenv`; login-only env → `.zprofile`; anything interactive (aliases, plugins, prompt) → `.zshrc` or a file in `scripts/`.
- New interactive shell customizations go in a themed file under `scripts/` rather than inline in `.zshrc`.
- New symlinked configs go in `configs/` (or `configs/zsh/`); the installer picks them up automatically.
- Shell scripts use `set -e`, the `__dotfile_*` helpers from `utils.zsh` for output, and must be idempotent (safe to re-run).
- **Never commit secrets.** Machine-specific/private env vars belong in `~/.zshenv.local`, which `.zshenv` sources if present and which is not in this repo.

## Working in this repo

- Files in `configs/` are symlinked into `$HOME` — editing them changes the user's live environment immediately. Be deliberate; don't restyle or reorganize configs unprompted.
- **Do not run `installer.sh`, `mac_default.sh`, or any `brew` command yourself** — they modify the user's machine. Propose them for the user to run instead.
- Validate shell syntax after edits with `zsh -n <file>`, and `shellcheck` if available.
- There is no test suite; verification is syntactic validation plus careful reading.
- After changing installed packages, suggest regenerating the Brewfile with `brewdump` (defined in `scripts/func.zsh`); drift is checked with `brewcheck`.
