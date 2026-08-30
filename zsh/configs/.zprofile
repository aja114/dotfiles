# Environment variables - loaded once at login (zsh-specific only).
# Shared env vars and PATH entries live in $DOTFILES/shared/, loaded by .zshenv.

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
