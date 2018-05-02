#!/bin/bash
#set needed variablles
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

echo "
setup dynamic motd (ubuntu like)
===============================================
Version:      20180502-1
Maintainer:   TimVNL
Licence:      Open Source (MIT)
SCRIPT_PATH:  $SCRIPT_PATH
===============================================

"
echo "installing lsb-release and update-notifier-common"
apt install -y lsb-release update-notifier-common
echo
echo "creating /etc/update-motd.d follder"
mkdir -p /etc/update-motd.d/
rm -rf /etc/motd
echo
echo "copy necessary files to /etc/update-motd folder"
cp $SCRIPT_PATH/00-header /etc/update-motd.d/00-header
cp $SCRIPT_PATH/10-sysinfo /etc/update-motd.d/10-sysinfo
cp $SCRIPT_PATH/90-footer /etc/update-motd.d/90-footer
echo
echo "making sure all rights are set correctly"
chmod +x /etc/update-motd.d/*
echo
echo "DONE :)"
