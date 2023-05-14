# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Cange the command execution time stamp shown in the history command output.
HIST_STAMPS="yyyy-mm-dd"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 15

# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    vi-mode
)

source $ZSH/oh-my-zsh.sh

# Add personal commands

source $HOME/dotfiles/alias.sh
fpath=( $HOME/dotfiles/.zshfunc "${fpath[@]}")
autoload -Uz cleansc

# Completion configuration from http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# Enable vi mode
export EDITOR='vim'
bindkey -v

# History personalisation
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST 
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Pyenv vars
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh
