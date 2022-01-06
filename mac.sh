defaults write -g com.apple.desktopservices DSDontWriteNetworkStores true
defaults write -g ApplePressAndHoldEnabled 0

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
