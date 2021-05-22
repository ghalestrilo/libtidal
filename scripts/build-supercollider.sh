#!/bin/bash

cd ~/git/dots # or cd into the directory where you'd like to clone and build supercollider
# git clone --recurse-submodules https://github.com/supercollider/supercollider.git
# cd supercollider
# mkdir build && cd build

sudo apt-get install -y jackd2

sudo apt-get install -y \
    libsamplerate0-dev \
    libsndfile1-dev \
    libasound2-dev \
    libavahi-client-dev \
    libreadline-dev \
    libfftw3-dev \
    libudev-dev \
    libncurses5-dev \
    cmake \
    git \

# bash scripts/build-jack.sh

buildfolder='build/supercollider'
[ ! -d 'build' ] && mkdir "build"
[ ! -d $buildfolder ] && git clone --recurse-submodules http://github.com/supercollider/supercollider $buildfolder
[ ! -d "$buildfolder/build" ] && mkdir "$buildfolder/build"
cd "$buildfolder/build"

# Build
cmake -DCMAKE_BUILD_TYPE=Release \
  -DSUPERNOVA=OFF \
  -DSC_ED=OFF \
  -DSC_EL=OFF \
  -DSC_VIM=ON \
  -DNATIVE=ON \
  -DNO_X11=ON \
  -DSC_QT=OFF \
  -DSC_USE_QTWEBENGINE:BOOL=OFF \
  ..

echo 'Done with first cmake'
cmake --build . --config Release --target all -- -j3 # use -j3 flag only on RPi3 or newer
sudo cmake --build . --config Release --target install
sudo ldconfig

if ! grep '/usr/local/bin/jackd' ~/.jackdrc > /dev/null; then
  echo '/usr/local/bin/jackd -P75 -p16 -dalsa -dhw:0 -r44100 -p1024 -n3' > ~/.jackdrc
fi


# cat > ~/autostart.sh <<EOF
#!/bin/bash
# export PATH=/usr/local/bin:$PATH
# export DISPLAY=:0.0
# sleep 10 # can be lower (5) for rpi3
# sclang mycode.scd

# chmod +x ~/autostart.sh
# crontab -e # and add the following line to the end:
#     @reboot cd /home/pi && ./autostart.sh

# nano ~/mycode.scd # And add your code inside a waitForBoot. For example:
#     s.waitForBoot{ {SinOsc.ar([400, 404])}.play }

# sudo reboot # the sound should start after a few seconds
