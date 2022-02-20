#!/bin/bash

if [ "$1" == "init" ]; then
	$HOME/run-led.sh init
	exit
fi

FILE=/tmp/state

if test -r ${FILE}; then
	OLDSTATE=`cat ${FILE}`
	echo "Read OLDSTATE ${OLDSTATE}"
else
	OLDSTATE=MORNING
	echo "Unknown OLDSTATE, set to ${OLDSTATE}"
fi

if [ "$1" == "test" ]; then

	case "$OLDSTATE" in
		"MORNING") NEWSTATE=DAY
			;;
		"DAY") NEWSTATE=NIGHT
			;;
		"NIGHT") NEWSTATE=MORNING
			;;
	esac
else
	NEWSTATE=$($HOME/fetch-part-of-day.sh)
fi

if [ "${NEWSTATE}" != "${OLDSTATE}" ]; then
	echo "Switching state from ${OLDSTATE} to ${NEWSTATE}"
fi
echo ${NEWSTATE}>${FILE}

$HOME/run-led.sh ${NEWSTATE}
