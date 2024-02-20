#!/bin/zsh

# disable giant shadow border in screenshots of windows
defaults write com.apple.screencapture disable-shadow -bool true

# disable default save to iCloud in apps like TextEdit
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool FALSE

# smaller padding for status bar icons
# defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 6
# reset padding for status bar icons
# defaults -currentHost delete -globalDomain NSStatusItemSelectionPadding
