# dotfiles

Personal dotfiles for setting up a new machine and keeping configurations in sync.

Supports two shells: `zsh` (primary, with `oh-my-zsh`) and `nushell` (trial). The prompt is [starship](https://starship.rs), shared by both shells via `configs/starship.toml` (zsh can fall back to powerlevel10k via `DOTFILES_PROMPT`). Shared configuration lives in shell-agnostic files consumed by both.

## Structure

```
.
├── configs                 # Third-party dotfiles → symlinked to ~ by basename
│   ├── .gitconfig          # Includes ~/.gitconfig.local for machine-specific bits
│   ├── .gitignore_global
│   ├── .rsync.excludes
│   ├── .tmux.conf
│   ├── .tmux_env
│   ├── .vimrc
│   ├── ipython_config.py
│   └── starship.toml       # Prompt shared by zsh + nushell ($STARSHIP_CONFIG in shared/env)
├── shared                  # Shell-agnostic config, loaded by both shells
│   ├── env                 # Environment variables (KEY=value, one per line)
│   └── paths               # PATH entries (one per line, appended)
├── zsh
│   ├── install.sh          # oh-my-zsh, powerlevel10k, plugins, symlinks
│   ├── configs             # zsh startup files → symlinked to ~ by basename
│   │   ├── .zshenv         # Loads shared/env + shared/paths, zsh-only env
│   │   ├── .zprofile       # Login-shell env (oh-my-zsh path)
│   │   ├── .zshrc          # Interactive shell configuration
│   │   └── .p10k.zsh       # Powerlevel10k theme config
│   └── scripts             # Modules sourced by .zshrc (aliases, functions, ...)
├── nushell
│   ├── install.sh          # Symlinks configs into nu's config dir, zoxide setup
│   └── configs             # → symlinked as a whole to nu's config dir
│       ├── env.nu          # Loads shared/env + shared/paths (≈ .zshenv)
│       ├── config.nu       # Interactive config: vi mode, aliases, zoxide (≈ .zshrc)
│       └── aliases.nu      # Port of zsh/scripts/alias.zsh
├── installer.sh            # Entry point — auto-detects your shell via $SHELL
├── mac_default.sh          # macOS default settings
├── Brewfile                # Homebrew packages
└── iterm-prof.json         # iTerm2 profile (import manually)
```

## Shared environment

`shared/env` and `shared/paths` are plain-text files (one entry per line, `$HOME` allowed in values) that **both** shells load at startup:

- **zsh**: `.zshenv` sources them (`set -a` auto-export + a `path+=` loop)
- **nushell**: `env.nu` parses them (`parse "{k}={v}" | load-env`, `append` to `$env.PATH`)

The rule of thumb: **data is shared, code is per-shell**. Env vars and PATH entries go in `shared/`; anything with shell syntax (aliases, functions, keybindings, prompt) goes in `zsh/scripts/` or `nushell/configs/`.

Note: `DOTFILES` is defined in each shell's startup file (not in `shared/env`) since it's the anchor needed to locate the shared files.

### Zsh startup files

| File | Purpose | Loaded When |
|------|---------|-------------|
| `.zshenv` | Shared env/PATH loaders, zsh-only env vars | All shells (login, non-login, interactive, scripts) |
| `.zprofile` | Environment variables for login sessions | Login shells only |
| `.zshrc` | Interactive shell config (plugins, prompt, sources `zsh/scripts/`) | Interactive shells only |
| `.p10k.zsh` | Powerlevel10k theme configuration | Sourced by `.zshrc` |

### Machine-specific / private files

These live in `$HOME`, are **not** in the repo, and are picked up automatically:

- `~/.zshenv.local` — private env vars for zsh (sourced by `.zshenv`)
- `~/.env.nu.local` — private env vars for nushell (sourced by `env.nu`)
- `~/.gitconfig.local` — machine-specific git config, e.g. `user.signingkey` (included via `[include]` in `.gitconfig`)

## Install

```bash
cd $DOTFILES
./installer.sh
```

The installer detects which shell you're running (via `$SHELL`) and sets up that shell. It will:

1. Optionally install system dependencies from the Brewfile
2. Symlink third-party configs (`configs/`) to your home directory
3. Run the detected shell's `install.sh` (oh-my-zsh/p10k/plugins for zsh; config symlink + zoxide for nushell)
4. Optionally apply macOS default settings

It is idempotent — safe to re-run from either shell.

### Package Management

System dependencies are managed via `Brewfile`. Available functions (in `zsh/scripts/func.zsh`):

```bash
# Dump current packages to Brewfile
brewdump

# Install packages from Brewfile
brew bundle --file=$DOTFILES/Brewfile

# Check if Brewfile is in sync with installed packages
brewcheck
```

### macOS Settings

To apply macOS defaults:

```bash
./mac_default.sh
```
