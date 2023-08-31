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
$STD mkdir -p /etc/apt/keyrings/
$STD bash <(curl -fsSL https://archive.heckel.io/apt/pubkey.txt) | sudo gpg --dearmor -o /etc/apt/keyrings/archive.heckel.io.gpg
$STD apt install apt-transport-https
$STD sh -c "echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/archive.heckel.io.gpg] https://archive.heckel.io/apt debian main' \
    > /etc/apt/sources.list.d/archive.heckel.io.list"
$STD apt-get update
$STD apt-get install -y ntfy
$STD systemctl enable ntfy
$STD systemctl start ntfy
msg_ok "Installed Dependencies"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get autoremove
$STD apt-get autoclean
msg_ok "Cleaned"
