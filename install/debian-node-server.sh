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
$STD apt-get install -y curl sudo git
msg_ok "Installed Dependencies"


msg_info "Setting up Node.js Repository"
curl -sL https://deb.nodesource.com/setup_18.x curl -o nodesource_setup.sh 
bash nodesource_setup.sh 
msg_ok "Set up Node.js Repository"
msg_ok node -v

msg_info "Installing Node.js"
update_os
$STD apt-get install -y nodejs make g++ gcc 
msg_ok "Installed Node.js"


# msg_info "Installing Yarn"
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &>/dev/null
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &>/dev/null
# apt-get update &>/dev/null
# apt-get install -y yarn &>/dev/null
# msg_ok "Installed Yarn"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get autoremove
$STD apt-get autoclean
msg_ok "Cleaned"
