# AGENTS.md

Guidance for AI coding agents working in this repository.

## What this is

Personal dotfiles for macOS. Primary shell is `zsh` with `oh-my-zsh` + `powerlevel10k`; `nushell` is being trialed alongside it. This is an opinionated setup for coding in Python, JavaScript/TypeScript, and Go — keep that focus in mind when suggesting changes. There is no build system, no tests, and no package manager manifest other than the `Brewfile`.

## Layout

- `configs/` — third-party dotfiles (git, vim, tmux, …) symlinked verbatim into `$HOME` by basename. Nothing shell-related lives here. Exception: `starship.toml` is the prompt shared by both shells, pointed at by `STARSHIP_CONFIG` in `shared/env`; in zsh the prompt is switchable via `DOTFILES_PROMPT` in `.zshrc` (`starship` default, `p10k` fallback).
- `shared/` — shell-agnostic config loaded by both shells: `env` (KEY=value per line) and `paths` (PATH entries, one per line). `$HOME` in values is expanded by both loaders.
- `zsh/` — everything zsh: `install.sh`, `configs/` (`.zshenv`, `.zprofile`, `.zshrc`, `.p10k.zsh`, symlinked into `$HOME` by basename), and `scripts/` (modules sourced by `.zshrc`: aliases, functions, history, keybindings).
- `nushell/` — everything nushell: `install.sh`, `configs/` (`env.nu`, `config.nu`, `aliases.nu`; the whole dir is symlinked to nu's config dir, e.g. `~/Library/Application Support/nushell` on macOS).
- `installer.sh` — entry point. Auto-detects the current shell via `$SHELL` (fails if not zsh/nu), symlinks `configs/`, then sources the matching `<shell>/install.sh`. Idempotent.
- `mac_default.sh` — `defaults write` tweaks for macOS.
- `utils.zsh` — internal helpers (`__dotfile_*` logging/functions) for installer scripts only; refuses to load in interactive shells.
- `Brewfile` — Homebrew dependencies.
- `iterm-prof.json` — iTerm2 profile, imported manually.

## Conventions

- `$DOTFILES` points to the repo root (`$HOME/dotfiles`). It is defined in each shell's own startup file (`.zshenv`, `env.nu`) as the bootstrap anchor — it must NOT go in `shared/env`.
- **Data is shared, code is per-shell.** Env vars and PATH entries → `shared/env` / `shared/paths`. Anything with shell syntax (aliases, functions, keybindings, prompt) → `zsh/scripts/` or `nushell/configs/`. Do not try to share aliases between shells; nu's command semantics differ (see `nushell/configs/aliases.nu` header).
- Keep the zsh loading order straight: env for everything → `.zshenv`; login-only env → `.zprofile`; interactive → `.zshrc` or a file in `zsh/scripts/`.
- New interactive zsh customizations go in a themed file under `zsh/scripts/` rather than inline in `.zshrc`.
- New symlinked third-party configs go in `configs/`; the installer picks them up automatically.
- Shell scripts use `set -e`, the `__dotfile_*` helpers from `utils.zsh` for output, and must be idempotent (safe to re-run). Beware: nu reports its config dir **canonicalized** — always compare `realpath`s before re-creating symlinks.
- **Never commit secrets.** Machine-specific/private config belongs in untracked local files: `~/.zshenv.local` (zsh), `~/.env.nu.local` (nushell, env vars only), `~/.gitconfig.local` (git, e.g. `user.signingkey` — included via `[include]` in `.gitconfig`).

## Working in this repo

- Files in `configs/` and `zsh/configs/` are symlinked into `$HOME` — editing them changes the user's live environment immediately. Be deliberate; don't restyle or reorganize configs unprompted.
- **Do not run `installer.sh`, `<shell>/install.sh`, `mac_default.sh`, or any `brew` command yourself** — they modify the user's machine. Propose them for the user to run instead.
- Validate after edits: `zsh -n <file>` and `bash -n <file>` for shell scripts; for nushell, parse/run-check with `nu --env-config nushell/configs/env.nu --config nushell/configs/config.nu -c '<cmd>'`.
- Nushell gotchas learned the hard way: `str starts-with` (not `starts-with`); `source` inside a block keeps defs scoped to that block (top-level `source` only for things like zoxide); generated files (zoxide init, history) must never land inside the symlinked `nushell/configs/` dir — they go in `$HOME` and are gitignored.
- There is no test suite; verification is syntactic validation plus careful reading.
- After changing installed packages, suggest regenerating the Brewfile with `brewdump` (defined in `zsh/scripts/func.zsh`); drift is checked with `brewcheck`.
