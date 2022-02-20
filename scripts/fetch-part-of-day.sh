#!/bin/bash -x

HOUR=`date +%H`
MIN=`date +%M`
SUM=$((${HOUR}*60+${MIN}))

if [ `date +%u` -lt 6 ]; then
# weekday
MORNING=$((6*60 + 15))
else
# weekend
MORNING=$((6*60 + 45))
fi

DAY=$((${MORNING} + 30))
NIGHT=$((19*60 + 00))

if [ ${SUM} -lt ${MORNING} ]
then echo "NIGHT"
elif [ ${SUM} -lt ${DAY} ]
then echo "MORNING"
elif [ ${SUM} -lt ${NIGHT} ]
then echo "DAY"
else echo "NIGHT"
fi

