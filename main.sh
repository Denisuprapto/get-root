#!/bin/bash
# Script to create root user on linux
# Created by Denisuprapto
# ===========================================

# // check root
if [[ "${EUID}" -ne 0 ]]; then
		echo -e "ERROR! Please run this script as root user";
		exit 1
fi

# // Input
sleep 1
clear
echo "Welcome to Denisuprapto Script"
echo ""
read -p "Input New 'root' Password : " password

if [[ $password == "" ]]; then
  echo "ERROR! Please input password"
  exit 1
fi

# // Fixing space on password
password=$( echo $password | sed 's/ //g' | sed 's/"//g' );

# // Download SSHD Configuration File
wget -q -O /etc/ssh/sshd_config https://raw.githubusercontent.com/Denisuprapto/get-root/main/ssh.conf

# // Change Password
echo -e "$password\n$password" | passwd root > /dev/null 2>&1

# // Restarting ssh server
systemctl restart ssh > /dev/null 2>&1
systemctl restart sshd > /dev/null 2>&1

# // Done
clear
echo "Successfull Create root User on your server"
echo "================================================="
echo " Username : root"
echo " Password : $password"
echo "================================================="

rm -f main.sh
