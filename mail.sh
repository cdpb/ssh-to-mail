#!/bin/bash

WHITELIST=( example@whatever.com )

# SSH workaround
if [[ $1 == "-c" ]]; then
	VAL=$2
else
	VAL=$1
fi

function __split() {
	REGEX="awk '{for (I=1;I<=NF;I++) if (\$I == \"$1\") {print \$(I+1)};}'"
	if [[ $1 == "con" ]]; then
		LINES=$(echo "${VAL}" | wc -l)
		if [[ $LINES > 1 ]]; then
			REGEX="awk '/$1/?c++:c'"
		fi
	fi
	echo "${VAL}" | eval $(echo $REGEX)
}

function __form() {
	echo "$(date +%T) -> " $1
}

if [[ $VAL# > 1 ]]; then
	CON=$(__split "con")
	DST=$(__split "dst")
	SUB=$(__split "sub")
fi

if [[ -z $DST || -z $CON ]]; then
	echo "check args"
	exit 1
fi

VALID=false
for i in ${WHITELIST[@]}; do
	if [[ $DST == $i ]]; then
		VALID=true
	fi
done

if [[ $VALID == "true" ]]; then
	if [[ -z $SUB ]]; then
		SUB='SSH to Mail'
	fi

	__form "Start sending"
	echo "${CON}" | mail -s "${SUB}" "${DST}"

	if [[ $? = 0 ]]; then
		__form "Send succesful"
	else
		__form "Sending failed"
	fi
else
	echo "User not in whitelist"
fi

