#!/bin/bash

# ANSI Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

WDB=$1
read -p "Enter the table name: " tableName

metaFile="./$WDB/$tableName.meta"
dataFile="./$WDB/$tableName"

if [ ! -f "$metaFile" ] || [ ! -f "$dataFile" ]; then
    echo -e "${RED}Table '$tableName' doesn't exist in database '$WDB'.${NC}"
    exit 1
fi

# Read meta columns into an array (excluding header)
mapfile -t metaCols < <(tail -n +2 "$metaFile")

while true; do
    # Auto-increment RN
    if [ "$(wc -l < "$dataFile")" -gt 1 ]; then
        lastRN=$(tail -n +2 "$dataFile" | tail -n 1 | cut -d ':' -f1)
        newRN=$((lastRN + 1))
    else
        newRN=1
    fi

    row="$newRN"

    for metaLine in "${metaCols[@]}"; do
        colName="${metaLine%%:*}"
        colType="${metaLine##*:}"

        while true; do
            read -p "Enter value for '$colName' ($colType): " value

            if [[ "$colType" == "number" ]]; then
                if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                    echo -e "${RED}Invalid number, please enter digits only.${NC}"
                    continue
                fi
            elif [[ "$colType" == "string" ]]; then
                if [[ -z "$value" ]]; then
                    echo -e "${RED}String cannot be empty.${NC}"
                    continue
                fi
            else
                echo -e "${RED}Unknown column type '$colType'.${NC}"
                exit 1
            fi

            row="$row:$value"
            break
        done
    done

    echo "$row" >> "$dataFile"
    echo -e "${GREEN}Row inserted successfully: $row${NC}"

    read -p "Do you want to insert another row? (y/n): " again
    if [[ ! "$again" =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Returning to menu...${NC}"
        break
    fi
done

