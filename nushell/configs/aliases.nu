# aliases.nu - ported from zsh/scripts/alias.zsh, adapted to nushell.
# Note: nu aliases are parse-time substitutions; the command on the right
# resolves to the real command, never recursively to the alias itself.

# General
alias cl = clear
alias v = nvim
alias s = ssh

# ls (nu's builtin ls is structured; -a shows hidden, -l shows all columns)
alias sl = ls
alias ll = ls -la
alias la = ls -a

# Safety prompts
alias rm = rm -i
alias mv = mv -i

# Python
alias jlab = jupyter-lab
alias pt = pytest
alias pytest_debug = pytest -o log_cli=true -o log_cli_level=DEBUG
alias pcall = pre-commit run --all-files

# Kubernetes
alias kswitch = kubectl config use-context

# Misc
alias ccat = pygmentize -g -O style=gruvbox-dark
alias vbm = VBoxManage
alias rsyncx = ^rsync --exclude-from=$"($env.HOME)/.rsync.excludes"
alias rsyncdry = ^rsync --exclude-from=$"($env.HOME)/.rsync.excludes" --dry-run

# Not ported (zsh-specific or pipeline-heavy, re-add here if you miss them):
#   gt, gbda, cat1line, reloadsh
