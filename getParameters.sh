#!/bin/bash

sh runEventQ.sh queries/loader1Q.json
t=$(cat temp | jq '.aggregations.line_loader_delay.value')
t=$(bc -l <<< "scale=1; $t/1")
echo "line_loader.delay: $t" > DTparameters.txt


sh runEventQ.sh queries/screenprinter0Q.json
t=$(cat temp | jq '.aggregations.screen_printer_idle_delay.value')
e=$(cat temp | jq '.aggregations.screen_printer_idle_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e/1")
p0=$(bc -l <<< "scale=0;`echo $e` * 3600000 / `echo $t`")
#echo "screen_printer.idle_delay: $t" >> DTparameters.txt


sh runEventQ.sh queries/screenprinter1Q.json
t=$(cat temp | jq '.aggregations.screen_printer_printing_delay.value')
e=$(cat temp | jq '.aggregations.screen_printer_printing_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e/1")
p1=$(bc -l <<< "scale=0;`echo $e` * 3600000 / `echo $t`")
echo "screen_printer.printing_delay: $t" >> DTparameters.txt


sh runEventQ.sh queries/screenprinter2Q.json
t=$(cat temp | jq '.aggregations.screen_printer_cleaning_delay.value')
e=$(cat temp | jq '.aggregations.screen_printer_cleaning_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e/1")
p2=$(bc -l <<< "scale=0;`echo $e` * 3600000 / `echo $t`")
echo "screen_printer.cleaning_delay: $t" >> DTparameters.txt

sh runEventQ.sh queries/pickandplace10Q.json
t=$(cat temp | jq '.aggregations.pick_and_place_1_idle_delay.value')
e=$(cat temp | jq '.aggregations.pick_and_place_1_idle_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e/1")
p0=$(bc -l <<< "scale=0;`echo $e` * 3600000 / `echo $t`")
#echo "pick_and_place_1.idle_delay: $t" >> DTparameters.txt

sh runEventQ.sh queries/pickandplace11Q.json
t=$(cat temp | jq '.aggregations.pick_and_place_1_processing_delay.value')
e=$(cat temp | jq '.aggregations.pick_and_place_1_processing_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e/1")
p0=$(bc -l <<< "scale=0;`echo $e` * 3600000 / `echo $t`")
echo "pick_and_place_1.processing_delay: $t" >> DTparameters.txt

sh runEventQ.sh queries/pickandplace20Q.json
t=$(cat temp | jq '.aggregations.pick_and_place_2_idle_delay.value')
e=$(cat temp | jq '.aggregations.pick_and_place_2_idle_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e/1")
p0=$(bc -l <<< "scale=0;`echo $e` * 3600000 / `echo $t`")
#echo "pick_and_place_2.idle_delay: $t" >> DTparameters.txt

sh runEventQ.sh queries/pickandplace21Q.json
t=$(cat temp | jq '.aggregations.pick_and_place_2_processing_delay.value')
e=$(cat temp | jq '.aggregations.pick_and_place_2_processing_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e/1")
p0=$(bc -l <<< "scale=0;`echo $e` * 3600000 / `echo $t`")
echo "pick_and_place_2.processing_delay: $t" >> DTparameters.txt

sh runStateQ.sh queries/reflowoven0Q.json
t=$(cat temp | jq '.aggregations.reflowoven_off_delay.value')
e=$(cat temp | jq '.aggregations.reflowoven_off_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e/1")
p0=$(bc -l <<< "scale=0;`echo $e` * 3600000 / `echo $t`")

sh runStateQ.sh queries/reflowoven1Q.json
t=$(cat temp | jq '.aggregations.reflowoven_maintain_delay.value')
e=$(cat temp | jq '.aggregations.reflowoven_maintain_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e/1")
p1=$(bc -l <<< "scale=0;`echo $e` * 3600000 / `echo $t`")

sh runStateQ.sh queries/reflowoven2Q.json
t=$(cat temp | jq '.aggregations.reflowoven_setup_delay.value')
e=$(cat temp | jq '.aggregations.reflowoven_setup_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e/1")
p2=$(bc -l <<< "scale=0;`echo $e` * 3600000 / `echo $t`")



echo "Done.. Parameters are available in DTparameters.txt"

