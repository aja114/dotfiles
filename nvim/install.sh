# nvim/install.sh - sourced by installer.sh (bash). Expects utils.zsh helpers.

__dotfile_info "Setting up neovim"

target="$DOTFILES/nvim/configs"
link="$HOME/.config/nvim"

mkdir -p "$HOME/.config"

# Compare realpaths: $link may already be our symlink (idempotent re-runs).
if [ "$(realpath "$link" 2>/dev/null)" = "$(realpath "$target")" ]; then
    __dotfile_skip "config symlink (already linked)"
else
    if [ -L "$link" ]; then
        rm "$link"
    elif [ -e "$link" ]; then
        backup="${link}.bak.$(date +%Y%m%d%H%M%S)"
        __dotfile_warning "Existing nvim config backed up to $backup"
        mv "$link" "$backup"
    fi
    ln -s "$target" "$link"
    __dotfile_success "Config linked: $link -> $target"
fi
