#!/bin/bash

# Author: Javier Chavez

# provisions the ethereum vm

PG_VERSION=9.6
APP_NAME=appname

APP_DB_USER=username

APP_DB_NAME=appname_db
APP_DB_PASS=KSwpdKdiqowecaV


PROVISIONED_ON=/etc/vm_provision_on_timestamp
if [ -f "$PROVISIONED_ON" ]
then
  echo "VM was already provisioned at: $(cat $PROVISIONED_ON)"
  echo "To run system updates manually login via 'vagrant ssh' and run 'apt-get update && apt-get upgrade'"
  exit
fi

### Etherium ###
add-apt-repository -y ppa:deadsnakes/ppa
add-apt-repository -y ppa:ethereum/ethereum
### Etherium ###


apt-get -qq update


########################
#       Dev libs       #
########################
apt-get -qq install openssl libssl-dev automake build-essential git

### Etherium ###
apt-get -qq install software-properties-common
apt-get -qq install libssl-dev automake solc ethereum golang

apt-get -qq install libjpeg62-dev zlib1g-dev libfreetype6-dev liblcms1-dev libgmp-dev pkg-config libtool
### Etherium ###

########################
#       Python         #
########################
apt-get -qq install python3.6 python3.6-dev python3-pip python3-setuptools


########################
#          DB          #
########################
# cd /vagrant/scripts/
# ./db/postgres.sh "$PG_VERSION" "$APP_DB_USER" "$APP_DB_NAME" "$APP_DB_PASS"
# # DB Extentions
# ./db/postgis.sh "$APP_DB_NAME"
# cd ../../
# # postgres
# cp /vagrant/scripts/db/pg_hba.conf "/etc/postgresql/$PG_VERSION/main/"


apt-get -f install
apt-get -y autoremove
apt-get -y autoclean

########################
#        Python        #
########################
pip3 install -U pip
pip3 install virtualenv

# Create env but with user's creds
sudo su vagrant -c "mkdir /home/vagrant/venvs"
sudo su vagrant -c "virtualenv \"/home/vagrant/venvs/$APP_NAME\" --python=python3.6"

date > "$PROVISIONED_ON"

#cd /home/vagrant
#echo "Git Username:"
#read git_username

#echo "Git Password:"
#read -sr git_password

# install configuration files for bash, emacs, and vim
cd /vagrant/configs
./setup.sh
