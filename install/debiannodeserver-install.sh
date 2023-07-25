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

install_webadmin() {
    echo -en "${GN} Installing Prerequisites... "
    apt update &>/dev/null
    apt-get -y install libnet-ssleay-perl libauthen-pam-perl libio-pty-perl unzip shared-mime-info &>/dev/null
    echo -e "${CM}${CL} \r"

    echo -en "${GN} Downloading Webmin... "
    wget http://prdownloads.sourceforge.net/webadmin/webmin_2.000_all.deb &>/dev/null
    echo -e "${CM}${CL} \r"

    echo -en "${GN} Installing Webmin... "
    dpkg --install webmin_2.000_all.deb &>/dev/null
    echo -e "${CM}${CL} \r"

    echo -en "${GN} Setting Default Webmin usermame & password to root... "
    /usr/share/webmin/changepass.pl /etc/webmin root root &>/dev/null
    rm -rf /root/webmin_2.000_all.deb
    echo -e "${CM}${CL} \r"
    IP=$(hostname -I | cut -f1 -d ' ')
    echo -e "Successfully Installed!! Webmin should be reachable by going to https://${IP}:10000"
}



clear

# Ask the user a yes/no question
read -p "Do you want to run the function? (yes/no): " answer

# Check the answer and run the function if it's 'yes'
if [[ "$answer" == "yes" ]]; then
    install_webadmin
else
    echo "Okay, the function will not be run."
fi


motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get autoremove
$STD apt-get autoclean
msg_ok "Cleaned"
