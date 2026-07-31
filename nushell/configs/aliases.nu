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

# Git (ported from oh-my-zsh's git plugin; `git co/ci/st/br/graph` also
# exist as subcommand aliases via configs/.gitconfig)
alias g = git
alias gst = git status
alias ga = git add
alias gaa = git add --all
alias gb = git branch
alias gba = git branch -a
alias gc = git commit -v
alias gcam = git commit -a -m
alias gcmsg = git commit -m
alias gco = git checkout
alias gcb = git checkout -b
alias gsw = git switch
alias gswc = git switch --create
alias gd = git diff
alias gds = git diff --staged
alias gf = git fetch
alias gfa = git fetch --all --prune
alias gl = git pull
alias gp = git push
alias gm = git merge
alias grb = git rebase
alias grs = git restore
alias grst = git restore --staged
alias gsta = git stash push
alias gstp = git stash pop
alias gcp = git cherry-pick
alias glog = git log --oneline --decorate --graph

# These need the branch name at runtime, so they're defs, not aliases.
def git-current-branch [] { git branch --show-current | str trim }
def git-main-branch [] {
    let r = (do { ^git symbolic-ref --quiet --short refs/remotes/origin/HEAD } | complete)
    if $r.exit_code == 0 { $r.stdout | str trim | path basename } else { "main" }
}
def gcm [] { git checkout (git-main-branch) }
def gpsup [] { git push --set-upstream origin (git-current-branch) }

# Kubernetes
alias kswitch = kubectl config use-context

# Misc
alias ccat = pygmentize -g -O style=gruvbox-dark
alias vbm = VBoxManage
alias rsyncx = ^rsync --exclude-from=$"($env.HOME)/.rsync.excludes"
alias rsyncdry = ^rsync --exclude-from=$"($env.HOME)/.rsync.excludes" --dry-run

# Not ported (zsh-specific or pipeline-heavy, re-add here if you miss them):
#   gt, gbda, cat1line, reloadsh
