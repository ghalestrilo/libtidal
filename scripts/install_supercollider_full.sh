#!/bin/bash

cd ~/dots # or cd into the directory where you'd like to clone and build supercollider
# git clone --recurse-submodules https://github.com/supercollider/supercollider.git
# cd supercollider
# mkdir build && cd build

bash scripts/build_jack.sh 

buildfolder='build/supercollider'
[ ! -d $buildfolder ] && git clone --recurse-submodules http://github.com/supercollider/supercollider $buildfolder

cd $buildfolder

[ ! -d build ] && mkdir build

# For a GUI build:
cmake -DCMAKE_BUILD_TYPE=Release \
    -DSUPERNOVA=OFF \
    -DSC_ED=OFF \
    -DSC_EL=OFF \
    -DSC_VIM=ON \
    -DNATIVE=ON \
    -DSC_USE_QTWEBENGINE:BOOL=OFF ..

cmake --build . --config Release --target all -- -j3 # use -j3 flag only on RPi3 or newer
sudo cmake --build . --config Release --target install
sudo ldconfig

echo /usr/local/bin/jackd -P75 -p16 -dalsa -dhw:0 -r44100 -p1024 -n3 &gt; ~/.jackdrc



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
