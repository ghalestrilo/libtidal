#!/bin/bash

buildfolder='build/amidiauto'
[ ! -d 'build' ] && mkdir "build"
[ ! -d $buildfolder ] && git clone https://github.com/BlokasLabs/amidiauto $buildfolder
[ ! -d "$buildfolder/build" ] && mkdir "$buildfolder/build"
cd "$buildfolder"

make
sudo make install
