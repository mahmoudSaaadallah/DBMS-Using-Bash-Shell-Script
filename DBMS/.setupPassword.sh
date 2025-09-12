#!/bin/bash

# ANSI Color Codes 
RED='\033[0;31m'
GREEN='\033[0;32m' 
YELLOW='\033[1;33m' 
NC='\033[0m'


read -sp "Enter new admin password: " pass1
echo ""
read -sp "Confirm password: " pass2
echo ""

if [[ "$pass1" != "$pass2" ]]; then
    echo -e "${RED}\n Passwords do not match.${NC}"
    exit 1
fi

echo -n "$pass1" | sha256sum | cut -d ' ' -f1 > ~/.dbms_pass
chmod 600 ~/.dbms_pass
echo -e "${GREEN}\nNew Password has been created and stored.${NC}"

