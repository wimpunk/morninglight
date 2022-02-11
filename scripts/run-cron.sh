#!/bin/bash

if [ "$1" = "init" ]; then
	$HOME/run-led.sh init
	exit
fi

FILE=/tmp/state

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

echo ${STATE}>${FILE}

$HOME/run-led.sh $STATE
