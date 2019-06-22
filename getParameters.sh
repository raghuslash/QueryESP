#!/bin/bash

sh runEventQ.sh queries/loader1Q.json
t=$(cat temp | jq '.aggregations.line_loader_delay.value')
t=$(bc -l <<< "scale=1; $t/1")
echo "line_loader.delay=$t" > DTparameters.txt


sh runEventQ.sh queries/screenprinter0Q.json
t=$(cat temp | jq '.aggregations.screen_printer_idle_delay.value')
#e=$(cat temp | jq '.aggregations.screen_printer_idle_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
#e=$(bc -l <<< "scale=1; $e*3600000/1")
p0=$(cat temp | jq '.aggregations.screen_printer_idle_power.value')
p0=$(bc -l <<< "scale=1; $p0/1")
#echo "screen_printer.idle_delay=$t" >> DTparameters.txt


sh runEventQ.sh queries/screenprinter1Q.json
t=$(cat temp | jq '.aggregations.screen_printer_printing_delay.value')
#e=$(cat temp | jq '.aggregations.screen_printer_printing_energy.value')
p=$(cat temp | jq '.hits.total')
t=$(bc -l <<< "scale=1; $t/1")
#e=$(bc -l <<< "scale=1; $e*3600000/1")
p1=$(cat temp | jq '.aggregations.screen_printer_printing_power.value')
p1=$(bc -l <<< "scale=1; $p1/1")
echo "screen_printer.printing_delay=$t" >> DTparameters.txt


sh runEventQ.sh queries/screenprinter2Q.json
t=$(cat temp | jq '.aggregations.screen_printer_cleaning_delay.value')
#e=$(cat temp | jq '.aggregations.screen_printer_cleaning_energy.value')
c=$(cat temp | jq '.hits.total')
t=$(bc -l <<< "scale=1; $t/1")
#e=$(bc -l <<< "scale=1; $e*3600000/1")
p2=$(cat temp | jq '.aggregations.screen_printer_cleaning_power.value')
p2=$(bc -l <<< "scale=1; $p2/1")
ratio=$((($p+$c-1)/$c))


echo "screen_printer.cleaning_delay=$t" >> DTparameters.txt
echo "screen_printer.num_pcbs_per_cleaning=$ratio" >> DTparameters.txt



echo "screen_printer.set_power_ratings([$p0,$p0,$p1,$p2,$p0])" >> DTparameters.txt

sh runEventQ.sh queries/pickandplace10Q.json
t=$(cat temp | jq '.aggregations.pick_and_place_1_idle_delay.value')
#e=$(cat temp | jq '.aggregations.pick_and_place_1_idle_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
#e=$(bc -l <<< "scale=1; $e*3600000/1")
p0=$(cat temp | jq '.aggregations.pick_and_place_1_idle_power.value')
p0=$(bc -l <<< "scale=1; $p0/1")
#echo "pick_and_place_1.idle_delay=$t" >> DTparameters.txt


sh runEventQ.sh queries/pickandplace11Q.json
t=$(cat temp | jq '.aggregations.pick_and_place_1_processing_delay.value')
#e=$(cat temp | jq '.aggregations.pick_and_place_1_processing_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
#e=$(bc -l <<< "scale=1; $e*3600000/1")
p1=$(cat temp | jq '.aggregations.pick_and_place_1_processing_power.value')
p1=$(bc -l <<< "scale=1; $p1/1")
echo "pick_and_place_1.processing_delay=$t" >> DTparameters.txt

echo "pick_and_place_1.set_power_ratings([$p0,$p0,$p1,$p0])" >> DTparameters.txt


sh runEventQ.sh queries/pickandplace20Q.json
t=$(cat temp | jq '.aggregations.pick_and_place_2_idle_delay.value')
#e=$(cat temp | jq '.aggregations.pick_and_place_2_idle_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
#e=$(bc -l <<< "scale=1; $e*3600000/1")
p0=$(cat temp | jq '.aggregations.pick_and_place_2_idle_power.value')
p0=$(bc -l <<< "scale=1; $p0/1")
#echo "pick_and_place_2.idle_delay=$t" >> DTparameters.txt

sh runEventQ.sh queries/pickandplace21Q.json
t=$(cat temp | jq '.aggregations.pick_and_place_2_processing_delay.value')
#e=$(cat temp | jq '.aggregations.pick_and_place_2_processing_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
#e=$(bc -l <<< "scale=1; $e*3600000/1")
p1=$(cat temp | jq '.aggregations.pick_and_place_2_processing_power.value')
p1=$(bc -l <<< "scale=1; $p1/1")
echo "pick_and_place_2.processing_delay=$t" >> DTparameters.txt

echo "pick_and_place_2.set_power_ratings([$p0,$p0,$p1,$p0])" >> DTparameters.txt

sh runStateQ.sh queries/reflowoven0Q.json
t=$(cat temp | jq '.aggregations.reflowoven_off_delay.value')
e=$(cat temp | jq '.aggregations.reflowoven_off_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e*3600000/1")
#p0=$(cat temp | jq '.aggregations.reflowoven_off_power.value')
p0=$(bc -l <<< "$e/$t")
p0=$(bc -l <<< "scale=1; $p0/1")

sh runStateQ.sh queries/reflowoven1Q.json
t=$(cat temp | jq '.aggregations.reflowoven_maintain_delay.value')
e=$(cat temp | jq '.aggregations.reflowoven_maintain_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e*3600000/1")
#p1=$(cat temp | jq '.aggregations.reflowoven_maintain_power.value')
p1=$(bc -l <<< "$e/$t")
p1=$(bc -l <<< "scale=1; $p1/1")

sh runStateQ.sh queries/reflowoven2Q.json
t=$(cat temp | jq '.aggregations.reflowoven_setup_delay.value')
e=$(cat temp | jq '.aggregations.reflowoven_setup_energy.value')
t=$(bc -l <<< "scale=1; $t/1")
e=$(bc -l <<< "scale=1; $e*3600000/1")
#p2=$(cat temp | jq '.aggregations.reflowoven_setup_power.value')
p2=$(bc -l <<< "$e/$t")
p2=$(bc -l <<< "scale=1; $p2/1")
echo "reflow_oven.set_power_ratings([$p0,$p2,$p1,$p1])" >> DTparameters.txt

echo "Done.. Parameters are available in DTparameters.txt"

echo "Sending Parameters file to cloud server..."
scp DTparameters.txt root@droplet:/var/www/html/static/DTparameters/

if [ $? -ne 0 ]; then
	echo "Failed.."
fi
