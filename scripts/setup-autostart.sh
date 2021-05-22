#!/bin/bash

if ! sudo grep autostart /var/spool/cron/crontabs/pi;
  then sudo echo '@reboot cd /home/pi && ./autostart.sh' > /var/spool/cron/crontabs/pi;
fi