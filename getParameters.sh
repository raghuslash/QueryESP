#!/bin/bash

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

sh runEventQ.sh queries/loader1Q.json
echo "line_loader.delay: `cat temp | jq '.aggregations.line_loader_delay.value'`" > DTparameters.txt

echo "Done.. Parameters are available in DTparameters.txt"

