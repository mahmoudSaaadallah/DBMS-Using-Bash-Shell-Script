#!/bin/bash

# ANSI Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

WDB="$1"

tables=$(find "$WDB" -maxdepth 1 -type f ! -name "*.meta" -exec basename {} \;)

if [ -z "$tables" ]; then
    echo -e "${RED}No tables found in database '${WDB}'.${NC}"
else
    echo -e "${GREEN}Tables in '${WDB}':${NC}"
    echo "$tables"
fi

