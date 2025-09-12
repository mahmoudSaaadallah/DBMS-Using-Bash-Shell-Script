#!/bin/bash

#ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

WDB="$1"

while true; do
	read -p "Enter the name of the table: " tableName
	
	if [ -z "$tableName" ]; then
		echo -e "${RED}The name of table can't be empty!${NC}"
		continue
	fi

	if [ -e "./$WDB/$tableName" ] && [ ! -d "./$WDB/$tableName" ]; then
		read -p "Are you sure you want to delete the table '$tableName'? (y/n): " confirm

		if [[ $confirm == [Yy] ]]; then
			rm -r "./$WDB/$tableName"
			echo -e "\n${GREEN}$tableName table has been removed.${NC}"
		else
			echo -e "${YELLOW}! Cancelled.${NC}"
		fi
		break
	else
		echo -e "${RED}The $tableName table doesn't exist.${NC}"
		continue
	fi
done



