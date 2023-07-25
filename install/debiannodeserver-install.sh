#!/usr/bin/env bash

# Copyright (c) 2021-2023 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y curl
$STD apt-get install -y sudo
$STD apt-get install -y git
msg_ok "Installed Dependencies"

msg_info "Setting up Node v18.x Repository"
curl -sSL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
bash nodesource_setup.sh
$STD apt-get update 

msg_info "Installing Node v18.x"
$STD apt-get install -y nodejs 
$STD apt-get install -y make 
$STD apt-get install -y g++ 
$STD apt-get install -y gcc 

msg_info "Installing Yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &>/dev/null
$STD apt-get update 
$STD apt-get install -y yarn

clear
while true; do
    read -p "Do you want to install WebAdmin?(y/n)?" yn
    case $yn in
    [Yy]*) bash -c "$(wget -qLO - https://raw.githubusercontent.com/tteck/Proxmox/main/misc/webmin.sh)" ;;
    [Nn]*) exit ;;
    *) echo "Please answer yes or no." ;;
    esac
done


motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get autoremove
$STD apt-get autoclean
msg_ok "Cleaned"
