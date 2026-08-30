# Uncomment to start profiling
# zmodload zsh/zprof

# Prompt selection: "starship"  or "p10k" 
export DOTFILES_PROMPT=starship

if [[ $DOTFILES_PROMPT == p10k ]]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  ZSH_THEME=""
fi

# zsh-nvm lazy-loads nvm on first use of node/npm/npx/nvm instead of at
# startup (NVM_LAZY_LOAD=true is set in .zshenv). Additionally, always have
# node on PATH (so Neovim etc. find it without a shell) by pointing at the
# newest installed version directly - no nvm.sh parsing, ~0ms cost.
export NVM_DIR="$HOME/.nvm"
_nvm_latest=("$NVM_DIR"/versions/node/*(N/On[1]))
(( $#_nvm_latest )) && path=("$_nvm_latest[1]/bin" $path)
unset _nvm_latest

# Which plugins would you like to load?
plugins=(
zsh-autosuggestions
zsh-nvm
terraform
git
vi-mode
fzf
zsh-syntax-highlighting
git-auto-fetch
kubectl
docker
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

# Prompt init, matching $DOTFILES_PROMPT above. Note: the p10k instant-prompt
# block was removed with the starship switch - restore it from git history if
# wanted (p10k works without it, just flashes on startup).
if [[ $DOTFILES_PROMPT == p10k ]]; then
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
  eval "$(starship init zsh)"
fi

# Add zoxide command to easily switch directories
eval "$(zoxide init zsh)"

# goenv: put shims on PATH directly (~0ms) so go/gofmt/gopls/dlv resolve in any
# process (Neovim, editors) without shell init. The full `goenv init` (~60ms:
# PATH surgery + rehash + shell wrapper) only runs on first `goenv` command.
# GOENV_ROOT is set in shared/env; nushell gets the shims via shared/paths.
path=("$GOENV_ROOT/shims" $path)
goenv() {
  unfunction goenv
  eval "$(command goenv init -)"
  goenv "$@"
}

# activate fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source all the scripts from our dotfiles
for script in "${DOTFILES}"/zsh/scripts/*(.); do
    if [ -f "$script" ]; then
        source "$script"
    fi
done

# increase the limit on the number of files open on mac os
ulimit -n 10240


# Uncomment to see profiling results
# zprof

