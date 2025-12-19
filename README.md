# qn's dotfiles

## Fonts
- [JetBrains Mono NL (no ligatures)](https://github.com/podkovyrin/JetBrainsMono/blob/feature/no-ligatures-1-0-3/no-ligatures/JetBrainsMonoNL-Medium.ttf)
- [0xProto Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest) (Nerd Font)
- [Symbols Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest)

## Core Tools
- **GNU Stow** (`apt` | `brew`)
- **Wezterm** (`apt` | `brew`)
- **tmux** (`apt` | `brew`)
- **Oh My Zsh**:
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

## CLI Utilities

> Navigation, search, text, sys-info, archives

- fzf
    - Linux: download latest release from GitHub
    - macOS: install with Homebrew (`brew install fzf`)
- fd / fdfind
    - Linux: download latest release from GitHub (binary may be named `fdfind`)
    - macOS: install with Homebrew (`brew install fd`)
- eza
    - Linux: download latest release from GitHub
    - macOS: install with Homebrew (`brew install eza`)
- zoxide
    - Linux: download latest release from GitHub
    - macOS: install with Homebrew (`brew install zoxide`)
- ripgrep
    - Linux: install with `apt`
    - macOS: install with Homebrew (`brew install ripgrep`)
- bat
    - Linux: install with `apt`
    - macOS: install with Homebrew (`brew install bat`)
- jq
    - Linux: install with `apt`
    - macOS: install with Homebrew (`brew install jq`)
- neofetch
    - Linux: install with `apt`
    - macOS: install with Homebrew (`brew install neofetch`)
- htop
    - Linux: install with `apt`
    - macOS: install with Homebrew (`brew install htop`)
- ffmpeg
    - Linux: install with `apt`
    - macOS: install with Homebrew (`brew install ffmpeg`)
- imagemagick
    - Linux: install with `apt`
    - macOS: install with Homebrew (`brew install imagemagick`)
- 7zip
    - Linux: install `p7zip-full` and `p7zip-rar` with `apt`
    - macOS: install `sevenzip` with Homebrew (`brew install sevenzip`)
- poppler
    - Linux: install `poppler-utils` with `apt`
    - macOS: install `poppler` with Homebrew (`brew install poppler`)
- wl-clipboard (Linux only; install with `apt`)
- yazi
    - Linux: install with snap (`snap install yazi`)
    - macOS: install with Homebrew (`brew install yazi`)

## Development Stack

> Languages, build tools, dev helpers

- **Build tools**:
    - make
- **Version control**:
    - git
    - lazygit
- **Containers & DevOps**:
    - docker
    - lazydocker
    - kubectl
    - kind
    - terraform
    - helm
- **Python**:
    - uv
    - ruff
- **JavaScript**:
    - nodejs
    - npm
- **Go**:
    - go
- **Rust**:
    - cargo
- **JVM stack (Spark, Flink)**:
    - jdk (11/17)
    - coursier (`cs`, scala, scalac, sbt)
    - sbt / maven (prefer sbt than maven)
- **Editor integration**:
    - neovim (recommended: build from source; add to PATH in .zshenv)
- **Commit hooks**:
    - pre-commit (with [`sqlfmt`](https://github.com/sqlfmt/sqlfmt) as an example hook)
- **Cloud**:
    - aws-cli
    - rclone (aws)
## Desktop Applications

### Code Editors & IDEs
- [Cursor](https://www.cursor.so/)
- [Visual Studio Code (VSCode)](https://code.visualstudio.com/)
- [Xcode](https://developer.apple.com/xcode/) (macOS-only)
- [Sublime Text](https://www.sublimetext.com/)
- [Neovim](https://neovim.io/) (see Terminal section)

### API & Development Tools
- [Postman](https://www.postman.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [VMware Fusion/Workstation](https://www.vmware.com/)
- [TablePlus](https://tableplus.com/) (Database GUI)
- [DataGrip](https://www.jetbrains.com/datagrip/) (Database IDE)
- [Navicat](https://www.navicat.com/)
- [MongoDB Compass](https://www.mongodb.com/try/download/compass)
- [RedisInsight](https://redis.com/redis-enterprise/redis-insight/)

### Browsers
- [Brave](https://brave.com/)
- [Firefox](https://www.mozilla.org/firefox/)
- [Google Chrome](https://www.google.com/chrome/) (optional)

### Notes & Productivity
- [Notion](https://www.notion.so/)
- [Obsidian](https://obsidian.md/) (optional for Markdown knowledge bases)
- [Sublime Text](https://www.sublimetext.com/) (also listed under editors)

### Terminal Emulators
- [WezTerm](https://wezfurlong.org/wezterm/)

### AI & LLM Runtime
- [Ollama](https://ollama.com/)
- [llama.cpp](https://github.com/ggerganov/llama.cpp)
- [LM Studio](https://lmstudio.ai/) (optional)

### Network
- [OpenVPN](https://openvpn.net/)

---

## Useful Tools

### Code Understanding & Documentation
- [CodeWiki](https://github.com/quocnguyenx43/CodeWiki) (internal or personal tool)
- [DeepWiki](https://github.com/quocnguyenx43/deepwiki) (internal or personal tool)
- [Sourcegraph](https://sourcegraph.com/) (optional for code search)

### Coding Agents & Code AI
- [Cursor](https://www.cursor.so/) (AI coding assistant)
- [Claude](https://www.anthropic.com/products/claude) (Claude-code, via API/browser)
- [GitHub Copilot](https://github.com/features/copilot)
- [OpenAI Codex](https://platform.openai.com/docs/guides/code) (API/IDE integrations)
- [Antigravity](https://github.com/quocnguyenx43/antigravity) (custom tool; optional)

## macOS
- Package manager: `brew`
- Default shell: `zsh`
- Detailed shortcuts, hotkeys, and window manager setup: see `MACOS.md`.

## Ubuntu
- Package manager: `apt`
- Default shell: `zsh`
- Tiling WM, status bar, and desktop tooling: see `UBUNTU.md`.

## Repo layout

- `common/`: cross-platform configs that are shared between macOS and Ubuntu (e.g. `nvim`, `zsh`, `ssh`, `wezterm`, `yazi`, `vscode`, `cursor`, `sublime_text`).
- `macos/`: macOS-only configs (Karabiner, Aerospace, Yabai, `skhd`, AppleScripts, system keybindings, Claude settings).
- `ubuntu/`: Ubuntu-only configs (i3, i3blocks, polybar, rofi, dunst, picom, kanata, etc).
- `config/paths.json`: mapping from logical app name → OS-specific config path under `$HOME` that `scripts/stow.sh` uses to copy/sync configs.
- `apps/`: a mirror of the target paths that `scripts/stow.sh` populates; you normally don’t edit this by hand.

## How `config/paths.json` is used

- Choose correct version of:
    - `ssh`
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

- `scripts/state.sh` — detect and save machine type.
- `scripts/os.sh` — detect OS + architecture.
- `scripts/check_env.sh` — health check for required tools.
- `scripts/stow.sh` — apply configs based on `config/paths.json`.
- `scripts/clean.sh` — cleanup generated folders.

## Author
__Maintained by Quoc Nguyen__
- GitHub: [@quocnguyenx43](https://github.com/quocnguyenx43/)
- LinkedIn: [@quocnguyenx43](https://www.linkedin.com/in/quocnguyenx43/)
- Email: [quocnguyenx43@gmail.com](mailto:{quocnguyenx43@gmail.com})
