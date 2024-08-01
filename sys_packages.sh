#!/bin/bash
set -ex 

NONINTERACTIVE=1 

# Update brew 
#brew update && brew doctor

echo "Currently installed packages"
brew list --version --verbose

echo "Currently installed graphical packages"
brew list --cask --version --verbose

cli=(bat zoxide tldr fzf jq rsync exa gh duf nvm tree)
cliopt=(scc diff-so-fancy hyperfine ctop dog)
python=(pyenv pipx)
others=(goenv node)
casks=(notion maccy)

allowedcoms=(install uninstall reinstall upgrade)
brewcom=$1   

if [[ ! -z brewcom ]] && [[ $allowedcoms[brewcom] ]]; then
  echo "Running brew command $brewcom"
else
  echo "Append a brew command [${allowedcoms[@]}] to the script."
  exit 1
fi

while [[ ! -z $1 ]]; do
  if [[ $1 == --cli ]]; then
    brew $brewcom ${cli[@]}
  fi

  if [[ $1 == --cli-opt ]]; then
    brew $brewcom ${cliopt[@]}
  fi

  if [[ $1 == --python ]]; then
    brew $brewcom ${python[@]}
  fi

  if [[ $1 == --others ]]; then
    brew $brewcom ${others[@]}
  fi
  if [[ $1 == --casks ]]; then
    brew $brewcom --cask ${casks[@]}
  fi 
  shift 
done
  
  
