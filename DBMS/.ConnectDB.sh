#!/bin/bash

#ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

while true; do
	if [ $# == 0 ]; then
		read -p "Enter the name of the Database: " DBN
		if [ -z "$DBN" ]; then
			echo -e "${RED}The name of the Database cannot be empty!${NC}"
			continue
		fi
	else
		DBN=$(basename "$1")
		echo "$DBN"
	fi

	if [ -d "./DataBases/$DBN" ]; then
		echo -e "\n${GREEN}Connected to '$DBN' DataBase.${NC}"
		echo -e "${GREEN}------------------------------------------${NC}"

		while true; do
			echo -e "\n${GREEN}Select from the list below: ${NC}"
			echo "1. Create Table."	
			echo "2. List Tables."
			echo "3. Drop Table."
			echo "4. Insert Into Table."
			echo "5. Delete From Table."
			echo "6. Update Table."
			echo "7. Select From Table."
			echo "0. Quit."
			read -p ":> " choice		
	
			case $choice in
				1) 
					./.ConnectDB.dir/.CreateTable.sh "./DataBases/$DBN"
					;;
				2) 
					./.ConnectDB.dir/.ListTables.sh "./DataBases/$DBN"
					;;		
				3)
					./.ConnectDB.dir/.DropTable.sh "./DataBases/$DBN"
					;;
				4) 
					./.ConnectDB.dir/.InsertIntoTable.sh "./DataBases/$DBN"
					;;
				5)
					./.ConnectDB.dir/.DeleteFromTable.sh "./DataBases/$DBN"
					;;
					
				6) 	
					./.ConnectDB.dir/.UpdateTable.sh "./DataBases/$DBN"
				 	;;
				7)
					./.ConnectDB.dir/.SelectFromTable.sh "./DataBases/$DBN"
					;;			
				0)
					echo -e "${GREEN}Disconnected from '$DBN'. Returning to main menu...${NC}"
					exit
					;;
				*)
					echo -e "${RED}You entered an invalid choice!${NC}"

					continue
					;;
			esac
		done

		break
	else
		echo -e "${RED}The '$DBN' Database doesn't exist!${NC}"
		continue
	fi
done
