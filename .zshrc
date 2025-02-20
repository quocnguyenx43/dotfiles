# User
export USER="quocnguyen"

# Bash-like paths
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Coursier
export PATH="$PATH:/home/$USER/.local/share/coursier/bin"

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

# Bind keys (Vim style)
bindkey -v

# zsh-auto-suggestions
bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

# Editor
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='/usr/bin/code'
else
    export EDITOR='/usr/bin/nvim'
fi

# Change user name nvim conf 
nvim_config_path=$(ls -d ~/dotfiles/.config/nvim/lua/*/ | head -n 1)
current_user=$(basename "$nvim_config_path")

if [ $current_user != $USER ]; then
    mv "$nvim_config_path" "$(dirname "$nvim_config_path")/$USER"
fi

# Personal

### fzf & fd
show_preview="
if [ -d {} ]; then
    eza --tree --all --level=1 --color=always {} | head -200
else
    batcat -n --color=always --line-range :500 {}
fi"
export FZF_DEFAULT_COMMAND="fdfind . --type file --exclude .git --no-ignore --ignore-case --hidden --follow"
export FZF_DEFAULT_OPTS="--height 70% --layout reverse --border --preview '$show_preview'" 
export FZF_CTRL_R_OPTS="--height 70% --preview 'echo {2..} | batcat --color=always -pl sh' --preview-window 'wrap,up,5'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type directory . $HOME"

### Custom source
ZSH_CUSTOM=
ZSH_ENV=~/.zshenv
ZSH_ALIAS=~/.zshalias

if [ -f ~/.zshenv ]; then
    source ~/.zshenv
fi

if [ -f ~/.zshalias ]; then
    source ~/.zshalias
fi

