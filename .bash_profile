# Homebrew
export PATH=/usr/local/bin:$PATH

# Virtualenv/VirtualenvWrapper
source /usr/local/bin/virtualenvwrapper.sh

# added by Anaconda3 5.2.0 installer
# export PATH="/anaconda3/bin:$PATH"  # commented out by conda initialize

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH
export PATH

# Bash Alias 
alias python=python3
alias pip=pip3
alias ls='ls -alhG'
alias rm='rm -vi'
alias chrome='open -a "Google Chrome"'
alias julia='/Applications/JuliaPro-1.4.0-1.app/Contents/Resources/julia/Contents/Resources/julia/bin/julia'
alias subl="'/Applications/Sublime Text.app/Contents/MacOS/Sublime Text' &"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cl=clear
alias v=vim
alias mv="mv -i"

# Add Environment variable for the Sisyphus Project
export SECRET_KEY='ec9c5159e3964b036448edc99549a8'
export SQLALCHEMY_DATABASE_URI='sqlite:///site.db'

# Add Environment variable for postgres 
export PSQLPath='/usr/local/Cellar/postgresql/13.1/bin'

# Add Environment variable for apache drill
alias drill-embedded="sudo /usr/local/apache-drill-1.17.0/bin/drill-embedded"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/utilisateur/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/utilisateur/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/utilisateur/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/utilisateur/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Add vim as the editing program in all cmd line interactions
set -o vi

export BASH_SILENCE_DEPRECATION_WARNING=1

source /Users/utilisateur/.config/broot/launcher/bash/br

export PS1='\[$(tput setaf 10)\]\u:\[$(tput setaf 11)\]\W\[$(tput sgr0)\] \n$ '

neofetch

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

#mkcd
function mkcd
{
  command mkdir $1 && cd $1
}

alias volatility='vol.py'
alias smt_z3=~/.smt_solvers/z3/z3-4.8.7-x64-osx-10.14.6/bin/z3
alias jup='jupyter notebook'
export picosat='/Users/utilisateur/Desktop/IP/ERLM/PracticalWorks/SAT/td3/picosat-965/picosat'

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi
