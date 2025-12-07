alias clear="printf '\33c\e[3J'"
alias cl=clear
alias ls="ls -AlG"
alias sl=ls
alias rm="rm -vi"
alias mv="mv -i"
alias ccat="pygmentize -g -O style=gruvbox-dark"
alias pytest_debug="pytest -o log_cli=true -o log_cli_level=DEBUG"
alias vbm="VBoxManage"
alias rsync="rsync --exclude-from=$HOME/.rsync.excludes"
alias rsyncdry="rsync --exclude-from=$HOME/.rsync.excludes --dry-run"
alias jlab="jupyter-lab"
alias v='nvim'
alias s='ssh'
alias pt='pytest'
alias pcall='pre-commit run --all-files'
alias reloadsh='exec "$SHELL" -l'
alias gt="git for-each-ref --sort=creatordate --format '%(refname) %(creatordate)' refs/tags | sed 's/refs\/tags\///' | tail"
alias kswitch="kubectl config use-context"
alias cat1line='awk '\''{printf "%s\\\\n", $0} END {print ""}'\'' '
alias gbda="git branch | grep -v 'main' | xargs git branch -D"
