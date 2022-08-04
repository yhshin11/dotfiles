# Profiling zsh startup time
# https://stevenvanbael.com/profiling-zsh-startup
# zmodload zsh/zprof

### Customizations

# Enable history
# See: https://zsh.sourceforge.io/Doc/Release/Options.html#History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# XDG - set defaults as they may not be set
# See https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# and https://wiki.archlinux.org/title/XDG_Base_Directory#Support
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

if [ ! -w ${XDG_RUNTIME_DIR:="/run/user/$UID"} ]; then
  # echo "\$XDG_RUNTIME_DIR ($XDG_RUNTIME_DIR) not writable. Unsetting." >&2
  unset XDG_RUNTIME_DIR
else
  export XDG_RUNTIME_DIR
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -lh --color=auto'
    alias la='ls -latrh --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Enable bash-style comments with #
setopt interactivecomments

### Custom key binds
# Alt+Backspace to delete path element
# See:
# https://unix.stackexchange.com/questions/313806/zsh-make-altbackspace-stop-at-non-alphanumeric-characters
# https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/} # Remove \ from WORDCHARS
    zle backward-kill-word # Invoke backward-kill-word
    zle -f kill # Flag to indicate text has been killed
}
zle -N backward-kill-dir # Register backward-kill-dir as widget
bindkey '^[^?' backward-kill-dir

# menu-select widget
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

export EDITOR='vim'
bindkey -e # Keep emacs mode bindings in terminal

# Profiling - Needs to be at end of file
# zprof

################
# Start ssh-agent
################
# eval "$(ssh-agent -s)" > /dev/null
# Now you can do `ssh-add` to register ssh key to agent for current terminal session
# ssh-add
################


### Aliases
alias emstart='emacs --daemon &' # Start emacs server
alias emnew='emacsclient -c -a "" &' # Start emacs server and open frame
alias emkill="emacsclient --eval '(save-buffers-kill-emacs)'" # Kill emacs server
# alias em='emacsclient -n -a emacs' # Open file in existing frame
alias vim='nvim' # neovim
alias jl='jupyter lab'
alias jn='jupyter notebook'
alias cht='cht.sh'
alias tn='tmux new -s' # Open new tmux session
alias ta='tmux attach -t' # Attach to tmux session
alias tt='tmux attach -t' # FIXME: Create if doesn't exist. Otherwise attach
alias ts='tmux split-window -h' # Split current window and run command

em() {
    emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" | grep -q t
    if [ "$?" = "1" ]; then
        emacsclient -c -n -a "" "$@"
    else
        emacsclient -n -a "" "$@"
    fi
}

# Auto set terminal title
# https://superuser.com/a/633947
case $TERM in
    xterm*)
        # precmd () {print -Pn "\e]0;string\a"}
        # Replace $HOME with ~
        precmd () {print -Pn "\e]0;${PWD/$HOME/\~}\a"}
        ;;
esac


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
export PATH="/home/yhshin/.local/bin/:${PATH}"

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

# aws-cli command completion
# See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-linux
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C 'aws_completer' aws

# Ruby gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# keychain to manage ssh-agent
if [[ -f $HOME/.ssh/id_ed25519 ]]; then
    eval `keychain --eval --quiet --agents ssh id_ed25519`
fi
if [[ -f $HOME/.ssh/id_rsa ]]; then
fi
    eval `keychain --eval --quiet --agents ssh id_rsa`

