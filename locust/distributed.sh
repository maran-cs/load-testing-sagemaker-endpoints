#replace with your endpoint name in format https://<<endpoint-name>>
export ENDPOINT_NAME=https://jumpstart-dft-meta-textgeneration-llama-2-7b

export REGION=us-east-1
export CONTENT_TYPE=application/json
export USERS=5
export WORKERS=1
export RUN_TIME=5m
export LOCUST_UI=true # Use Locust UI


#replace with the locust script that you are testing, this is the locust_script that will be used to make the InvokeEndpoint API calls. 
export SCRIPT=locust_script.py

#make sure you are in a virtual environment
#. ./venv/bin/activate

if $LOCUST_UI ; then
    locust -f $SCRIPT -H $ENDPOINT_NAME --master --expect-workers $WORKERS -u $USERS -t $RUN_TIME --csv results &
else
    locust -f $SCRIPT -H $ENDPOINT_NAME --master --expect-workers $WORKERS -u $USERS -t $RUN_TIME --csv results --headless &
fi

for (( c=1; c<=$WORKERS; c++ ))
do
    locust -f $SCRIPT -H $ENDPOINT_NAME --worker --master-host=localhost &
done
~       