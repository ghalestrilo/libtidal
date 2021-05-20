#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

# if [ ! -d ~/.linuxbrew/Homebrew ]; then
  # sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  # git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
  # mkdir ~/.linuxbrew/bin
  # ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
# fi


# eval $(~/.linuxbrew/bin/brew shellenv)
#test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
#test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
#echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile


