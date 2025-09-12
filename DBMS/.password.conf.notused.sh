#!/bin/bash

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

createPassword () {
	x=$(cat ./.password.sh)
	if [ -z "$x" ]; then
		while true; do
			read -p "Enter the new Password: " newPassword
			read -p "Confirm it again: " newPasswordAgain
			if [[ "$newPassword" == "$newPasswordAgain" ]]; then
				echo -3 "#!/bin/bash\n" > ./.password
				echo -e "userPassword=$newPassword\n" >> ./.password
				echo -e "./.confgDBMS.sh $1 $userPassword" >> ./.password
				echo -e "${GREEN}New Password has been created.${NC}"
				break
			else
				echo -e "${RED}Not identical passwords"
				continue
			fi
		done
	else
		echo -e "${RED}There is a Password already exist."
	        echo -e "Press 2 to change it if you want.${NC}"
		continue							               
         fi
}

changePassword () {
	while true; do
		read -p "Enter the old password: " oldPassword
		./.password.sh "$oldPassword"
		if (( $? == 0 )); then
			read -p "Enter the new Password: " newPassword
			read -p "Confirm it again: " newPasswordAgain
			if [[ "$newPassword" == "$newPasswordAgain" ]]; then
				echo -e "#!/bin/bash\n" > ./.password
				echo -e "userPassword=$newPassword\n" >> ./.password
				echo -e "./.confgDBMS.sh $1 $userPassword" >> ./.password
				echo -e "${GREEN}New Password has been created.${NC}"
				break
			else
				echo -e "${RED}Not identical passwords"
				continue
			fi
		fi
	done

}



while true; do
	echo -e "\n${GREEN}Select for the list below: "
	echo "1. Create Password."
	echo "2. Change Password."
	echo "0. Quit."
	read -p ":> " choice


	case "$choice"	in
		1)
		       	createPassword
			;;
		2)
			changePassword
			;;
		0)
			exit
			;;
		*)
			echo -e "${RED}You entered an invalid chice!${NC}" 
			continue
		       	;;
	esac

done
