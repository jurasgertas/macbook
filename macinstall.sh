#!/bin/bash
# taken from Roman / Roklseky
# https://formulae.brew.sh/cask/
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# chmod a+x macinstall.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap homebrew/cask
brew install wget
brew install mas
brew install --cask xcodes
brew install glances
brew install cask

# PKG python
wget https://www.python.org/ftp/python/3.10.0/python-3.10.0-macos11.pkg
PKG=$(find *.pkg)
sudo installer -package $PKG -target /
rm $PKG

# Dev
# brew install --cask docker
# brew install --cask rancher
# brew install helm
# echo 'alias docker=nerdctl' | sudo tee -a ~/.zshrc
# echo 'alias docker=nerdctl' | sudo tee -a ~/.bash_profile
brew install --cask visual-studio-code
brew install --cask pycharm-ce
brew install --cask iterm2
brew install ruby
export SDKROOT=$(xcrun --show-sdk-path)
echo 'export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"' | sudo tee -a ~/.zshrc
echo 'export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"' | sudo tee -a ~/.bash_profile
echo 'export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"' | sudo tee -a ~/.zshrc
echo 'export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"' | sudo tee -a ~/.bash_profile

# Make folders collored in shell
echo 'export CLICOLOR=1' | sudo tee -a ~/.zshrc
echo 'export LSCOLORS=ExFxBxDxCxegedabagacad' | sudo tee -a ~/.zshrc
echo 'alias ls='ls -GFh'' | sudo tee -a ~/.zshrc
echo 'export CLICOLOR=1' | sudo tee -a ~/.bash_profile
echo 'export LSCOLORS=ExFxBxDxCxegedabagacad' | sudo tee -a ~/.bash_profile
echo 'alias ls='ls -GFh'' | sudo tee -a ~/.bash_profile

# DMG flasher
# git clone https://github.com/marcelstoer/nodemcu-pyflasher.git
GITHUB_URL=https://github.com/marcelstoer/nodemcu-pyflasher/releases
VERSION_PY_FLASHER=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
wget https://github.com/marcelstoer/nodemcu-pyflasher/releases/download/${VERSION_PY_FLASHER}/NodeMCU-PyFlasher.dmg
DMG=$(find *.dmg)
sudo hdiutil attach $DMG
APP=$(find /Volumes -name '*.app')
sudo cp -R "$APP" /Applications
DET="$(cut -d'/' -f3 <<<"$APP")"
sudo hdiutil detach "/Volumes/$DET"
rm $DMG

# TAR ESP Flasher
wget https://github.com/Jason2866/ESP_Flasher/releases/download/v.1.3/ESP-Flasher_macOS.zip
unzip -a ESP-Flasher_macOS.zip
rm ESP-Flasher_macOS.zip
# tar -xvf dist.tar

# ZIP Arduino
#LAST=$(curl https://arduino-cli.github.io/arduino-version/list | grep -oE "[^,]+$")
#wget https://downloads.arduino.cc/arduino-$LAST-macosx.zip
#unzip -a arduino-$LAST-macosx.zip
#sudo mv Arduino.app /Applications/Arduino.app
#rm arduino-$LAST-macosx.zip

# Tools
brew install --cask trezor-suite
brew install --cask itsycal
brew install --cask enpass
brew install --cask tuxera-ntfs
brew install --cask firefox
brew install --cask balenaetcher
brew install --cask hush
brew install --cask drawio
brew install --cask cheatsheet
brew install --cask alfred
brew install --cask mathpix-snipping-tool
brew install --cask sublime-text
brew install --cask onlyoffice
brew install --cask sensei
brew install azure-cli
brew install awscli
brew install pwgen
# brew install --cask google-cloud-sdk
# https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-365.0.1-darwin-x86_64.tar.gz
# echo 'source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"' | sudo tee -a ~/.zshrc
# echo 'source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"' | sudo tee -a ~/.bash_profile

# Transfer (SFTP,SSH...)
brew install wget
brew install telnet
brew install nmap
brew install tree
brew install arp-scan
brew install hudochenkov/sshpass/sshpass
brew install --cask tunnelblick
brew install duck
brew install --cask cyberduck
brew install --cask teamviewer
#brew install --cask transfer
brew install --cask termius
brew install termius
brew link termius
brew install xclip

# iTerm tuning
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo 'source ~/.bash_profile' | sudo tee -a ~/.zshrc
source ~/.zshrc
cd ~/Library/Fonts
wget https://github.com/Falkor/dotfiles/blob/master/fonts/SourceCodePro%2BPowerline%2BAwesome%2BRegular.ttf
cd
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Media
brew install --cask kodi
brew install --cask vlc
brew install --cask airflow

# Translate
brew install --cask deepl

# PKG anaconda https://repo.anaconda.com/archive/
wget https://repo.anaconda.com/archive/Anaconda3-2021.05-MacOSX-x86_64.pkg
PKG=$(find *.pkg)
sudo installer -package $PKG -target /
rm $PKG

# Printer Xerox 3025
#wget https://www.support.xerox.com/en-us/product/workcentre-3025/downloads?language=en&platform=macosx107#

# Filezilla
#wget https://download.filezilla-project.org/client/FileZilla_3.55.1_macosx-x86.app.tar.bz2
#tar -xvf FileZilla_3.55.1_macosx-x86.app.tar.bz2
#sudo mv FileZilla.app /Applications/FileZilla.app
#rm FileZilla_3.55.1_macosx-x86.app.tar.bz2

# change dockutil on the desktop
brew install dockutil
dockutil --remove 'Contacts'
dockutil --remove 'Maps'
dockutil --remove 'FaceTime'
dockutil --remove 'Reminders'
dockutil --remove 'TV'
dockutil --remove 'Music'
dockutil --remove 'News'
dockutil --remove 'Stocks'
dockutil --remove 'Launchpad'
dockutil --remove 'Podcasts'
dockutil --remove 'Siri'
dockutil --add /Applications/Termius.app
dockutil --add /Applications/iTerm.app
dockutil --add '/Applications/PyCharm CE.app'
dockutil --add '/Applications/Visual Studio Code.app'
dockutil --add /Applications/Anaconda-Navigator.app
#dockutil --add '/Applications/Rancher Desktop.app'
#dockutil --add /Applications/VirtualBox.app
dockutil --add /Applications/Enpass.app
dockutil --add '/Applications/Sublime Text.app'
dockutil --add '/Applications/Cyberduck.app'

#gem install bundler jekyll
#bundle add webrick

echo "$(tput setaf 1)$(tput setab 7) \
Type your hostname (rmbp): \
$(tput sgr 0)"
read compname
sudo scutil --set ComputerName $compname
sudo scutil --set LocalHostName $compname
sudo scutil --set HostName $compname



# Sign-in to appstore https://github.com/mas-cli/mas
echo "$(tput setaf 1)$(tput setab 7) \
Login to app store. Press Enter when done: \
$(tput sgr 0)"

# mas signin doesn't work, therefore:
open -a "App Store"
read

# read appleID
# mas signin $appleID
# Graphical sign in "mas signin --dialog mas@example.com"

# install numbers via mas
#mas install 409203825

# install cryptowatch via mas
#mas install 1527457231

# Trackpad: enable tap to click for this user and for the login screen
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

# Identity tool onstalation (CR)
wget https://info.eidentita.cz/Download/eObcanka.dmg
DMG=$(find *.dmg)
sudo hdiutil attach $DMG
PKG=$(find /Volumes -name '*.pkg')
sudo installer -package $PKG -target /
DET="$(cut -d'/' -f3 <<<"$PKG")"
sudo hdiutil detach /Volumes/$DET
rm $DMG

# Name resolution config (home)
while read p; do
  echo "$p" | sudo tee -a /etc/hosts
done <~/Documents/hosts.txt

# SSH config
if sudo cat /etc/ssh/ssh_config | grep "#   StrictHostKeyChecking ask"
then
sudo sed -i '' 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config
sudo sed -i '' 's|#   IdentityFile ~/.ssh/id_rsa|IdentityFile ~/.ssh/r-mbp|g' /etc/ssh/ssh_config
fi

echo "$(tput setaf 1)$(tput setab 7) \
Done! Pease reboot system. \
$(tput sgr 0)"
