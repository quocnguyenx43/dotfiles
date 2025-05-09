# PC_TYPE: PERSONAL | WORK
PC_TYPE_FILE="$HOME/.zsh_pc_type"

if [[ -f "$PC_TYPE_FILE" ]]; then
    export PC_TYPE="$(cat "$PC_TYPE_FILE")"
else
    read "?Please enter your PC_TYPE (e.g., PERSONAL or WORK): " PC_TYPE
    echo "$PC_TYPE" > "$PC_TYPE_FILE"
    export PC_TYPE
fi

# Colors
export TERM="tmux-256color"

# Bash-like paths
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/bin:$PATH

# ZSH
alias reload-zsh='source ~/.zshrc'
alias edit-zsh='nvim ~/.zshrc'

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

# Editor
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='/usr/bin/code'
else
    export EDITOR='/usr/bin/nvim'
fi

# Personal

## fzf & fd
eval "$(fzf --zsh)"

if [[ "$(uname)" == "Linux" ]]; then
    BAT='batcat'
elif [[ "$(uname)" == "Darwin" ]]; then
    BAT='bat'
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
ZSH_HELP="$HOME/.zshhelp"

if [ -f "$ZSH_ENV" ]; then
    source "$ZSH_ENV"
fi

if [ -f "$ZSH_ALIAS" ]; then
    source "$ZSH_ALIAS"
fi

if [[ "$PC_TYPE" == "WORK" ]]; then
    if [ -f "$ZSH_PROXY" ]; then
        source "$ZSH_PROXY"
    fi
fi

if [ -f "$ZSH_FUNCTION" ]; then
    source "$ZSH_FUNCTION"
fi

if [ -f "$ZSH_HELP" ]; then
    source "$ZSH_HELP"
fi