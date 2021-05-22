#!/bin/bash

if ! command -v curl; then sudo apt install -y curl; fi;

if [ ! -f get-pip.py ]; then
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
fi

if ! command -v pip; then
  sudo apt install -y python3-distutils python3-pip;
  sudo apt install 
  # python3 get-pip.py;
fi

export PATH=$HOME/.local/bin:$PATH;
alias pip=pip3

if [ ! $(python3 -c "from bullet import Bullet") > /dev/null ]; then
  pip install bullet;
fi

if ! command -v dotbot; then pip install dotbot; fi

make config