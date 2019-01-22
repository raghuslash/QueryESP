#echo "Got query : \n`cat $1`\n"

curl -ss -H 'Content-Type: application/json' -XPOST 'localhost:9200/streamingstates*/_search?pretty' -d `cat $1` -o temp 
