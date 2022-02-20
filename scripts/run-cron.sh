#!/bin/bash

if [ "$1" == "init" ]; then
	$HOME/run-led.sh init
	exit
fi

FILE=/tmp/state

if [ "$1" == "test" ]; then
	if test -r ${FILE}
	then STATE=`cat ${FILE}`
	else STATE=MORNING
	fi

	case "$STATE" in
		"MORNING") STATE=DAY
			;;
		"DAY") STATE=NIGHT
			;;
		"NIGHT") STATE=MORNING
			;;
	esac
else
	STATE=$($HOME/fetch-part-of-day.sh)
fi

echo ${STATE}>${FILE}

$HOME/run-led.sh $STATE
