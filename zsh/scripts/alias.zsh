# alias.zsh - grouped the same way as nushell/configs/aliases.nu.

# General
alias clear="printf '\33c\e[3J'"
alias cl=clear
alias v='nvim'
alias s='ssh'
alias reloadsh='exec "$SHELL" -l'

# ls
alias ls="ls -AlGt"
alias sl=ls

# Safety prompts
alias rm="rm -vi"
alias mv="mv -i"

# Python
alias jlab="jupyter-lab"
alias pt='pytest'
alias pytest_debug="pytest -o log_cli=true -o log_cli_level=DEBUG"
alias pcall='pre-commit run --all-files'

# Git
alias gt="git for-each-ref --sort=creatordate --format '%(refname) %(creatordate)' refs/tags | sed 's/refs\/tags\///' | tail"
alias gbda="git branch | grep -v 'main' | xargs git branch -D"

# Kubernetes
alias kswitch="kubectl config use-context"

# Misc
alias ccat="pygmentize -g -O style=gruvbox-dark"
alias vbm="VBoxManage"
alias rsync="rsync --exclude-from=$HOME/.rsync.excludes"
alias rsyncdry="rsync --exclude-from=$HOME/.rsync.excludes --dry-run"
alias cat1line='awk '\''{printf "%s\\\\n", $0} END {print ""}'\'' '
