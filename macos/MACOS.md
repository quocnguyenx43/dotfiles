## macOS

### Basics

- **Package manager**: `brew`
- **Default shell**: `zsh`
- **Settings**:
  - Auto hide Dock

### Tools & Apps
- iTerm2
  - iTerm-AI Pluginc
- brew `coreutils` (GNU File, Shell, and Text utilities)
- brew `moreutils` (Collection of tools that nobody wrote when UNIX was young)
- brew `findutils` (Collection of GNU find, xargs, and locate)
- brew `gnu-sed` (GNU implementation of the famous stream editor)
- Workspaces:
  - brew `yabai`
  - brew `skhd`
  - brew `sketchybar`
  - brew `terminal-notifier` (for yabai to create notifications)
- Ice (Menu bar)
- [mole](https://github.com/mole-app/mole) (The best MacOS cleaner)
- RayCast

### Pending
- BoringNotch (Dyanmic Island App)
- Alcove (Dyanmic Island App)

### No longer use
- Alfred (Better Spotlight)
- PasteNow
- Karabiner
- QSpace
- DropZone 4
- SetApp
  - CleanShotX (Screen shot and OCR)

### Shortcuts & Hotkeys

- **System settings**
  - Disable Caps Lock action.
  - Control → Command.
  - Command → Control.
- **Desktop & navigation**
  - Disable all.
  - Mission Control: Command-Up
  - Change Input Source: Control-Space

### Karabiner

- Disable quit app: Command-Q
- Hyper key: Control-Shift-Command-Option.

### Clipboard

- **PasteNow**: Command-Shift-V

### sketchybar

- Install **lua**
- Install this: 
  - Clone https://github.com/FelixKratz/SbarLua.git to a temporary directory.
  - Compile and install using make install.
  - This typically installs sketchybar.so to ~/.local/share/sketchybar_lua/.

### Workspaces (yabai & skhd)

**Modifier Key**: `Alt` (Option)

| Action | Shortcut |
| :--- | :--- |
| **Focus Window** | `Alt` + `a` (Left), `d` (Right), `w` (Up), `s` (Down) |
| **Move Window** | `Shift` + `Alt` + `a` / `d` / `w` / `s` |
| **Switch Space** | `Alt` + `0`-`9` |
| **Move to Space** | `Shift` + `Alt` + `0`-`9` |
| **Layouts** | `Alt` + `/` (BSP), `,` (Stack), `.` (Float) |
| **Float/Stack** | `Shift` + `Alt` + `Space` (Toggle Float) |
| **Restart Services**| `Cmd` + `Alt` + `r` (skhd), `y` (yabai), `u` (SketchyBar) |

### Custom Notifications

- **terminal-notifier**: Turn on Notification for terminal-notifier in Settings -> Notifications -> terminal-notifier -> Allow Notifications
