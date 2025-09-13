#!/bin/bash

# ANSI Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

WDB="$1"
read -p "Enter the table name to view: " tableName

metaFile="./$WDB/$tableName.meta"
dataFile="./$WDB/$tableName"

if [[ ! -f "$metaFile" || ! -f "$dataFile" ]]; then
	echo -e "${RED}Table '$tableName' does not exist in database '$WDB'.${NC}"
	exit 1
fi

# print meta
echo -e "${GREEN}Table:$tableName${NC}"
echo -e "${YELLOW}Columns:${NC}"
awk -F: '{ printf "%-20s", $1 }' "$metaFile"
echo -e "\n${YELLOW}Rows:${NC}"

# print Data
tail -n +2 "$dataFile" | while IFS= read -r row; do
	IFS=':' read -ra fields <<< "$row"
	for field in "${fields[@]}"; do
		printf "%-20s" "$field"
	done
	echo ""
done
		





