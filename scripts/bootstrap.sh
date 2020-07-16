#!/bin/bash
if ! command -v pip; then sudo apt install curl; fi

if [ ! -f get-pip.py ]; then
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
fi

if ! command -v pip; then python3 get-pip.py; fi

if [ ! $(python3 -c "from bullet import Bullet") ];
	then pip install bullet;
fi

if ! command -v dotbot; then pip install dotbot; fi
