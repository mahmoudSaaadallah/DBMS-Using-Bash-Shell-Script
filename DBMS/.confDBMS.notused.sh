#!/bin/bash

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

password=$1
realpasswd=$2
if [[ "$password" != "$realpasswd" ]]; then
	echo -e "${RED}Authentication Failed.${NC}"
	exit 1
fi
