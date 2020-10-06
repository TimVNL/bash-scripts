#!/bin/bash
# A shell script to cleanup DirectAdmin's custombuild folder
# Written by: TimVNL
echo "Cleaning DirectAdmin's custombuild folder"
cd /usr/local/directadmin/custombuild
./build clean
rm -fv /usr/local/directadmin/custombuild/*.tar.gz
rm -fv /usr/local/directadmin/custombuild/*.tgz
rm -fv /usr/local/directadmin/custombuild/*.bz2
rm -fv /usr/local/directadmin/custombuild/mysql/*
rm -fv /usr/local/directadmin/custombuild/mysql_backups/*
