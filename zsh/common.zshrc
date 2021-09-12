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
