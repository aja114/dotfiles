zmodload zsh/zprof

# Load nvm before p10k so it can detect the version
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set p10k as the oh-my-zsh theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
plugins=(
zsh-autosuggestions
terraform
git
vi-mode
fzf
zsh-syntax-highlighting
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

# Disable marking untracked files under VCS as dirty. 
# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

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

# Init goenv
eval "$(goenv init -)"

# activate fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source all the scripts from our dotfiles
for script in "${DOTFILES}"/scripts/*(.); do
    if [ -f "$script" ]; then
        source "$script"
    fi
done

# increase the limit on the number of files open on mac os
ulimit -n 10240

# Source cargo env
. "$HOME/.cargo/env"
