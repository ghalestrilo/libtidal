#!/bin/bash

buildfolder='build/supercollider'
[ ! -d $buildfolder ] && git clone http://github.com/supercollider/supercollider $buildfolder

cd $buildfolder

cmake -L -DCMAKE_BUILD_TYPE=Release \
  -DNATIVE=1 \
  -DSSE=0 \
  -DSSE2=0 \
  -DENABLE_TESTSUITE=0 \
  -DCMAKE_SKIP_RPATH=1 \
  -DLIBSCSYNTH=0 \
  -DSUPERNOVA=0 \
  -DSC_WII=0 \
  -DSC_IDE=0 \
  -DSC_QT=0 \
  -DSC_ED=0 \
  -DSC_EL=0 \
  -DSC_VIM=1 \
  ..

make
