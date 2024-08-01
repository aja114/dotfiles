# These were mostly inspired by:
# https://github.com/caarlos0/dotfiles.zsh/blob/master/macos

set +e

disable_agent() {
	mv "$1" "$1_DISABLED" >/dev/null 2>&1 ||
	sudo mv "$1" "$1_DISABLED" >/dev/null 2>&1
}

unload_agent() {
	launchctl unload -w "$1" >/dev/null 2>&1
}

# Remove itunes player
echo "  › Disable iTunes helper"
disable_agent /Applications/iTunes.app/Contents/MacOS/iTunesHelper.app

echo "  › Prevent play button from launching iTunes"
unload_agent /System/Library/LaunchAgents/com.apple.rcd.plist

echo "  › show hidden files by default in Finder"
defaults write com.apple.finder AppleShowAllFiles -boolean true

echo "  › show battery percent"
defaults write com.apple.menuextra.battery ShowPercent -bool true

echo "  › Set dark interface style"
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

echo "  › Save to disk by default, instead of iCloud"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

