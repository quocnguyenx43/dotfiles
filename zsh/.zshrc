PC_TYPE_FILE="$HOME/.zsh_pc_type"
OS_FILE="$HOME/.zsh_os"
OS_VERSION_FILE="$HOME/.zsh_os_version"
ARCH_FILE="$HOME/.zsh_arch"
PRIMARY_MONITOR_FILE="$HOME/.zsh_primary_monitor"
SECONDARY_MONITOR_FILE="$HOME/.zsh_secondary_monitor"
PRIMARY_MONITOR_ON_RIGHT_FILE="$HOME/.zsh_primary_monitor_on_right"

if [[ -f "$PC_TYPE_FILE" ]]; then
    PC_TYPE="$(cat "$PC_TYPE_FILE")"
fi

if [[ -f "$OS_FILE" ]]; then
    OS="$(cat "$OS_FILE")"
fi

if [[ -f "$OS_VERSION_FILE" ]]; then
    OS_VERSION="$(cat "$OS_VERSION_FILE")"
fi

if [[ -f "$ARCH_FILE" ]]; then
    ARCH="$(cat "$ARCH_FILE")"
fi

if [[ -f "$PRIMARY_MONITOR_FILE" ]]; then
    PRIMARY_MONITOR="$(cat "$PRIMARY_MONITOR_FILE")"
fi

if [[ -f "$SECONDARY_MONITOR_FILE" ]]; then
    SECONDARY_MONITOR="$(cat "$SECONDARY_MONITOR_FILE")"
fi

if [[ -f "$SECONDARY_MONITOR_FILE" ]]; then
    SECONDARY_MONITOR="$(cat "$SECONDARY_MONITOR_FILE")"
fi

if [[ -f "$PRIMARY_MONITOR_ON_RIGHT_FILE" ]]; then
    PRIMARY_MONITOR_ON_RIGHT="$(cat "$PRIMARY_MONITOR_ON_RIGHT_FILE")"
fi

export PC_TYPE
export OS
export OS_VERSION
export ARCH
export PRIMARY_MONITOR
export SECONDARY_MONITOR
export PRIMARY_MONITOR_ON_RIGHT

# Colors
export TERM="tmux-256color"

# For ARM macOS
if [[ "$OS" == "macos" && "$ARCH" == "arm64" ]]; then
    # Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Paths
    export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/python@3/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:$PATH

    # Editor
    export EDITOR="/opt/homebrew/bin/code"

# For AMD macOS
elif [[ "$OS" == "macos" && "$ARCH" == "amd64" ]]; then
    # Paths
    export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/.local/bin:/usr/bin:$PATH

    # Editor
    export EDITOR="/usr/local/bin/code"

# For Ubuntu
else
    # Paths
    export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:$PATH

    # Editor
    export EDITOR="/usr/bin/code"
fi

# ZSH
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="$EDITOR ~/.zshrc"

# Oh my ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
    ubuntu
    tmux
    tmuxinator
    git
    fzf
    sublime
    docker
    vscode
    uv
    mvn
    dbt
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-interactive-cd
)

zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

source $ZSH/oh-my-zsh.sh

# History settings
HISTFILE=$HOME/.cache/.zhistory
setopt inc_append_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Lang settings
export LANG=en_US.UTF-8

# Key bindings (Emacs style)
bindkey -e

## zsh-auto-suggestions
bindkey '^I'    complete-word       # tab          | complete
bindkey '^[[Z'  autosuggest-accept  # shift + tab  | autosuggest

# Personal

## fzf & fd
eval "$(fzf --zsh)"

if [[ "$OS" == "macos" ]]; then
    BAT='bat'
else
    BAT='batcat'
fi

show_preview="
if [ -d {} ]; then
    eza --tree --all --level=1 --color=always {} | head -200
else
    $BAT -n --color=always --line-range :500 {}
fi"
export FZF_DEFAULT_COMMAND="fd . --type file --exclude .git --no-ignore --ignore-case --hidden --follow"
export FZF_DEFAULT_OPTS="--height 70% --layout reverse --border --preview '$show_preview'"
export FZF_CTRL_R_OPTS="--height 70% --preview 'echo {2..} | $BAT --color=always -pl sh' --preview-window 'wrap,up,5'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type directory . $HOME"

## Advanced custom FZF
export FZF_COMPLETION_TRIGGER='*'
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
export FZF_COMPLETION_DIR_OPTS='--walker dir,follow'

## For *
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)           fzf --preview 'eza --tree --all --level=1 --color=always {} | head -200'   "$@" ;;
        export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
        ssh)          fzf --preview 'dig {}'                   "$@" ;;
        *)            fzf --preview '$show_preview' "$@" ;;
    esac
}

_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

## Zoxide
eval "$(zoxide init zsh)"

# Custom source
ZSH_ENV="$HOME/.zshenv"
ZSH_ALIAS="$HOME/.zshalias"
ZSH_PROXY="$HOME/.zshproxy"
ZSH_FUNCTION="$HOME/.zshfunction"
ZSH_SESSION="$HOME/.zshsession"
ZSH_HELP="$HOME/.zshhelp"

if [ -f "$ZSH_ENV" ]; then
    source "$ZSH_ENV"
fi

if [ -f "$ZSH_ALIAS" ]; then
    source "$ZSH_ALIAS"
fi

if [ -f "$ZSH_FUNCTION" ]; then
    source "$ZSH_FUNCTION"
fi

if [[ "$PC_TYPE" == "WORK" ]]; then
    if [ -f "$ZSH_PROXY" ]; then
        source "$ZSH_PROXY"
    fi
fi

if [ -f "$ZSH_SESSION" ]; then
    source "$ZSH_SESSION"
fi

if [ -f "$ZSH_HELP" ]; then
    source "$ZSH_HELP"
fi
