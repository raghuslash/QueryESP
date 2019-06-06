#echo "Got query : \n`cat $1`\n"

curl -ss -H 'Content-Type: application/json' -XPOST 'vinyas:9200/streamingevents*/_search?pretty' -d @$1 -o temp

#cat tempB | jq .hits.total 


