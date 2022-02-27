#!/bin/bash

HOUR=`date +%H`
MIN=`date +%M`
SUM=$((10#${HOUR}*60+10#${MIN}))

if grep $(date +%F) holidays.txt; then
	MORNING=$((6*60 + 45))
	SNOOZE=15
elif [ `date +%u` -lt 6 ]; then
	# weekday
	MORNING=$((6*60 + 15))
	SNOOZE=15
else
	# weekend
	MORNING=$((6*60 + 45))
	SNOOZE=30
fi

DAY=$((${MORNING} + ${SNOOZE}))
# start the night at noon
# this stops the LEDs
# looks like it saves energy
NIGHT=$((12*60 + 00))

if [ ${SUM} -lt ${MORNING} ]
then echo "NIGHT"
elif [ ${SUM} -lt ${DAY} ]
then echo "MORNING"
elif [ ${SUM} -lt ${NIGHT} ]
then echo "DAY"
else echo "NIGHT"
fi

