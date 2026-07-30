# These were mostly inspired by:
# https://github.com/caarlos0/dotfiles.zsh/blob/master/macos

DOTFILES=$(dirname "$(realpath "$0")")
source "$DOTFILES/utils.zsh"

set +e

disable_agent() {
	mv "$1" "$1_DISABLED" >/dev/null 2>&1 ||
	sudo mv "$1" "$1_DISABLED" >/dev/null 2>&1
}

unload_agent() {
	launchctl unload -w "$1" >/dev/null 2>&1
}

echo -e "${__dotfile_yellow}  → Show hidden files by default in Finder${__dotfile_nc}"
defaults write com.apple.finder AppleShowAllFiles -boolean true

echo -e "${__dotfile_yellow}  → Show battery percent${__dotfile_nc}"
defaults write com.apple.menuextra.battery ShowPercent -bool true

echo -e "${__dotfile_yellow}  → Set dark interface style${__dotfile_nc}"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

echo -e "${__dotfile_yellow}  → Save to disk by default, instead of iCloud${__dotfile_nc}"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo -e "${__dotfile_yellow}  → Group windows by applications on mission control screen${__dotfile_nc}"
defaults write com.apple.dock "expose-group-apps" -bool true
