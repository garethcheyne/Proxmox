#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/garethcheyne/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2023 tteck
# Author: tteck (tteckster), Gareth Cheyne (garethcheyne)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

# Install Command.
# bash -c "$(wget -qLO - https://github.com/garethcheyne/Proxmox/raw/main/ct/debian-node.sh)"

function header_info {
clear
cat <<"EOF"
    ____       __    _               _   __          __
   / __ \___  / /_  (_)___ _____    / | / /___  ____/ /__
  / / / / _ \/ __ \/ / __ `/ __ \  /  |/ / __ \/ __  / _ \
 / /_/ /  __/ /_/ / / /_/ / / / / / /|  / /_/ / /_/ /  __/
/_____/\___/_.___/_/\__,_/_/ /_/ /_/ |_/\____/\__,_/\___/.js

EOF
}
header_info
echo -e "Loading..."
APP="Debian Node Server"
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

function error_exit() {
    trap - ERR
    local reason="Unknown failure occured."
    local msg="${1:-$reason}"
    local flag="${RD}‼ ERROR ${CL}$EXIT@$LINE"
    echo -e "$flag $msg" 1>&2
    exit $EXIT
}

function update_script() {
    header_info
    msg_info "Updating ${APP} LXC"
    apt-get update &>/dev/null
    apt-get -y upgrade &>/dev/null
    msg_ok "Updated ${APP} LXC"
    exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
