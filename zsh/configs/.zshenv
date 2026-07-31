# Bootstrap anchor - must match nushell's env.nu
export DOTFILES=$HOME/dotfiles

# Shared environment variables (shared with nushell): KEY=value lines
set -a
source "$DOTFILES/shared/env"
set +a

# Shared PATH entries (appended, deduplicated)
while IFS= read -r p; do
    [[ -z ${p//[[:space:]]/} || $p == \#* ]] && continue
    path+=("${(e)p}")
done < "$DOTFILES/shared/paths"
typeset -U path PATH

# zsh-only plugin settings
export NVM_LAZY_LOAD=true
export GIT_AUTO_FETCH_INTERVAL=600

# brew shellenv - MUST be in .zshenv (not .zshrc) so it's available
# to all shells, including non-interactive scripts and cron jobs
eval "$(/opt/homebrew/bin/brew shellenv)"

# Source local environment variables if they exist
[ -f "$HOME/.zshenv.local" ] && source "$HOME/.zshenv.local"
