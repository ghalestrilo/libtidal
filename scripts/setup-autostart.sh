#!/bin/bash

ln -s '~/autostart.sh' 'common/pi/autostart.sh'

if ! sudo ls /var/spool/cron/crontabs/pi; then
  sudo touch /var/spool/cron/crontabs/pi
fi

if ! sudo cat /var/spool/cron/crontabs/pi | grep autostart; 
  then sudo echo '@reboot cd /home/pi && ./autostart.sh' >> /var/spool/cron/crontabs/pi;
fi