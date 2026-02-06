#!/bin/sh

# Params
USER_NAME="quocnguyen-dsv"

# Ask for the administrator password upfront
sudo -v

# Close any open System Preferences panes, to prevent them from overriding, settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable system startup sound
sudo nvram StartupMute=%01

# Change Mac name
sudo scutil --set ComputerName "${USER_NAME}'s MacBook"
sudo scutil --set HostName "${USER_NAME}-macbook"
sudo scutil --set LocalHostName "${USER_NAME}-macbook"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server.plist NetBIOSName -string "${USER_NAME}-macbook"

# Set dock position to the bottom
defaults write com.apple.dock "orientation" -string "bottom"

# Set dock icon size to 36 pixels
defaults write com.apple.dock "tilesize" -int "36"

# Set autohide dock to true
defaults write com.apple.dock "autohide" -bool "true"

# Set autohide animation to 0.5 seconds
defaults write com.apple.dock "autohide-time-modifier" -float "2"

# Set to show only open applications in the dock (dont show recent apps)
defaults write com.apple.dock "show-recents" -bool "false"

# Set animation effect when minimizing windows
defaults write com.apple.dock "mineffect" -string "suck"

# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
#rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture "type" -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture "disable-shadow" -bool "false"

# Create and set screenshots directory
defaults write com.apple.screencapture "location" -string "${HOME}/Desktop"

# Finder: Add option to quit
defaults write com.apple.finder "QuitMenuItem" -bool "true"

# Finder: Show filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: Show path bar
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Finder: Show status bar
defaults write com.apple.finder "ShowStatusBar" -bool "true"

# Finder: Default is list view
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# Finder: Keep folders on top when sorting by name
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "false"

# Finder: Open folders in new window
defaults write com.apple.finder "FinderSpawnTab" -bool "false"

# Finder: Default search scope is current folder
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

# Finder: Keep binary files in the trash forever
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "false"

# Finder: Dont show warning when changing file extension
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# Finder: Default directory to save files is icloud
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "true"

# Finder: Sidebar icon size to small
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "2"

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true 

# Desktop: Keep folders on top when sorting by name
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"

# Desktop: Show item info on the desktop
defaults write com.apple.finder "CreateDesktop" -bool "true"

# Desktop: Show all Hard Drives, RemovableMedia and Mounted Servers on the desktop
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "true"
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "false"
defaults write com.apple.finder "ShowRemovableMediaOnDesktop" -bool "true"
defaults write com.apple.finder "ShowMountedServersOnDesktop" -bool "true"

# Menubar: Solid black menu bar
defaults write com.apple.menuextra.clock "FlashDateSeparators" -bool "false"

# Menubar: Never hide the menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool false

# Mouse: Tracking speed
defaults write NSGlobalDomain com.apple.mouse.scaling -float "1"

# Mouse: Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Trackpad: Click weight
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "1"

# Keyboard: Disable press-and-hold for keys in favor of key repeat (dont show character accents menu, just repeat key)
defaults write -g ApplePressAndHoldEnabled -bool "false"

# Keyboard: Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 3 # Delay until repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 25 # Speed of repeat

# Keyboard: Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Keyboard: Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Keyboard: Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Keyboard: Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Keyboard: Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Keyboard: Disable fn key
defaults write com.apple.HIToolbox AppleFnUsageType -int "0"

# Keyboard: Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Keyboard: Turn the keyboard source indicator
defaults write kCFPreferencesAnyApplication TSMLanguageIndicatorEnabled -bool "true"
 
# Keyboard: Enable mouse zooming
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 1048576

# Mission control: Group windows by application
defaults write com.apple.dock "expose-group-apps" -bool "true"

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Resume system-wide, resume apps when rebooting
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable the "reopen windows when logging back in" option
# This works, although the checkbox will still appear to be checked,
# and the command needs to be entered again for every restart.
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Finder: Show scroll bars only when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Finder: Reduce lagging when resizing windows, reduce animation time
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "vi"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Safari and Webkit

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Change timezone
sudo systemsetup -settimezone "Asia/Ho_Chi_Minh" > /dev/null

# Energy

# Enable lid wakeup, so the computer wakes up when the lid is opened
sudo pmset -a lidwake 1

# Restart automatically on power loss
sudo pmset -a autorestart 1

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Sleep the display after 15 minutes
sudo pmset -a displaysleep 15

# Disable machine sleep while charging
sudo pmset -c sleep 30

# Set machine sleep to 5 minutes on battery
sudo pmset -b sleep 3

# Deep sleep, 86400 = 24 hours, 5400 = 1 hour 30 mins
sudo pmset -a standbydelay 5400

# Restart some applications may have been running when the settings were changed
APPS=(
    Finder
    Dock
    Mail
    Safari
    iTunes
    "iCal Address Book"
    SystemUIServer
    Terminal
    "System Preferences"
    "Activity Monitor"
    "TextEdit"
    "Calendar"
    "Activity Monitor"
    "Address Book"
    "Calendar"
    "cfprefsd"
    "Contacts"
    "Dock"
    "Finder"
    "Google Chrome Canary"
    "Google Chrome"
    "Mail"
    "Messages"
    "Opera"
    "Photos"
    "Safari"
    "SizeUp"
    "Spectacle"
    "SystemUIServer"
    "Terminal"
    "Transmission"
    "Tweetbot"
    "Twitter"
    "iCal"
)

for APP in "${APPS[@]}"; do
    killall "$APP" &>/dev/null
done

echo "macOS configuration done"
