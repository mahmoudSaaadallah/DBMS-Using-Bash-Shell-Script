#!/bin/bash

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

WDB="$1"

while true; do
    read -p "Enter the name of the table to drop (or type 'exit' to cancel): " tableName

    if [[ "$tableName" =~ ^(exit|quit|back)$ ]]; then
        echo -e "${YELLOW}Cancelled drop table.${NC}"
        break
    fi

    if [ -z "$tableName" ]; then
        echo -e "${RED}The name of table can't be empty!${NC}"
        continue
    fi

    if [ -f "./$WDB/$tableName" ] && [ -f "./$WDB/$tableName.meta" ]; then
        read -p "Are you sure you want to delete the table '$tableName'? (y/n): " confirm

        if [[ $confirm == [Yy] ]]; then
            rm "./$WDB/$tableName" "./$WDB/$tableName.meta"
            echo -e "${GREEN}$tableName table has been removed.${NC}"
        else
            echo -e "${YELLOW}Cancelled.${NC}"
        fi
        break
    else
        echo -e "${RED}The $tableName table doesn't exist.${NC}"
    fi
done
