#!/bin/bash

oldmdhash=0
while true; do
	mdhash=$(md5sum DTparameters.txt)
	sleep 10
	echo $mdhash $oldmdhash
	if [ "$oldmdhash" != "$mdhash" ]; then
		echo "Change Detected!"
		sudo scp DTparameters.txt root@droplet:/var/www/html/static/DTparameters/
		oldmdhash=$mdhash
	fi
done
	
