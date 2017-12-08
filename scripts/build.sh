#!/bin/bash

# Shell provisioner
MODULE_PATH='/vagrant/scripts/modules'
CONFIG_PATH='/vagrant/scripts/config'

# IP for the vagrant VM
GUEST_IP='10.0.0.200'

#Config
APP_DOMAIN='symfony.vbox'
APP_DBNAME='symfony'

# Adding an entry here executes the corresponding .sh file in MODULE_PATH
DEPENDENCIES=(
    ubuntu
    php71
    mysql
    nginx
    node
    gulp
    yarn
)

for MODULE in ${DEPENDENCIES[@]}; do
    source ${MODULE_PATH}/${MODULE}.sh
done
