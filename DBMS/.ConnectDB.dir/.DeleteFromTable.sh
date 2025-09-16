#!/bin/bash

# ANSI Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

WDB="$1"
read -p "Enter the table name (or type 'exit' to cancel): " tableName

if [[ "$tableName" =~ ^(exit|quit|back)$ ]]; then
    echo -e "${YELLOW}Cancelled delete.${NC}"
    exit 0
fi

metaFile="./$WDB/$tableName.meta"
dataFile="./$WDB/$tableName"

if [[ ! -f "$metaFile" || ! -f "$dataFile" ]]; then
    echo -e "${RED}Table '$tableName' does not exist in database '$WDB'.${NC}"
    exit 1
fi

# Show current rows
echo -e "${YELLOW}Current rows in '$tableName':${NC}"
column -s: -t "$dataFile"

while true; do
    read -p "Enter the RN (Record Number) of the row to delete (or 'exit' to cancel): " RN

    if [[ "$RN" =~ ^(exit|quit|back)$ ]]; then
        echo -e "${YELLOW}Cancelled delete.${NC}"
        break
    fi

    if ! grep -q "^$RN:" "$dataFile"; then
        echo -e "${RED}Row with RN=$RN not found.${NC}"
        continue
    fi

    # Keep header + rows not matching RN
    grep -v "^$RN:" "$dataFile" > "$dataFile.tmp"
    mv "$dataFile.tmp" "$dataFile"

    echo -e "${GREEN}Row with RN=$RN deleted successfully.${NC}"

    read -p "Delete another row? (y/n): " again
    if [[ ! "$again" =~ ^[Yy]$ ]]; then
        break
    fi
done
