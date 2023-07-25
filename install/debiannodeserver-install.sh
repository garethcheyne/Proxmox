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

msg_info "Setting up Node.js Repository"
curl -sSL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
bash nodesource_setup.sh
update_os
msg_ok "Set up Node.js Repository"
msg_ok node -v

msg_info "Installing Node.js"
$STD apt-get install -y nodejs 
$STD apt-get install -y make 
$STD apt-get install -y g++ 
$STD apt-get install -y gcc 
msg_ok "Installed Node.js"

msg_info "Installing Yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &>/dev/null
$STD apt-get update 
$STD apt-get install -y yarn
$STD msg_ok "Installed Yarn"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get autoremove
$STD apt-get autoclean
msg_ok "Cleaned"
