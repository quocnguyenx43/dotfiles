# qn's dotfiles

## Fonts
- [JetBrains Mono NL (no ligatures)](https://github.com/podkovyrin/JetBrainsMono/blob/feature/no-ligatures-1-0-3/no-ligatures/JetBrainsMonoNL-Medium.ttf)
- Nerd Fonts: 0xProto Nerd Font and Symbols Nerd Font

## Core Tools
- GNU Stow (apt | brew)
- Wezterm (apt | brew)
- tmux (apt | brew)
- Oh My Zsh:
    - zsh-autosugesstions (Github)
    - zsh-syntax-highlighting (Github)

## CLI Utilities

> Navigation, search, text, sys-info, archives

- fzf — latest release (GitHub for Linux, brew on macOS)
- fd / fdfind — latest release (GitHub for Linux, brew on macOS)
- eza — latest release (GitHub for Linux, brew on macOS)
- zoxide — latest release (GitHub for Linux, brew on macOS)
- ripgrep — apt / brew
- bat — apt / brew
- jq — apt / brew
- neofetch — apt / brew
- htop — apt / brew
- ffmpeg — apt / brew
- imagemagick — apt / brew
- 7zip
    - Linux: p7zip-full p7zip-rar
    - macOS: sevenzip
- poppler
    - Linux: poppler-utils
    - macOS: poppler
- wl-clipboard — apt (Linux only)
- yazi — snap (Linux), brew (macOS)

## Development Stack

> Languages, build tools, dev helpers

- make
- Version control:
    - git, lazygit
- Containers & DevOps:
    - docker / lazydocker
    - kubectl
    - kind
    - terraform
    - helm
- Python:
    - uv, ruff
- JavaScript:
    - nodejs, npm
- Go:
    - golang-go
- Rust:
    - cargo
- JVM stack:
    - jdk 11/17
    - coursier (cs, scala, scalac, sbt)
    - maven
- Editor integration:
    - neovim (built from source, added to PATH via .zshenv)
- Commit hooks:
    - pre-commit (using sqlfmt)

## Desktop Application
- Coding
    - Cursor
    - VSCode
    - XCode (macOS)
    - Postman
    - Docker
    - VMWare
- Browser
    - Brave
    - Firefox
- Notes
    - Sublime Text
    - Notion
- Terminal
    - WezTerm
- Databases
    - MongoDB Compass
    - Redis Insights
    - DataGrip
    - Navicat
    - TablePlus

## macOS
- Package Manager: `brew`
- Default Shell: `zsh`
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

## Repo layout

- `common/`: cross-platform configs that are shared between macOS and Ubuntu (e.g. `nvim`, `zsh`, `ssh`, `wezterm`, `yazi`, `vscode`, `cursor`, `sublime_text`).
- `macos/`: macOS-only configs (Karabiner, Aerospace, Yabai, `skhd`, AppleScripts, system keybindings, Claude settings).
- `ubuntu/`: Ubuntu-only configs (i3, i3blocks, polybar, rofi, dunst, picom, kanata, etc).
- `config/paths.json`: mapping from logical app name → OS-specific config path under `$HOME` that `scripts/stow.sh` uses to copy/sync configs.
- `apps/`: a mirror of the target paths that `scripts/stow.sh` populates; you normally don’t edit this by hand.

## How `config/paths.json` is used

- `scripts/stow.sh` reads `config/paths.json` with `jq` and uses the `OS` detected by `scripts/state.sh` to pick the right path for each app.
- Section `common` has entries like `"nvim": { "macos": ".config/nvim", "ubuntu": ".config/nvim" }` so the same config is copied to the correct `$HOME` path on both OSes.
- Sections `macos` and `ubuntu` hold OS-specific tools (window managers, status bars, etc.), each mapped to a single path under `$HOME`.
- For each entry:
  - Creates the target directory under `$HOME` (e.g. `$HOME/.config/nvim`).
  - Creates the corresponding directory under `apps/` (e.g. `apps/.config/nvim`).
  - Copies everything from `<section>/<app>/` into the `apps/` mirror so you can inspect the final config tree.

To add a new tool:
- Add its directory under `common/`, `macos/`, or `ubuntu/` (e.g. `common/wezterm/`).
- Add a key to `config/paths.json` with the appropriate macOS/Ubuntu paths.
- Re-run `scripts/state.sh` (if needed) and `scripts/stow.sh`.

## Scripts

### Run in order:

- `scripts/state.sh` — detect and save machine type
- `scripts/os.sh` — detect OS + architecture
- `scripts/check_env.sh` — health check for required tools
- `scripts/stow.sh` — apply configs based on config/paths.json
- `scripts/clean.sh` — cleanup generated folders

## Author
__Maintained by Quoc Nguyen__
- GitHub: [@quocnguyenx43](https://github.com/quocnguyenx43/)
- LinkedIn: [@quocnguyenx43](https://www.linkedin.com/in/quocnguyenx43/)
- Email: [quocnguyenx43@gmail.com](mailto:{quocnguyenx43@gmail.com})
