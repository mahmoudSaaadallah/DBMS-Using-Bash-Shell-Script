#!/bin/bash

#ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'


while true; do

	read -p "Enter the name of the new Database as one word like(EcommerceDataBase): " DBName
	
	if [ -z  "$DBName" ]; then
		echo "Database Name cannot be empty."
		continue
	fi


	if [ -d ./DataBases/$DBName ]; then
		echo ""
		echo -e "${RED}This DataBase already exist.${NC}"
		echo "Try another name or Connect to $DBName Database"
		echo ""
		echo "1. Connect to $DBName Database."
		echo "2. Create new Database."
		echo "0. Exit."
		read -p "> " NDB
		
		case $NDB in
			1)
			       	./.ConnectDB.sh ./DataBases/"$DBName"
			 	break 
				;;
			2) continue ;;
			0)
			       echo -e "${GREEN}GoodBye!"
		       	       break
			       ;;
			*) echo -e "${RED}You have entered an invalid choice!${NC}" ;;
		esac
	else
		mkdir "./DataBases/$DBName"
		echo ""
		echo -e "${GREEN}The $DBName DataBase has been created."
		./.ConnectDB.sh ./DataBases/"$DBName"
		break
	fi
done

