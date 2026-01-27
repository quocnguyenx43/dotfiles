# quocnguyen's dotfiles

## Fonts
- [JetBrains Mono & JetBrains Mono NL (no ligatures)](https://github.com/podkovyrin/JetBrainsMono/blob/feature/no-ligatures-1-0-3/no-ligatures/JetBrainsMonoNL-Medium.ttf)
    - Used by WezTerm
- [FiraCode Nerd Font](https://github.com/abc)
    - Used by WezTerm
- [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font)
    - Used by sketchybar (MacOS)
- [SF Symbols](https://github.com/SF)
    - Used by sketchybar (MacOS)

## Core Tools
- **GNU Stow**
- **zsh & Oh My Zsh**:
    - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- **tmux**
- **Wezterm**

## CLI Utilities

> Navigation, search, text, sys-info, archives. Download the lastest version on Github.

- fzf
- fd / fdfind
- eza
- zoxide
- ripgrep
- bat
- jq
- yq
- neofetch
- htop
- ffmpeg
- imagemagick
- 7zip / sevenzip
- poppler
- wl-clipboard (Linux only; install with `apt`)
- yazi

## Development Stack

> Languages, build tools, dev helpers

- **System tools**:
    - curl
    - wget
    - git
    - ssh
- **Build tools**:
    - make
- **Version control**:
    - git
    - lazygit
- **Containers & DevOps**:
    - docker
    - lazydocker
    - kind / minikube
    - kubectl
    - kubectx / kubens
    - k9s
    - helm
    - kustomize
    - terraform
- **Python**:
    - uv
    - ruff
- **JVM stack (Spark, Flink)**:
    - coursier (`cs`, JDK, scala, scalac, sbt)
- **JavaScript**:
    - nodejs (node)
    - npm
- **Go**:
    - go
- **Rust**:
    - cargo
- **Editor integration**:
    - neovim (recommended: build from source; add to PATH in .zshenv for Linux)
- **Cloud**:
    - gcloud (GCP)
    - bq (for BigQuery)
    - aws-cli (AWS)
    - rclone
- **Others**:
    - pre-commit (with [`sqlfmt`](https://github.com/sqlfmt/sqlfmt) as an example hook)

## Desktop Applications

### Code Editors & IDEs
- [Antigravity](https://www.antigravity.google/)
    - Antigravity Coding Agent
- [Cursor](https://www.cursor.so/)
    - Cursor Coding Agent
- [Visual Studio Code](https://code.visualstudio.com/)
    - GitHub Copilot
- [Xcode](https://developer.apple.com/xcode/)
    - macOS-only
- [PyCharm](https://www.jetbrains.com/pycharm/)
- [Neovim](https://neovim.io/)

### AI & Coding Agents
- [Claude](https://www.anthropic.com/products/claude)
    - Claude-code CLI
    - Claude-code web/desktop
- [OpenAI Codex](https://platform.openai.com/docs/guides/code)
    - CLI Coding Agents
- [Jules](https://jules.ai/)
    - Web-based Coding Agent
    - CLI Coding Agent
- [Gemini](https://www.cursor.so/)
    - CLI Coding Agent

### AI & LLM Runtime
- [Ollama](https://ollama.com/)
- [llama.cpp](https://github.com/ggerganov/llama.cpp)
- [LM Studio](https://lmstudio.ai/)

### AI Token Monitor
- ClaudeBar (MacOS)

### Codebase Understanding
- [CodeWiki](https://github.com/quocnguyenx43/CodeWiki)
    - Explore internal/public codebases
- [DeepWiki](https://github.com/quocnguyenx43/deepwiki)
    - Explore internal/public codebases
- [Sourcegraph](https://sourcegraph.com/)
    - Code search

### Terminal Emulators
- [WezTerm](https://wezfurlong.org/wezterm/)

### Development Tools
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [VMware Fusion/Workstation](https://www.vmware.com/)
- [Postman](https://www.postman.com/)
- [DataGrip](https://www.jetbrains.com/datagrip/)
    - Database IDE
- [TablePlus](https://tableplus.com/)
    - Database GUI
- [Navicat](https://www.navicat.com/)
- [MongoDB Compass](https://www.mongodb.com/try/download/compass)
- [RedisInsight](https://redis.com/redis-enterprise/redis-insight/)

### Browsers
- [Brave](https://brave.com/)
- [Firefox](https://www.mozilla.org/firefox/)
- [Google Chrome](https://www.google.com/chrome/)
- [Safari](https://www.apple.com/safari/)

### Notes & Productivity
- [Sublime Text](https://www.sublimetext.com/)
- [Notion](https://www.notion.so/)
- [Obsidian](https://obsidian.md/)

### Network & Connection
- [Cloudflare](https://www.cloudflare.com/)
- [OpenVPN](https://openvpn.net/)
- [TeamViewer](https://www.teamviewer.com/)

### Secrets
- [KeePassXC](https://keepassxc.org/)
- [Apple Passwords](https://support.apple.com/en-us/HT209966)

### Media & Social
- [Capcut](https://capcut.com/)
- [Spotify](https://www.spotify.com/)
- [Zalo](https://zalo.vn/)
- [Telegram](https://www.telegram.org/)
- [Discord](https://discord.com/)

---

## macOS
- Package manager: `brew`
- Default shell: `zsh`
- Details: `os/macos/MACOS.md`.

## Arch Linux
- Package manager: `pacman`
- Default shell: `zsh`
- Details: `os/arch/ARCH.md`.

## Repository Layout

- `os/`: OS-specific configs and package lists.
- `scripts/`: Helper scripts to manage dotfiles.
- `common/`: Cross-platform configs.
- `macos/`: MacOS-only configs.
- `arch/`: Arch Linux-only configs.
- `config/paths.json`: Mapping from app name → OS-specific config path under `$HOME` that `scripts/stow.sh` Uses to copy/sync configs.
- `apps/`: A mirror of the target paths that `scripts/stow.sh` populates; you normally don’t edit this by hand.
- `archive/`: Old configs that are not used.

## How `config/paths.json` is used

- Choose correct version of:
    - `ssh`
- `scripts/stow.sh` reads `config/paths.json` with `jq` and uses the `OS` detected by `scripts/state.sh` to pick the right path for each app.
- Section `common` has entries like `"claude": { "folder": "claude", "macos": ".config/claude", "arch": ".config/claude" }` so the same config is copied to the correct `$HOME` path on both OSes.
- Sections `macos` and `arch` hold OS-specific tools (window managers, status bars, etc.), each mapped to a single path under `$HOME`.

To add a new tool:
- Add its directory under `common/`, `macos/`, or `arch/` (e.g. `common/wezterm/`).
- Add a key to `config/paths.json` with the appropriate macOS/Arch paths.
- Re-run `scripts/state.sh` (if needed) and `scripts/stow.sh`.

## Scripts

### Run in order:

- `scripts/state.sh` — detect and save machine type.
- `scripts/stow.sh` — apply configs based on `config/paths.json`.
- `scripts/clean.sh` — cleanup generated folders.
- `scripts/utils.sh` - used by other scripts.

## Archived

- Fonts:
    - Archived: [0xProto Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest) (Nerd Font)
        - Use by polybar
    - Archived: [Symbols Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest)
        - Use by polybar

## Author
__Maintained by Quoc Nguyen__
- GitHub: [@quocnguyenx43](https://github.com/quocnguyenx43/)
- LinkedIn: [@quocnguyenx43](https://www.linkedin.com/in/quocnguyenx43/)
- Email: [quocnguyenx43@gmail.com](mailto:{quocnguyenx43@gmail.com})
