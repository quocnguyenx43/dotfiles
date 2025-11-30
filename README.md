# Fonts
- **JetBrains Mono Fonts**: 
    + [JetBrainsMonoNL-Medium.ttf](https://github.com/podkovyrin/JetBrainsMono/blob/feature/no-ligatures-1-0-3/no-ligatures/JetBrainsMonoNL-Medium.ttf)
- **Nert Fonts**:
    + 0xProto Nerd Font
    + Symbols Nerd Font

# Tools
- GNU Stow (apt or brew installation)
- Wezterm (apt or brew installtion)
- tmux (apt or brew installtion)
- Oh My Zsh:
    - zsh-autosugesstions (Github)
    - zsh-syntax-highlighting (Github)
- Others CLI tools (dependencies):
    + fzf (latest version on Github for Linux, brew for macOS)
    + fd, fdfind (latest version on Github for Linux, brew for MacOS)
    + eza (latest version on Github for Linux, brew for MacOS)
    + zoxide (latest version on Github for Linux, brew for MacOS)
    + ripgrep (apt or brew installtion)
    + bat (apt or brew installtion)
    + jq (apt or brew installtion)
    + neofetch (apt or brew installtion)
    + htop (apt or brew installtion)
    + ffmpeg (apt or brew installtion)
    + imagemagick (apt or brew installtion)
    + 7zip: p7zip-full p7zip-rar (Linux), sevenzip (MacOS)
    + poppler: poppler-utils (apt for Linux), poppler (brew for MacOS)
    + wl-clipboard (apt for Linux only)
    + yazi (change to install using snap, brew for MacOS)
- Desktop apps:
    + Coding: Cursor, VSCode, XCode, Postman, Docker, VMWare
    + Browser: Brave, Firefox
    + Note: Sublime Text, Notion
    + Terminal: WezTerm
    + DB: MongoDB Compass, Redis Insights, Data Grip, Navicat, TablePlus, Azure Data Studio
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

# Software
    - Hadoop -> opt -> zshenv
    - Spark -> opt -> zshenv
    - Maven -> opt -> zshenv

# macOS
- Package manager: Homebrew
- Default shell: zsh
- Shortcuts, hot keys (built-in): Setting up for each device in keyboard settings
    - Disable Capslock action
    - Mapping: Control -> Command, Command -> Control
    - Show launchpad: (Control-Option-A) / (Window-Alt-F position)
    - Show desktop: (Control-Option-D) / (Window-Alt-D position)
    - Stage manager: (Control-Option-S) / (Window-Alt-S position)
    - Show mission control: Control-Up (Window-Up position)
        - Move left desktop: Command-Option-Left (Control-Alt-Left position)
        - Move right desktop: Command-Option-Right (Control-Alt-Right position)
        - Move desktop 1: Command-Option-1 (Control-Alt-1 position)
        - Move desktop 2: Command-Option-2 (Control-Alt-2 position)
    - Change input source: Control-Space (Window-Space position)
    - Sportlight search: Option-Space (Alt-Space position)
    - Quit app: Command-Q (Control-Q position)
- Shortcuts:
    - Karabiner Elements: Enable Capslocks -> HyperKey
    - Aerospace:
        - Layout
            - Screen 1: Default-1, Any-1, Note, Message
            - Screen 2 (main): Default-2, Any-2, 0, 1, 2, 3,...
        - Shortcuts:
            - Change workspace layout: Alt-slash, Alt-comma
            - Floating window: Alt-Shift-space
            - Centralize floating window: Alt-Shift-period
            - Fullscreen floating window: Alt-Shift-enter
            - Focus window:
                - Left: Alt-a
                - Right: Alt-d
                - Up: Alt-w
                - Down: Alt-s
            - Move window:
                - Left: Alt-Shift-a
                - Right: Alt-Shift-d
                - Up: Alt-Shift-w
                - Down: Alt-Shift-s
            - Join window:
                - Left: Control-Alt-Shift-a
                - Right: Control-Alt-Shift-d
                - Up: Control-Alt-Shift-w
                - Down: Control-Alt-Shift-s
            - Resize:
                - Alt-minus
                - Alt-equal
            - Workspace:
                - Alt-<Number>: Change to workspace <number>
                - Alt-Shift-<Number>: Move to workspace <number>
                - Workspace:
                    - f, g: Default-1, Default-2
                    - c, v: Any-1, Any-2
                    - x: Note
                    - z: Message
                - Alt-tab: Focus to the previous workspace
                - Alt-shift-tab: Move workspace to another screen
                - Alt-shift-semicolon: Mode service
            - Mode service:
                - Alt-r: Reload config,
                - Alt-f: Flatten workspace tree
                - Alt-backspace: Close all windows but keep the current window
                - Alt-h, Alt-j, Alt-k, Alt-j: Move floating window
                - Alt-shift-h, Alt-shift-j, Alt-shift-k, Alt-shift-j: Resize floating window
    - skhd:
        - Brave: Hyper-b
        - Finder: Hyper-f
        - Wezterm: Hyper-w
        - Cursor: Hyper-c
        - VSCode: Hyper-v
        - SublimeText: Hyper-s
        - Notion: Hyper-n
        - Spotify: Hyper-m
    - CopyQ:
        - Clipboard History: Command-Shift-V (Control-Shift-V position)

# Ubuntu
- Package manager: apt
- Default shell: zsh
- Shortcuts:
    - kanata: Map Caps Lock to ESC
- Tilling window manager (i3):
    - Background: feh
    - Status bar: polybar
    - App launcher: rofi
    - Compositor: picom
    - Notification: dunst
    - Screenshot: flameshot
    - Required packages for xwindows: xdotool xprop
- CopyQ:
    - Clipboard History: Control-Shift-V
- Work:
    - Proxy:
        - proxychains4
        - privoxy

pipx install sqlfmt
pre-commit => using sqlfmt through pre-commit
docker
kubectl
kind
terraform
helm

Docker-in-Docker: create a Linux container => mount this /var/run/docker.sock into the container => it works

# 3️⃣ fix permissions
sudo usermod -aG docker $USER
newgrp dockerr
