# dotfiles

Dotfiles for some tools that I use.
Create symlinks into relevant paths so that the config files are accessible at expected paths, e.g. `~/.zshrc` for zsh startup file.

This repository is mostly here for my personal convenience, but feel free to borrow/steal whatever you find useful.

**WARNING**: Do not blindly copy or execute the contents of this repo if you do not fully understand what they're doing.

## Clean setup

```bash
# Simple apt installs
sudo apt update
sudo apt install -y zsh
sudo apt install -y tmux
# Alternative for tmux
# Link to Appimage binaries are available here:
# https://github.com/tmux/tmux/wiki/Installing
sudo apt install -y emacs
# tldr
sudo apt install tldr

################
# Clone dotfiles
################
# Probably want to generate ssh key and add to github
git clone git@github.com:yhshin11/dotfiles.git
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/.gitignore_global ~/.gitignore_global

################
# zsh setup
################
# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# Main zshrc file - Calls other zshrc files
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
# Shell functions
ln -s ~/dotfiles/zsh/.zfunc ~/.zfunc
# Change default shell
chsh -s $(which zsh)

# miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
# IMPORTANT: Restart shell after conda installation

# make and other build utils
sudo apt-get install build-essential

# [Optional] Install keychain to manage ssh-keys
sudo apt install keychain
# [Optional] tldr hints for linux commands, e.g. `tldr apt`
sudo apt install tldr
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

################
# Python poetry
################
curl -sSL https://install.python-poetry.org | python3 -
```

```bash
################
# pandoc
################
sudo apt install pandoc
sudo apt-get install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra

################
# jekyll and theme
################
# Installation instructions:
# https://jekyllrb.com/docs/installation/ubuntu/
# Prerequisites
sudo apt-get install ruby-full build-essential zlib1g-dev
# Install jekyll and bundler
gem install jekyll bundler
```

```bash
################
# Common pip packages
################
pip install pandas
pip install seaborn
pip install sklearn
pip install jupyterlab
pip install jupytext
pip install jupyterlab-vim
pip install tensorboard

################
# DL packages
################
pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
pip install pytorch-lightning
  
```


## Personal customizations

The following are very specific customizations according to my personal preferences and devices. **Do NOT blindly copy!**

Installation instructions have been omitted. Refer to official instructions.

```bash

# [Optional] Regolith
mkdir -p $XDG_CONFIG_HOME/regolith2
ln -s ~/dotfiles/regolith2/Xresources $XDG_CONFIG_HOME/regolith2/Xresources

# kmonad setup
ln -s ~/dotfiles/kmonad $XDG_CONFIG_HOME
```

## Testing

```bash
# polybar config
ln -s ~/dotfiles/polybar $XDG_CONFIG_HOME

# keyd setup 
sudo ln -s ~/dotfiles/keyd/default.conf /etc/keyd
```