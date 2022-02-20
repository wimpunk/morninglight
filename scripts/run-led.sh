#!/bin/bash
# https://projects-raspberry.com/raspberry-pi-and-gpio-pin-controlling-an-led-with-bash-and-python/

#
# LED32K3 LED
# https://www.kingbright.com/attachments/file/psearch/000/00/00/L-3VEGW(Ver.25A).pdf
# CLIP31  LED houder
#

# 0V - weerstand - LED - GPIO


case "$1" in
 "GREEN") GPIO=15;;
 "RED") GPIO=14;;
 "DAY") 
	$0 GREEN 1
        $0 RED 0
	exit
        ;; 
 "NIGHT") 
	$0 GREEN 0
        $0 RED 0
	exit
        ;; 
 "MORNING") 
	$0 GREEN 0
        $0 RED 1
	exit
        ;; 
  "init")
	$0 GREEN 0
	$0 GREEN 0
	;;
 *) exit;;
esac

#if [ "$1" == "GREEN" ];
#then GPIO=15
#else GPIO=14
#fi

if [ ! -z "$2" ]
then STATE="$2"
fi

if ! test -d /sys/class/gpio/gpio${GPIO}
then
	echo ${GPIO} > /sys/class/gpio/export 
fi

if [ `cat /sys/class/gpio/gpio${GPIO}/direction` != "out" ]
then
	echo out > /sys/class/gpio/gpio${GPIO}/direction 
fi

if [ -z "$STATE" ]
then
	STATE=$((1-$(cat /sys/class/gpio/gpio${GPIO}/value)))
fi
echo $STATE > /sys/class/gpio/gpio${GPIO}/value


