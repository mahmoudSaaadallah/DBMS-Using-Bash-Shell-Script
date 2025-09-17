#!/bin/bash

# ANSI Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

WDB="$1"
read -p "Enter the table name to view (or 'exit' to cancel): " tableName

if [[ "$tableName" =~ ^(exit|quit|back)$ ]]; then
    echo -e "${YELLOW}Cancelled.${NC}"
    exit 0
fi

metaFile="./$WDB/$tableName.meta"
dataFile="./$WDB/$tableName"

if [[ ! -f "$metaFile" || ! -f "$dataFile" ]]; then
    echo -e "${RED}Table '$tableName' does not exist in database '$WDB'.${NC}"
    exit 1
fi

# Get column names
mapfile -t columns < <(awk -F: '{print $1}' "$metaFile")

# Show table header
echo -e "${GREEN}Table: $tableName${NC}"
printf "${YELLOW}%-20s${NC}" "${columns[@]}"
echo ""
echo "------------------------------------------------------------"

# Ask if user wants filtering
read -p "Do you want to filter rows? (y/n): " filter
if [[ "$filter" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Available columns:${NC} ${columns[*]}"
    read -p "Enter column name for filter: " filterCol
    read -p "Enter value to match: " filterVal

    # Find column index
    colIndex=$(awk -v col="$filterCol" -F: '{if($1==col) print NR}' "$metaFile")

    if [[ -z "$colIndex" ]]; then
        echo -e "${RED}Column '$filterCol' not found.${NC}"
        exit 1
    fi

    # Print matching rows (skip header line in dataFile)
    
    flgMatch=false

while IFS=: read -r -a row; do
    if [[ "${row[colIndex-1]}" == *"$filterVal"* ]]; then
        flgMatch=true
        for field in "${row[@]}"; do
            printf "%-20s" "$field"
        done
        echo ""
    fi
done < <(tail -n +2 "$dataFile")  

if [[ "$flgMatch" == false ]]; then
    echo -e "${YELLOW}No matching records found.${NC}"
fi
else
    # Print all rows
    tail -n +2 "$dataFile"  | sort -t: -k1,1n | while IFS=: read -r -a row; do
        for field in "${row[@]}"; do
            printf "%-20s" "$field"
        done
        echo ""
    done
fi
