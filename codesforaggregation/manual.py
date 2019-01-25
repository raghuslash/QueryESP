
import os

os.system('sh get.sh query.json | jq ".hits.hits | .[].fields.power | .[0]" > powers')
powers = open("powers").read()

powers = list(map(lambda x:float(x),powers.split()))

print (sum(powers) / len(powers))
