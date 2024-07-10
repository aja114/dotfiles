#!/bin/bash
set -ex

DOTFILES=$(dirname "$(realpath "$0")")
source $DOTFILES/utils.zsh

echo Running installer script from $DOTFILES_DIR

ZSH_HOME=${ZSH_CUSTOM:-$HOME/.oh-my-zsh}
ZSH_CUSTOM=${ZSH_HOME}/custom

## Install oh-my-zsh if it does not exist
if [ ! -d ${ZSH_HOME} ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install p10k if it does not exist
if [ ! -d ${ZSH_HOME}/custom/themes/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_HOME}/custom/themes/powerlevel10k
fi

## install zsh plugins
add-zsh-plugin https://github.com/marlonrichert/zsh-autocomplete.git
add-zsh-plugin https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git
add-zsh-plugin https://github.com/zsh-users/zsh-autosuggestions
add-zsh-plugin https://github.com/zsh-users/zsh-syntax-highlighting.git

# Symlink all the configs files to $HOME
find $DOTFILES/configs -type f | xargs -I conf sh -c 'ln -sf conf $HOME/$(basename conf)'

# Remove login message from iterm
touch $HOME/.hushlogin
