#!/bin/bash

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

while true; do
    
    if [[ $# -eq 0 ]]; then
        read -p "Enter the name of the Database (or type 'exit' to return): " DBN
        if [[ -z "$DBN" ]]; then
            echo -e "${RED}The name of the Database cannot be empty!${NC}"
            continue
        fi
        # Handle exit/quit keywords
        if [[ "$DBN" =~ ^(exit|quit|back)$ ]]; then
            echo -e "${GREEN}Returning to main menu...${NC}"
            break
        fi
    else
        DBN=$(basename "$1")   
        shift                  # clear argument
    fi

    if [[ -d "./DataBases/$DBN" ]]; then
        echo -e "\n${GREEN}Connected to '$DBN' Database.${NC}"
        echo -e "${GREEN}------------------------------------------${NC}"

        
        while true; do
            echo -e "\n${GREEN}Select from the list below: ${NC}"
            echo "1. Create Table"	
            echo "2. List Tables"
            echo "3. Drop Table"
            echo "4. Insert Into Table"
            echo "5. Delete From Table"
            echo "6. Update Table"
            echo "7. Select From Table"
            echo "0. Disconnect and Return to Main Menu"
            echo "-------------------------------------"
            read -p ":> " choice		

            case $choice in
                1) ./.ConnectDB.dir/.CreateTable.sh "./DataBases/$DBN" ;;
                2) ./.ConnectDB.dir/.ListTables.sh "./DataBases/$DBN" ;;		
                3) ./.ConnectDB.dir/.DropTable.sh "./DataBases/$DBN" ;;
                4) ./.ConnectDB.dir/.InsertIntoTable.sh "./DataBases/$DBN" ;;
                5) ./.ConnectDB.dir/.DeleteFromTable.sh "./DataBases/$DBN" ;;
                6) ./.ConnectDB.dir/.UpdateTable.sh "./DataBases/$DBN" ;;
                7) ./.ConnectDB.dir/.SelectFromTable.sh "./DataBases/$DBN" ;;
                0) 
                    echo -e "${GREEN}Disconnected from '$DBN'. Returning to main menu...${NC}"
                    break
                    ;;
                *)
                    echo -e "${RED}You entered an invalid choice!${NC}"
                    ;;
            esac
        done
        break  
    else
        echo -e "${RED}The '$DBN' Database does not exist!${NC}"
        [[ $# -gt 0 ]] && break   
        continue
    fi
done
