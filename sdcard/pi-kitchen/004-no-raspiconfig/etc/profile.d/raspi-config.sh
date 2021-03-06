#!/bin/sh
# Part of raspi-config http://github.com/asb/raspi-config
#
# See LICENSE file for copyright and license details

# Should be installed to /etc/profile.d/raspi-config.sh to force raspi-config
# to run at initial login

# You may also want to set automatic login in /etc/inittab on tty1 by adding a
# line such as:
# 1:2345:respawn:/bin/login -f root tty1 </dev/tty1 >/dev/tty1 2>&1 # RPICFG_TO_DISABLE

#if [ $(id -u) -ne 0 ]; then
#  This case occurs if we are normal user (i.e. logged in via SSH)
#  printf "\nNOTICE: the software on this Raspberry Pi has not been fully configured. Please run 'sudo raspi-config'\n\n"
#else
#  This case occurs on power up, logged in as root.
#  #Modification for the Pi-Kitchen:
#  #This file has been edited to stop raspi-config being forced to run
#  #which isn't needed if we are using noobs-config to set everything up
#  #raspi-config would be run here
#  #exec login -f pi

if [ $(id -u) -eq 0 ]; then
    sed -i /etc/inittab \
      -e "s/^#\(.*\)#\s*RPICFG_TO_ENABLE\s*/\1/" \
      -e "/#\s*RPICFG_TO_DISABLE/d"
    telinit q #q tells init to re-example the /etc/inittab file
  exec login -f pi #log in as pi user (-f do not perform authentication)
  rm -f /etc/profile.d/raspi-config.sh
fi
TERM=xterm
