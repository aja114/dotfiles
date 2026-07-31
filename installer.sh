#!/bin/bash
set -e

DOTFILES=$(dirname "$(realpath "$0")")
source $DOTFILES/utils.zsh

__dotfile_set_script_name "Dotfiles Installer"

# Make sure brew is on PATH regardless of the invoking shell (e.g. a fresh
# nushell profile where no shell has run `brew shellenv` yet)
if ! command -v brew >/dev/null 2>&1; then
    for prefix in /opt/homebrew /usr/local; do
        if [ -x "$prefix/bin/brew" ]; then
            eval "$("$prefix/bin/brew" shellenv)"
            break
        fi
    done
fi

# --- Target selection: auto-detect via $SHELL ---
detect_shell() {
    case $(basename "${SHELL:-}") in
        zsh|nu) basename "${SHELL}"; return ;;
    esac
}

target=$(detect_shell)
if [[ -z $target ]]; then
    __dotfile_error "Could not detect shell from \$SHELL (got '${SHELL:-unset}')"
    exit 1
fi
__dotfile_info "Detected shell: $target"

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

__dotfile_section_header "Shared Configuration Files" 2 4
__dotfile_info "Symlinking third-party config files to ~/"
find $DOTFILES/configs -maxdepth 1 -type f | while read -r f; do
    ln -sf "$f" "$HOME/$(basename "$f")"
done
touch $HOME/.hushlogin
__dotfile_success "Shared config files linked"

__dotfile_section_header "Shell Setup" 3 4
shell_dir=$target
[[ $target == nu ]] && shell_dir=nushell
source $DOTFILES/$shell_dir/install.sh

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
