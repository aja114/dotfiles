# Environment variables - loaded once at login

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Init goenv
export GOENV_PATH_ORDER=back
export PATH="/opt/homebrew/opt/goenv/bin:$PATH"

# Created by `pipx` on 2021-10-15 15:45:40
export PATH="$PATH:$HOME/.local/bin"

# This loads nvm but we don't want to do this at start time
export NVM_DIR="$HOME/.nvm"

# add secretive agent
export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
