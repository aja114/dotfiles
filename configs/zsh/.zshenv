export DOTFILES=$HOME/dotfiles
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export no_proxy=*
export HOMEBREW_NO_AUTO_UPDATE=1

# virtual env autoswitch plugin
export AUTOSWITCH_SILENT=1

# nvm don't load on start time
export NVM_LAZY_LOAD=true

# Increase the git auto fetch minimum
export GIT_AUTO_FETCH_INTERVAL=600

# brew shellenv - MUST be in .zshenv (not .zshrc) so it's available
# to all shells, including non-interactive scripts and cron jobs
eval "$(/opt/homebrew/bin/brew shellenv)"

# Source local environment variables if they exist
[ -f "$HOME/.zshenv.local" ] && source "$HOME/.zshenv.local"


