#!/bin/bash
if ! command -v pip; then 
  if ! command -v curl; then sudo apt install curl -y; fi;
fi;

if [ ! -f get-pip.py ]; then
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
fi

if ! command -v pip; then
  sudo apt install python3-distutils -y;
  python3 get-pip.py;
fi

if [[ $(echo $PATH | grep "$HOME/.local/bin") ]];
then break;
else
  PATH=$HOME/.local/bin:$PATH;
fi;

if [ ! $(python3 -c "from bullet import Bullet") ];
	then pip install bullet;
fi

if ! command -v dotbot; then pip install dotbot; fi

