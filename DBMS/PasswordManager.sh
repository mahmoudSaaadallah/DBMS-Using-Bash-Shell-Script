#!/bin/bash

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

createPassword() {
    if [ -f ~/.dbms_pass ]; then
        echo -e "${RED}Password already exists."
        echo -e "${YELLOW}Use option 2 to change it.${NC}"
        return
    fi
    ./.setupPassword.sh
}

changePassword() {
    echo -e "\nAuthentication required to change password."
    ./.authPassword.sh
    if [ $? -ne 0 ]; then
        return
    fi
    rm ~/.dbms_pass
    ./.setupPassword.sh
}

while true; do
    echo -e "\n${GREEN}Password Manager Menu:${NC}"
    echo "1. Create Password"
    echo "2. Change Password"
    echo "0. Exit"
    read -p ":> " choice

    case $choice in
        1) createPassword ;;
        2) changePassword ;;
        0) exit ;;
        *) echo -e "${RED} Invalid option.${NC}" ;;
    esac
done

