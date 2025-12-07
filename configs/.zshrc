# Add homebrew to the path
export PATH="/opt/homebrew/bin:$PATH"

# Source all the scripts from our dotfiles
for script in "${DOTFILES}"/scripts/*(.); do
    if [ -f "$script" ]; then
        source "$script"
    fi
done

zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
plugins=(
zsh-autosuggestions
terraform
git
vi-mode
fzf
zsh-syntax-highlighting
autoswitch_virtualenv
git-auto-fetch
kubectl
docker
kubectl
helm
gh
invoke
uv
)

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=100"
export ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Add vim as the editing program in all cmd line interactions
set -o vi

# Completion config from http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add zoxide command to easily switch directories
eval "$(zoxide init zsh)"

# activate fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# This loads nvm but we don't want to do this at start time
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use

# increase the limit on the number of files open on mac os
ulimit -n 10240

. "$HOME/.cargo/env"

# Created by `pipx` on 2024-09-19 09:33:55
export PATH="$PATH:/Users/alexandre.abouchahine/.local/bin"

# pnpm
export PNPM_HOME="/Users/alexandre.abouchahine/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/alexandre.abouchahine/.bun/_bun" ] && source "/Users/alexandre.abouchahine/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# releease the kraken
source /Users/alexandre.abouchahine/codebases/release-the-kraken/.env.release-the-kraken
alias tailscale=/Applications/Tailscale.app/Contents/MacOS/Tailscale

# add secretive agent
export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
