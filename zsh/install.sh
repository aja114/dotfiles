# zsh/install.sh - sourced by installer.sh (bash). Expects utils.zsh helpers.

__dotfile_info "Setting up zsh"

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
__dotfile_add_zsh_plugin https://github.com/zsh-users/zsh-autosuggestions
__dotfile_add_zsh_plugin https://github.com/zsh-users/zsh-syntax-highlighting.git
__dotfile_success "zsh plugins configured"

__dotfile_info "Symlinking zsh config files to ~/"
find $DOTFILES/zsh/configs -maxdepth 1 -type f | while read -r f; do
    ln -sf "$f" "$HOME/$(basename "$f")"
done
__dotfile_success "zsh configured"
