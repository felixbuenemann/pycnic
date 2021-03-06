#!/bin/bash

output="Test results:\n"

for app in bobo_test falcon_test pycnic_test cherrypy_test pyramid_test hug_test flask_test bottle_test; 
do
    echo "TEST: $app"
    gunicorn -w 3 $app:app &
    sleep 2 
    ab_out=`ab -n 5000 -c 5 http://localhost:8000/json`
    killall gunicorn
    rps=`echo "$ab_out" | grep "Requests per second"`
    crs=`echo "$ab_out" | grep "Complete requests"`
    output="$output\n$app:\n\t$rps\n\t$crs"
done

echo -e "$output"


