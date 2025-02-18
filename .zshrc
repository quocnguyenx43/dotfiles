# Bash-like paths
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# ZSH
alias reload-zsh='source ~/.zshrc'
alias reload-zsh='nvim ~/.zshrc'

# Oh my ZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
    tmux
    tmuxinator
    git
    fzf
    sublime
    docker
)

source $ZSH/oh-my-zsh.sh

# History settings
HISTFILE=$HOME/.cache/.zhistory
setopt inc_append_history
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

export LANG=en_US.UTF-8

# zsh-auto-suggestions
bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

# Editor
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='/usr/bin/code'
else
    export EDITOR='/usr/bin/nvim'
fi

# Personal
### fzf & fd
SHOW_PREVIEW="
if [ -d {} ]; then
    eza --tree --all --level=2 --color=always {} | head -200
else
    batcat -n --color=always --line-range :500 {}
fi"
export FZF_DEFAULT_COMMAND="fdfind . $home --type file --exclude .git --no-ignore --ignore-case --hidden --follow"
export FZF_DEFAULT_OPTS="--height 100% --layout reverse --border --preview '$SHOW_PREVIEW'" 
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type directory . $HOME"

ZSH_CUSTOM=
ZSH_ENV=~/.zshenv
ZSH_ALIAS=~/.zshalias
ZSH_FUNCTION=~/.zshfn

if [ -f ~/.zshenv ]; then
    source ~/.zshenv
fi

if [ -f ~/.zshalias ]; then
    source ~/.zshalias
fi

if [ -f ~/.zshfn ]; then
    source ~/.zshfn
fi

if [ -f ~/.fzfrc ]; then
    source ~/.fzfrc
fi
