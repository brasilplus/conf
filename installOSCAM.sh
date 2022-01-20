#!/bin/bash

         ######   ####   #####   #####    ###  ###
         ##  ##  ##     ##      ##   ##  ##  ##  ##
         ##  ##  #####  ##      #######  ##  ##  ##
         ##  ##     ##  ##      ##   ##  ##      ##
         ######  ####    #####  ##   ##  ##      ## R
################################################################
# Title:.......Automatic install/update OScam                  #
# Author:......Prilly                                          #
# Support:.....prilly@speedbox.me                              #
# Date:........15 Mars 2016                                    #
# Description:.Automaticaly install OScam with systemd support #
#              Updates OScam to latest or specific SVN version #
################################################################

# OScam source checkout url (no trailing slash)
svn_url="https://svn.streamboard.tv/oscam/trunk"
#svn_mirror_url="http://streamboard.tv/svn/oscam/trunk"

# Omnikey drivers /pcsc/ (Do not append .tar.gz) install_reader_fw())
fw_hid_86="ifdokccid_linux_i686-v4.2.8"
fw_hid_64="ifdokccid_linux_x86_64-v4.2.8"

# Paths (no trailing slash)
daemon_dir="/usr/local/bin"
conf_dir="/usr/local/etc"
sysd_dir="/etc/systemd/system"
log_dir="/var/log/oscam"
work_dir="/usr/src"
run_dir="$(dirname "$(readlink -f "install_functions")")"

# Include files
. ${run_dir}/install_functions

############################# MAIN #############################

DIALOG=${DIALOG:-`which dialog`}
if [ -z "${DIALOG}" ]; then
	echo "Please install dialog package and run the script again! (apt-get install dialog)" 1>&2
	exit 1
fi

exec 3>&1;
menu_var=$(dialog --title "OScam installer" --menu "
            ######...####...#####...#####....###..###
            ##..##..##.....##......##...##..##..##..##
            ##..##..#####..##......#######..##..##..##
            ##..##.....##..##......##...##..##......##
            ######..####....#####  ##...##..##......## R
------------------------------------------------------------------
..........Automatic Install/Update OScam CardServer script........
...........Install maximum 9 instances of OScam CardServer........
............http://svn.speedbox.me/svn/oscam-install..............

Please choose an option:" 24 70 6 2>&1 1>&3 \
1 "Install OScam instances" \
2 "Upgrade OScam instances" \
3 "Install HID Omnikey USB Firmware" \
4 "Exit");
exec 3>&-;

if [ ${menu_var} -eq 1 2>/dev/null ]; then
	run_install
	exit 0
elif [ ${menu_var} -eq 2 2>/dev/null ]; then
	run_update
	exit 0
elif [ ${menu_var} -eq 3 2>/dev/null ]; then
	install_reader_fw
	exit 0
fi

exit 0