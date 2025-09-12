#!/bin/bash

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m' 
NC='\033[0m'

if [ ! -f ~/.dbms_pass ]; then
	echo -e "${RED}No password is set. Please run PasswordManager.sh and create one.${NC}"
	        exit 1
fi

read -sp "Enter admin password: " user_input
echo ""

hashed_input=$(echo -n "$user_input" | sha256sum | cut -d ' ' -f1)
stored_hash=$(< ~/.dbms_pass)

if [[ "$hashed_input" == "$stored_hash" ]]; then
    echo -e "${GREEN}Authenticated.${NC}"
    exit 0
else
    echo -e "${RED} Authentication Failed.${NC}"
    exit 1
fi


