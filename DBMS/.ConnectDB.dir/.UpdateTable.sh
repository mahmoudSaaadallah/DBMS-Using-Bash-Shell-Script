#!/bin/bash

# ANSI Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

WDB="$1"
read -p "Enter the table name (or type 'exit' to cancel): " tableName

if [[ "$tableName" =~ ^(exit|quit|back)$ ]]; then
    echo -e "${YELLOW}Cancelled update.${NC}"
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

read -p "Enter the RN (Record Number) of the row to update: " RN
if ! grep -q "^$RN:" "$dataFile"; then
    echo -e "${RED}Row with RN=$RN not found.${NC}"
    exit 1
fi

# Read metadata (skip RN)
mapfile -t metaCols < <(tail -n +2 "$metaFile")

# Extract current row
currentRow=$(grep "^$RN:" "$dataFile")
IFS=':' read -ra fields <<< "$currentRow"

newRow="$RN"

index=2 # start from second column (since first is RN)
for metaLine in "${metaCols[@]}"; do
    colName="${metaLine%%:*}"
    colType="${metaLine##*:}"
    oldValue="${fields[index-1]}"

    read -p "Enter new value for '$colName' ($colType) [current: $oldValue]: " value

    if [ -z "$value" ]; then
        value="$oldValue"
    fi

    if [[ "$colType" == "number" && ! "$value" =~ ^[0-9]+$ ]]; then
        echo -e "${RED}Invalid number for $colName. Keeping old value.${NC}"
        value="$oldValue"
    fi

    newRow="$newRow:$value"
    ((index++))
done

# Replace old row with new row
grep -v "^$RN:" "$dataFile" > "$dataFile.tmp"
echo "$newRow" >> "$dataFile.tmp"
mv "$dataFile.tmp" "$dataFile"

echo -e "${GREEN}Row with RN=$RN updated successfully.${NC}"
