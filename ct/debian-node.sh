#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2023 tteck
# Author: tteck (tteckster), Gareth Cheyne (garethcheyne)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    ____       __    _               _   __          __
   / __ \___  / /_  (_)___ _____    / | / /___  ____/ /__
  / / / / _ \/ __ \/ / __ `/ __ \  /  |/ / __ \/ __  / _ \
 / /_/ /  __/ /_/ / / /_/ / / / / / /|  / /_/ / /_/ /  __/
/_____/\___/_.___/_/\__,_/_/ /_/ /_/ |_/\____/\__,_/\___/

EOF
}
header_info
echo -e "Loading..."
APP="DebianNode"
var_disk="4"
var_cpu="1"
var_ram="1024"
var_os="debian"
var_version="11"
variables
color
catch_errors

function default_settings() {
    CT_TYPE="1"
    PW=""
    CT_ID=$NEXTID
    HN=$NSAPP
    DISK_SIZE="$var_disk"
    CORE_COUNT="$var_cpu"
    RAM_SIZE="$var_ram"
    BRG="vmbr0"
    NET="dhcp"
    GATE=""
    DISABLEIP6="yes"
    MTU=""
    SD=""
    NS=""
    MAC=""
    VLAN=""
    SSH="yes"
    VERB="no"
    echo_default
}






#!/usr/bin/env bash

# Copyright (c) 2021-2023 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

# Install Command.
# bash -c "$(wget -qLO - https://raw.githubusercontent.com/garethcheyne/Proxmox/raw/main/install/debian-node.sh)"

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

# msg_info "Installing Dependencies"
# $STD apt-get install -y curl
# $STD apt-get install -y sudo
# $STD apt-get install -y mc
# $STD apt-get install -y git
# msg_ok "Installed Dependencies"

# msg_info "Setting up Node.js Repository"
# $STD bash <(curl -fsSL https://deb.nodesource.com/setup_18.x)
# msg_ok "Set up Node.js Repository"

# msg_info "Installing Node.js"
# $STD apt-get install -y nodejs git make g++ gcc
# $STD npm install -g pnpm
# msg_ok "Installed Node.js"
# latest

# msg_info "Installing Yarn"
# $STD bash <(curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -)
# $STD echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# $STD apt-get update && sudo apt-get install yarn
# msg_ok "Installed Yarn"

# msg_info "Installing Strapi.io"
# mkdir /opt/err403
# cd /opt/err403
# $STD yarn create strapi-app err403-strapi --quickstart --ts 
# msg_ok "Installed Strapi.io"



# msg_info "Installing Homepage (Patience)"
# cd /opt
# $STD git clone https://github.com/benphelps/homepage.git
# cd /opt/homepage
# mkdir -p config
# cp /opt/homepage/src/skeleton/* /opt/homepage/config
# $STD pnpm install
# $STD pnpm build
# msg_ok "Installed Homepage"

# msg_info "Creating Service"
# service_path="/etc/systemd/system/homepage.service"
# echo "[Unit]
# Description=Homepage
# After=network.target
# StartLimitIntervalSec=0
# [Service]
# Type=simple
# Restart=always
# RestartSec=1
# User=root
# WorkingDirectory=/opt/homepage/
# ExecStart=pnpm start
# [Install]
# WantedBy=multi-user.target" >$service_path
# $STD systemctl enable --now homepage
# msg_ok "Created Service"

# motd_ssh
# customize

# msg_info "Cleaning up"
# $STD apt-get autoremove
# $STD apt-get autoclean
# msg_ok "Cleaned"

