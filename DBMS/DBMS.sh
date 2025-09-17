#!/bin/bash

# ANSI Color
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Ensure DataBases directory exists
[[ ! -d ./DataBases ]] && mkdir ./DataBases

# Check if authentication script exists
if [[ ! -f ./.authPassword.sh ]]; then

    echo -e "${RED}Authentication script (.authPassword.sh) not found!${NC}"
    exit 1
fi

# Run authentication
./.authPassword.sh || exit 1

echo "Hello, and welcome to DBMS CLI App!"

while true; do
    echo "Choose from the list below: "
    echo "1. Create Database." 
    echo "2. List Databases."
    echo "3. Connect to Database."
    echo "4. Drop Database." 
    echo "0. Quit." 
    read -p "> " choose

    case $choose in 
        1) ./.CreateDB.sh ;;
        2) ./.ListDBs.sh ;;
        3) ./.ConnectDB.sh ;;
        4) ./.DropDB.sh ;;
        0)
            echo -e "${GREEN}Goodbye${NC}"
            exit ;;
        *) 
            echo ""
            echo "*****************************"
            echo -e "${RED}You entered an invalid choice!${NC}"
            echo "*****************************"
            echo ""
            ;;
    esac
done
