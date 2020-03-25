#!/bin/bash

# Install unzip if you dont have it.
sudo apt install unzip -y

# Create an area for the font to download to
cd /tmp
mkdir hasklig
cd hasklig
wget https://github.com/i-tu/Hasklig/releases/download/1.1/Hasklig-1.1.zip
unzip Hasklig-1.1.zip
rm Hasklig-1.1.zip

# Install the font by moving the files to the correct place
cd /tmp
sudo mv hasklig /usr/share/fonts/opentype/.

# Re-cache the fonts
echo 'Re-caching fonts...'
sudo fc-cache -fv
