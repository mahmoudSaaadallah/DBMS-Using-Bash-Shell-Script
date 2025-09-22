#!/bin/bash

# ANSI Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

WDB="$1"

while true; do
    read -p "Enter table name (or type 'exit' to cancel): " tableName

    if [[ "$tableName" =~ ^(exit|quit|back)$ ]]; then
        echo -e "${YELLOW}Cancelled table creation.${NC}"
        break
    fi
    tableName=$(echo "$tableName" | tr -d '[:space:]' | tr -d '\r')
    if [ -z "$tableName" ] || [[ "$tableName" =~ [^a-zA-Z0-9_] ]]; then
        echo -e "${RED}Invalid Table Name.${NC}"
        continue
    fi

    if [ -f "./$WDB/$tableName" ] || [ -f "./$WDB/$tableName.meta" ]; then
        echo -e "${RED}Table already exists.${NC}"
        break
    fi

    read -p "How many columns? " col
    if ! [[ "$col" =~ ^[0-9]+$ ]] || [ "$col" -le 0 ]; then
        echo -e "${RED}Invalid number of columns.${NC}"
        continue
    fi

    echo "RN:number" >> "./$WDB/$tableName.meta"

    counter=1
    while (( counter <= col )); do
        read -p "Enter name for column $counter: " colName
        read -p "Enter data type (string/number): " colType
		colName=$(echo "$colName" | tr -d '[:space:]' | tr -d '\r')
		colType=$(echo "$colType" | tr -d '[:space:]' | tr -d '\r')
        if [ -z "$colName" ] || [[ "$colName" =~ [^a-zA-Z0-9_] ]]; then
            echo -e "${RED}Invalid Column Name.${NC}"
            continue
        fi

        if grep -q "^$colName:" "./$WDB/$tableName.meta"; then
            echo -e "${RED}$colName Column already exists.${NC}"
            continue
        fi

        if [[ "$colType" != "number" && "$colType" != "string" ]]; then
            echo -e "${RED}Invalid Column Type.${NC}"
            continue
        fi

        echo "$colName:$colType" >> "./$WDB/$tableName.meta"
        echo -e "${GREEN}$colName column has been added.${NC}"
        ((counter++))
    done
    touch "./$WDB/$tableName"
    
    awk -F: '{print $1}' "./$WDB/$tableName.meta" | paste -sd':' - >> "./$WDB/$tableName"

    echo -e "${GREEN}Table '$tableName' created successfully with $col columns.${NC}"
    break
done
