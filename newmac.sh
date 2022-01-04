#!/usr/bin/env bash
########################################################################### 
# simple bash script for automatic installation of used apps on the new mac
###########################################################################
# do not forget to give proper rights (chmod a+x newmac.sh)
###########################################################################
echo "Starting"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
brew update

#define packages to be installed
PACKAGES=(
    git
    wget
    mas
    glances
    cask
    telnet
    nmap
    tree
    arp-scan
    hudochenkov/sshpass/sshpass
    duck
    cyberduck
    teamviewer
    xclip
    dockutil
    pwgen
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

#define cask packages to be installed
CASKS=(
    itsycal
    iterm2
    MacPass
    tuxera-ntfs
    firefox
    balenaetcher
    drawio
    hush
    cheatsheet
    spotify
    onlyoffice
    mathpix-snipping-tool
    sensei
    sublime-text
    vlc
    cyberduck
    teamviewer
    termius
    airflow
    deepl
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

echo "mac configuration"
echo "configuring colours in shell"

echo 'export CLICOLOR=1' | sudo tee -a ~/.zshrc
echo 'export LSCOLORS=ExFxBxDxCxegedabagacad' | sudo tee -a ~/.zshrc
echo 'alias ls='ls -GFh'' | sudo tee -a ~/.zshrc
echo 'export CLICOLOR=1' | sudo tee -a ~/.bash_profile
echo 'export LSCOLORS=ExFxBxDxCxegedabagacad' | sudo tee -a ~/.bash_profile
echo 'alias ls='ls -GFh'' | sudo tee -a ~/.bash_profile

echo "removing and adding icons over dockutil"

dockutil --remove 'Contacts'
dockutil --remove 'Maps'
dockutil --remove 'FaceTime'
dockutil --remove 'Reminders'
dockutil --remove 'TV'
dockutil --remove 'Music'
dockutil --remove 'Podcasts'
dockutil --add /Applications/Termius.app
dockutil --add /Applications/iTerm.app
dockutil --add /Applications/MacPass.app
dockutil --add '/Applications/Sublime Text.app'
dockutil --add '/Applications/Cyberduck.app'
dockutil --add '/Applications/Spotify.app'
dockutil --add '/Applications/Firefox.app'

echo "changing hostname"

echo "$(tput setaf 1)$(tput setab 7) \
Type your hostname (rmbp): \
$(tput sgr 0)"
read compname
sudo scutil --set ComputerName $compname
sudo scutil --set LocalHostName $compname
sudo scutil --set HostName $compname

echo "end rest of the changes"

#Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set language and text formats
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en" "cs"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/Prague" > /dev/null

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Hide & Show it fast
defaults write com.apple.dock autohide-time-modifier -float 0; killall Dock
echo.
echo "complete, please reboot"
