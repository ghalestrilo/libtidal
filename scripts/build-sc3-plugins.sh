#!/bin/bash

buildfolder='build/sc3-plugins'
[ ! -d $buildfolder ] && git clone --recurse-submodules http://github.com/supercollider/sc3-plugins $buildfolder
[ ! -d "$buildfolder/build" ] && mkdir "$buildfolder/build"
cd "$buildfolder/build"

# for both scsynth and supernova plugins; omit -DSUPERNOVA=ON to build only scsynth plugins
cmake -DSC_PATH=/path/to/sc/ -DCMAKE_BUILD_TYPE=Release -DSUPERNOVA=ON ..
cmake --build . --config Release
# to install the plugins - note: linux users likely need sudo
cmake --build . --config Release --target install