#!/bin/bash
set -ex

ZSH_HOME=${ZSH_CUSTOM:-$HOME/.oh-my-zsh}

# Install oh-my-zsh if it does not exist
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install p10k if it does not exist
if [ ! -d ${ZSH_HOME}/custom/themes/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_HOME}/custom/themes/powerlevel10k
fi

# install zsh plugins
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_HOME}/plugins/zsh-autocomplete


# Add all the configs files to $home
cp configs/* $HOME/

# Add the script files to $home
cp -r scripts $HOME/scripts
