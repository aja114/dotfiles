# nushell/install.sh - sourced by installer.sh (bash). Expects utils.zsh helpers.

__dotfile_info "Setting up nushell"

if ! command -v nu >/dev/null 2>&1; then
    __dotfile_error "nushell is not installed (run the Brewfile step first)"
    return 1
fi

# Resolve nushell's config dir instead of hardcoding it (OS-dependent).
# NOTE: nu canonicalizes this path, so once our symlink is in place it
# reports the *resolved* path (i.e. the target inside the dotfiles repo).
nu_config_dir=$(nu -c '$nu.default-config-dir' | tail -1)
target="$DOTFILES/nushell/configs"

if [ "$(realpath "$nu_config_dir" 2>/dev/null)" = "$(realpath "$target")" ]; then
    __dotfile_skip "config dir symlink (already linked)"
else
    if [ -L "$nu_config_dir" ]; then
        rm "$nu_config_dir"
    elif [ -d "$nu_config_dir" ]; then
        if [ -z "$(ls -A "$nu_config_dir")" ]; then
            rmdir "$nu_config_dir"
        else
            backup="${nu_config_dir}.bak.$(date +%Y%m%d%H%M%S)"
            __dotfile_warning "Existing nushell config dir backed up to $backup"
            mv "$nu_config_dir" "$backup"
        fi
    fi
    ln -s "$target" "$nu_config_dir"
    __dotfile_success "Config linked: $nu_config_dir -> $target"
fi

# zoxide/starship: generate init scripts sourced by config.nu. Kept in ~
# (not the config dir) so generated files never land inside the dotfiles repo.
__dotfile_info "Generating zoxide init script"
zoxide init nushell > "$HOME/.zoxide.nu"
if command -v starship >/dev/null 2>&1; then
    __dotfile_info "Generating starship init script"
    starship init nu > "$HOME/.starship.nu"
else
    __dotfile_warning "starship not installed, skipping (run the Brewfile step, then re-run this installer)"
fi
__dotfile_success "nushell configured"
