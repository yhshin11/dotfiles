# dotfiles

Dotfiles for some tools that I use.
Create symlinks into relevant paths.

## Clean setup

```bash
# Simple apt installs
sudo apt update
sudo apt install -y zsh
sudo apt install -y tmux
sudo apt install -y emacs

################
# Clone dotfiles
################
# Probably want to generate ssh key and add to github
git clone git@github.com:yhshin11/dotfiles.git

################
# zsh setup
################
# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# Main zshrc file - Calls other zshrc files
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
# Change default shell
chsh -s $(which zsh)

# miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
# IMPORTANT: Restart shell after conda installation

# make and other build utils
sudo apt-get install build-essential
```

```bash
################
# virtualenvwrapper
################
pip install --user virtualenvwrapper

################
# Make XDG directories if they don't exist
################
mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_CACHE_HOME

################
# tmux config
################
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
# ln -s ~/dotfiles/tmux $XDG_CONFIG_HOME/tmux # Doesn't work for <3.1
ln -s ~/dotfiles/tmux/.tmux.conf.local ~/.tmux.conf.local

################
# CLI utilities 
################
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
# tldr
pip install tldr
# fasd
mkdir /tmp/fasd
cd /tmp/fasd
wget https://github.com/clvv/fasd/tarball/1.0.1 -O fasd.tar.gz
tar zxvf fasd.tar.gz
cd clvv-fasd-4822024
PREFIX=$HOME/.local make install
cd -

################
# vim/nvim
################
ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/dotfiles/nvim/.config/nvim/ ~/.config/nvim
```

```bash
sudo apt install pandoc
sudo apt-get install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
```
