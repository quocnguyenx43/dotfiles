# What's inside:

## Fonts
- **JetBrains Mono Fonts**: [JetBrainsMonoNL-Medium.ttf](https://github.com/podkovyrin/JetBrainsMono/blob/feature/no-ligatures-1-0-3/no-ligatures/JetBrainsMonoNL-Medium.ttf)

## Tools & Apps
- GNU Stow (apt for Linux and brew for MacOS)
- zsh (apt): default shell
- Wezterm (deb for Linux, application for MacOS): default terminal
- tmux (apt for Linux, brew for MacOS)
- Oh My Zsh:
    - zsh-autosugesstions (github)
    - zsh-syntax-highlighting (github)
- Others CLI tools (dependencies):
    + fzf (latest on Github for Linux, brew for MacOS)
    + fd, fdfind (latest on Github, brew for MacOS)
    + eza (latest on Github, brew for MacOS)
    + zoxide (latest on Github, brew for MacOS)
    + ripgrep (apt for Linux, brew for MacOS)
    + bat (batcat apt for Linux, bat brew for MacOS)
    + jq (apt for Linux, brew for MacOS)
    + neofetch (apt for Linux, brew for MacOS)
    + htop (apt for Linux, brew for MacOS)
    + ffmpeg (apt for Linux, brew for MacOS)
    + imagemagick (apt for Linux, brew for MacOS)
    + 7zip: p7zip-full p7zip-rar (Linux), sevenzip (MacOS)
    + poppler: poppler-utils (apt for Linux), poppler (brew for MacOS)
    + wl-clipboard (apt for Linux only)
    + yazi (change to install using snap, brew for MacOS)
- Desktop apps:
    + Coding: VSCode, Postman, VMWare
    + Note: Sublime text
    + DB: MongoDB Compass, Redis Insights, Data Grip, Navicat, TablePlus, Azure Data Studio
    + Tools: JDownloader 2
- Dev apps:
    + make
    + git, lazygit
    + docker, lazydocker (docker engine for Linux, docker desktop for MacOS)
    + uv, ruff (python)
    + nodejs, npm (javscript)
    + golang-go (go)
    + jdk 11/17
    + coursier, (cs, scala, scalac, sbt), maven (for scala, java)
    + neovim (github source) -> opt -> zshenv

## Software
    + Hadoop -> opt -> zshenv
    + Spark -> opt -> zshenv
    + Maven -> opt -> zshenv

## Setup tips
- Change DNS to Google for faster internet (script)
- Enable firewall - ufw (script)
- Config docker user (scrip)
- Change owner /opt/ to $USER

## Setup for Ubuntu
- Gnome Tweaks: Map Caps Lock to ESC
- Startup Program

## Setup for MacOS:
- Brew, brew lock file
- Shortcuts, hot keys (built-in): Setting up for each device in keyboard settings
    - Disable Capslock action
    - Mapping: Control -> Command, Command -> Control
    - Show launchpad: (Command-Option-F) / (Control-Alt-F position)
    - Show desktop: (Command-Option-D) / (Control-Alt-D position)
    - Stage manager: (Command-Option-S) / (Control-Alt-S position)
    - Show mission control: Option-Tab (Alt-Tab position)
        - Move left desktop: Command-Option-Left (Control-Alt-Left position)
        - Move right desktop: Command-Option-Right (Control-Alt-Right position)
    - Open quick note: Command-Option-N / (Control-Alt-N position)
    - Focus to the next window on the same app: Hyper-C (Command-Control-Option-Shift-C)
    - Change input source: Command-Shift-Space (Control-Shift-Space position)
    - Sportlight search: Control-Space (Window-Space position)
    - Finder search: Control-Option-Space (Window-Alt-Space position)
    - Quit app: Command-Q (Control-Q position)
- Shortcuts:
    - Karabiner Elements: Enable Capslocks -> HyperKey
    - Raycast: Window Management and App Management
        - Brave: Hyper-B
        - Finder: Hyper-F
        - Notion: Hyper-N
        - Spotify: Hyper-M
        - Sublime-Text: Hyper-S
        - Wezterm: Hyper-T
        - VSCode: Hyper-D
        - Zalo: Hyper-Z
        - Clipboard History: Hyper-V
        - Window:
            - Almost Maximize: Control-Shift-.
            - Maximize: Control-Option-Shift-.
            - Center: Control-Shift-/
            - Center-Half: Control-Shift-,
            - Make size smaller: Control-+
            - Make size larget: Control-Shift-+
            - Top Half: Control-Shift-Up
            - Bottom Half: Control-Shift-Down
            - Left Half: Control-Shift-Left
            - Right Half: Control-Shift-Right
            - Top Left Quarter: Control-H
            - Top Right Quarter: Control-L
            - Bottom Left Quarter: Control-J
            - Bottom Right Quarter: Control-K
            - Move Up: Control-Up
            - Move Down: Control-Down
            - Move Left: Control-Left
            - Move Right: Control-Right
- Notch
- Tcilling windows: Aerospace, yabai
- SkechyBar
- skhd
- App manager: mas