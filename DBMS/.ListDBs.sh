#!/bin/bash

# ANSI Color Code
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [[ ! -d ./DataBases ]] || [[ -z "$(ls -A ./DataBases 2>/dev/null)" ]]; then
    echo -e "${RED}No databases found.${NC}"
else
    echo -e "${GREEN}Available Databases:${NC}"
    ls -1 ./DataBases
fi
