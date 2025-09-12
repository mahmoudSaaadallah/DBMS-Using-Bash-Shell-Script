#!/bin/bash

# ANSI Color
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

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
			echo -e "${GREEN}Good By"
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
