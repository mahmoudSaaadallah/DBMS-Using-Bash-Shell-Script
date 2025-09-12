#!/bin/bash

#ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "\n${GREEN}Avaliable Databases: ${NC}"
ls -1 ./DataBases 2>/dev/null || echo -e "${RED}No databases found.${NC}"

while true; do
	echo ""
	read -p "Enter then name of the DataBase to be dropped: " DBN

	if [ -z "$DBN" ]; then
		echo -e "${RED}The name of the DataBase Cannot be empty!${NC}"
		continue
	else
		if [ -d "./DataBases/$DBN" ]; then
			read -p "Are you sure you want to drop '$DBN'? (y/n): " confirm
			if [[ $confirm == [Yy] ]]; then
				sudo rm -r "./DataBases/$DBN"
				echo -e "${GREEN}The '$DBN' Database has been dropped.${NC}"
				break
			else
				echo -e "${RED}Cancelled.${NC}"
				break
			fi
		else
			echo -e "${RED} The '$DBN' Database not exist.${NC}"
			continue
		fi
	fi
done
