# Source common zsh settings
# source $HOME/dotfiles/zsh/common.zshrc

# For WSL
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL

# wsl browser
export BROWSER='/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe'
