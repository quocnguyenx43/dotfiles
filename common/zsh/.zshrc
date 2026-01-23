# Colors
# export TERM="tmux-256color"

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
    extract
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

# Environments
ZSH_ENV="$HOME/.zshenv"
if [ -f "$ZSH_ENV" ]; then
    source "$ZSH_ENV"
fi

# Aliases
ZSH_ALIAS="$HOME/.zshalias"
if [ -f "$ZSH_ALIAS" ]; then
    source "$ZSH_ALIAS"
fi

# Custom scripts
SCRIPTS="$HOME/.scripts"
for script in "$SCRIPTS"/*; do
    if [ -f "$script" ]; then
        source "$script"
    fi
done

tmux new-session -d -s "default"
tmux new-session -d -s "projects"
tmux new-session -d -s "coding"
