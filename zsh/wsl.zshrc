# Source common zsh settings
source $HOME/dotfiles/zsh/common.zshrc

### Aliases
alias emstart='emacs --daemon &' # Start emacs server
alias emnew='emacsclient -c -a "" &' # Start emacs server and open frame
alias emkill="emacsclient --eval '(save-buffers-kill-emacs)'" # Kill emacs server
# alias em='emacsclient -n -a emacs' # Open file in existing frame
alias vim='/home/yhshin/nvim.appimage' # neovim
alias jl='jupyter lab'
alias jn='jupyter notebook'
alias cht='cht.sh'
alias tn='tmux new -s' # Open new tmux session
alias ta='tmux attach -t' # Attach to tmux session
alias ts='tmux split-window -h' # Split current window and run command

em() {
    emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" | grep -q t
    if [ "$?" = "1" ]; then
        emacsclient -c -n -a "" "$@"
    else
        emacsclient -n -a "" "$@"
    fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/yhshin/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/yhshin/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/yhshin/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/yhshin/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

################################
# Environments
################################
# Activate base conda environment
conda activate base
# Activate virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source $HOME/.local/bin/virtualenvwrapper.sh

# Export pip packages
export PATH="${PATH}:/home/yhshin/.local/bin/"

# # navi
# export PATH="${PATH}:/home/yhshin/.cargo/bin/"
# eval "$(navi widget zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='ag'

# fasd
eval "$(fasd --init auto)"

# tmux
export TERM=xterm-256color
# alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# dotfiles & stow
export DOTFILES="$HOME/dotfiles"
# export STOW_DIR=$DOTFILES

# wsl browser
export BROWSER='/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe'

# aws-cli command completion
# See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-linux
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C 'aws_completer' aws

# Ruby gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
