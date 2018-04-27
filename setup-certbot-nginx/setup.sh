#!/bin/bash
# Set needed variablles
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

echo "
setup certbot & (secure) nginx
===============================================
Version:      20180427-1
Maintainer:   TimVNL
Licence:      Open Source (MIT)
SCRIPT_PATH:  $SCRIPT_PATH
===============================================

"
echo "adding stretch-backports for latest nginx"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
echo 'deb http://ftp.debian.org/debian stretch-backports main' | tee -a /etc/apt/sources.list.d/stretch-backports.list
echo ""
echo "installing certbot nginx from debian-backports"
apt-get -y -t stretch-backports install python-certbot nginx
echo "making a backup of /etc/nginx/nginx.comf before continuing"
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.default
echo ""
echo "simplifying nginx folder structure"
mv /etc/nginx/modules-enabled/ /etc/nginx/modules/
rm -r /etc/nginx/modules-available/
# See: https://serverfault.com/questions/527630/what-is-the-different-usages-for-sites-available-vs-the-conf-d-directory-for-ngi
mv /etc/nginx/sites-available/default /etc/nginx/conf.d/default.conf
rm -r /etc/nginx/sites-available/ /etc/nginx/sites-enabled/
echo
echo "placing optimized and secure /etc/nginx/nginx.conf"
rm /etc/nginx/nginx.conf
cp $SCRIPT_PATH/nginx.conf /etc/nginx/nginx.conf
echo "placing ssl-params.conf"
cp $SCRIPT_PATH/ssl-params.conf /etc/nginx/snippets/ssl-params.conf
echo "placing optimized /etc/letsencrypt/cli.ini"
mv /etc/letsencrypt/cli.ini /etc/letsencrypt/cli.ini.default
mkdir -p /var/www/letsencrypt/
cp $SCRIPT_PATH/certbot-cli.ini /etc/letsencrypt/cli.ini
echo "certbot and nginx are installed and optimized :)"
