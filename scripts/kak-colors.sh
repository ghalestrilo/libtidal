#!/bin/bash

colordir="~/.config/kak/colors"

if [ ! -d colordir ]; then
	mkdir $colordir
  wget https://raw.githubusercontent.com/dracula/kakoune/master/colors/dracula.kak -O ~/.config/kak/colors/dracula.kak
  wget https://raw.githubusercontent.com/dracula/kakoune/master/colors/dracula-transparent.kak -O ~/.config/kak/colors/dracula-transparent.kak
fi
