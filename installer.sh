#!/bin/bash
set -e

DOTFILES=$(dirname "$(realpath "$0")")
source $DOTFILES/utils.zsh

__dotfile_set_script_name "Dotfiles Installer"

__dotfile_section_header "System Dependencies" 1 4
read -p "  Install system-level packages from Brewfile? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    __dotfile_info "Installing packages from Brewfile"
    brew bundle --file=$DOTFILES/Brewfile
    __dotfile_success "System dependencies installed"
else
    __dotfile_skip "system dependencies"
fi

__dotfile_section_header "Zsh Configuration" 2 4
ZSH_HOME=${ZSH_CUSTOM:-$HOME/.oh-my-zsh}
ZSH_CUSTOM=${ZSH_HOME}/custom

if [ -d ${ZSH_HOME} ]; then
    __dotfile_info "Updating oh-my-zsh"
    cd ${ZSH_HOME} && git pull
    __dotfile_success "oh-my-zsh updated"
else
    __dotfile_info "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    __dotfile_success "oh-my-zsh installed"
fi

if [ -d ${ZSH_HOME}/custom/themes/powerlevel10k ]; then
    __dotfile_info "Updating powerlevel10k"
    cd ${ZSH_HOME}/custom/themes/powerlevel10k && git pull
    __dotfile_success "powerlevel10k updated"
else
    __dotfile_info "Installing powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_HOME}/custom/themes/powerlevel10k
    __dotfile_success "powerlevel10k installed"
fi

__dotfile_info "Setting up zsh plugins"
__dotfile_add_zsh_plugin https://github.com/marlonrichert/zsh-autocomplete.git
# Note: repo name (zsh-autoswitch-virtualenv) differs from the plugin name
# (autoswitch_virtualenv), so the target directory must be set explicitly
__dotfile_add_zsh_plugin https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git autoswitch_virtualenv
__dotfile_add_zsh_plugin https://github.com/zsh-users/zsh-autosuggestions
__dotfile_add_zsh_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git
__dotfile_success "zsh plugins configured"

__dotfile_section_header "Configuration Files" 3 4
__dotfile_info "Symlinking config files to ~/"
find $DOTFILES/configs -type f | xargs -I conf sh -c 'ln -sf conf $HOME/$(basename conf)'
touch $HOME/.hushlogin
__dotfile_success "Config files linked"

__dotfile_section_header "macOS Settings" 4 4
read -p "  Apply macOS default settings? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    __dotfile_info "Applying macOS defaults"
    sh $DOTFILES/mac_default.sh
    __dotfile_success "macOS defaults applied"
else
    __dotfile_skip "macOS defaults"
fi

echo
echo -e "${__dotfile_blue}========================================${__dotfile_nc}"
echo -e "${__dotfile_green}  Installation complete!${__dotfile_nc}"
echo -e "${__dotfile_blue}========================================${__dotfile_nc}"
