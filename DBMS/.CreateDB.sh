#!/bin/bash

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

while true; do
    read -p "Enter the name of the new Database (letters, numbers, underscores only): " DBName
    

    if [ -z "$DBName" ]; then
        echo -e "${RED}Database Name cannot be empty.${NC}"
        continue
    fi


    if [[ ! "$DBName" =~ ^[A-Za-z0-9_]+$ ]]; then
        echo -e "${RED}Invalid name. Use only letters, numbers, and underscores.${NC}"
        continue
    fi

    if [ -d ./DataBases/$DBName ]; then
        echo ""
        echo -e "${RED}This DataBase already exists.${NC}"
        echo "Try another name or connect to $DBName Database"
        echo ""
        echo "1. Connect to $DBName Database."
        echo "2. Create new Database."
        echo "0. Exit."
        read -p "> " NDB
        
        case $NDB in
            1) ./.ConnectDB.sh ./DataBases/"$DBName" ; break ;;
            2) continue ;;
            0) echo -e "${GREEN}Goodbye!${NC}" ; break ;;
            *) echo -e "${RED}You have entered an invalid choice!${NC}" ;;
        esac
    else
        mkdir "./DataBases/$DBName"
        echo ""
        echo -e "${GREEN}The $DBName Database has been created.${NC}"
        ./.ConnectDB.sh ./DataBases/"$DBName"
        break
    fi
done
