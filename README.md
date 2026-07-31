# dotfiles

Personal dotfiles for setting up a new machine and keeping configurations in sync.

These configurations are made to work with `zsh` as a shell using `oh-my-zsh` as the main configuration tool.

## Structure

```
.
├── configs
│   ├── zsh
│   │   ├── .zshenv          # Environment variables (loaded for ALL shells)
│   │   ├── .zprofile        # Environment variables (loaded for login shells only)
│   │   ├── .zshrc           # Interactive shell configuration
│   │   └── .p10k.zsh        # Powerlevel10k theme config
│   ├── .gitconfig
│   ├── .gitignore_global
│   ├── .rsync.excludes
│   ├── .tmux.conf
│   ├── .tmux_env
│   ├── .vimrc
│   └── ipython_config.py
├── scripts
│   ├── alias.zsh
│   ├── func.zsh
│   ├── history.zsh
│   ├── keybindings.zsh
│   └── python-setup.zsh
├── installer.sh          # Main setup script
├── mac_default.sh        # macOS default settings
├── Brewfile              # Homebrew packages
└── iterm-prof.json       # iTerm2 profile (import manually)
```

### Zsh Configuration

Zsh files are organized in the `configs/zsh/` directory:

| File | Purpose | Loaded When |
|------|---------|-------------|
| `.zshenv` | Environment variables needed everywhere | All shells (login, non-login, interactive, scripts) |
| `.zprofile` | Environment variables for login sessions | Login shells only |
| `.zshrc` | Interactive shell config (aliases, functions, plugins) | Interactive shells only |
| `.p10k.zsh` | Powerlevel10k theme configuration | Sourced by `.zshrc` |

**Private Environment Variables:**
- Create `~/.zshenv.local` in your home directory for machine-specific secrets (API keys, etc.)
- This file is **not** in the repo and won't be committed
- `.zshenv` automatically sources it if it exists

## Install

To run the installer:

```bash
cd $DOTFILES
./installer.sh
```

The installer will:
1. Set up oh-my-zsh and powerlevel10k
2. Install zsh plugins
3. Symlink all config files to your home directory
4. Optionally install system dependencies from Brewfile
5. Optionally apply macOS default settings

### Package Management

System dependencies are managed via `Brewfile`. Available functions:

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
