#!/bin/bash

echo "{" > alertParameters.json


sh runAlert.sh alert_queries/sp
sp_total=$(cat temp | jq .hits.total)
solder_percent=$(bc -l <<< "scale=1; 100 - $sp_total%100")
echo "\"screenprinter_solder\":$solder_percent," >> alertParameters.json
#sh runAlert.sh alert_queries/sp
#sp_total=$(cat temp | jq .hits.total)
service_in=$(bc -l <<< "scale=1; 30 - $sp_total%30")
echo "\"screenprinter_service_in\":$service_in," >> alertParameters.json

sh runAlert.sh alert_queries/pp1
pp1_total=$(cat temp | jq .hits.total)
refill1=$(bc -l <<< "scale=1; (30 - $pp1_total%30)*100/30")
echo "\"pickandplace1_refill1\":$refill1," >> alertParameters.json
refill2=$(bc -l <<< "scale=1; (50 - $pp1_total%50)*100/50")
echo "\"pickandplace1_refill2\":$refill2," >> alertParameters.json

sh runAlert.sh alert_queries/pp2
pp2_total=$(cat temp | jq .hits.total)
refill1=$(bc -l <<< "scale=1; (70 - $pp2_total%70)*100/70")
echo "\"pickandplace2_refill1\":$refill1," >> alertParameters.json
refill2=$(bc -l <<< "scale=1; (40 - $pp2_total%40)*100/40")
echo "\"pickandplace2_refill2\":$refill2" >> alertParameters.json

echo "}" >> alertParameters.json
cat alertParameters.json
cp alertParameters.json ../../Desktop/freeboard-alerts/
