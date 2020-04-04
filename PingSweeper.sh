#!/bin/bash
if [ "$1" == "" ]
then
	echo "No IP Address given"
	echo "Syntax ./PingSweeper.sh 192.168.1"
else
	str=$1
	a=$( echo $1 | cut -d "." -f 1)
	b=$( echo $1 | cut -d "." -f 2)
	c=$( echo $1 | cut -d "." -f 3)
	x="${str//[^.]}"
	#echo "${#x}"
	#echo $a
	re='^[0-9]+$'
	if [ ${#x} != "2" ]
	then
		echo "Invalid Input"
		echo "Syntax ./PingSweeper.sh 192.168.1"
	else
		if ! [[ $a =~ $re ]] || ! [[ $b =~ $re ]] || ! [[ $c =~ $re ]]
		then
			echo "Invalid Input"
			echo "Syntax ./PingSweeper.sh 192.168.1"
		elif (($a > 255)) || (($b > 255)) || (($c > 255)) || (($a == 0))
		then
			echo "Invalid IP"
		else
			for l in {1..254}
			do
				ping -c 1 $1.$l | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" &
			done
		fi
	fi
fi
