#!/bin/bash

LOCUST_OPTS="/usr/local/bin/locust -f /usr/local/locustfile.py --$LOCUST_MODE --host=$TARGET_URL"

if [ "$LOCUST_MODE" = "slave" ]; then
  LOCUST_OPTS="$LOCUST_OPTS --master-host=$MASTER_HOST"
else
  isReady=666
  until [ ! $isReady -ne 0 ]
  do
   curl $GRAFANA_HOST 2> /dev/null
   isReady=$?
  done
  curl -X POST $GRAFANA_HOST/api/dashboards/db -H "Content-Type: application/json" -u $GRAFANA_CREDENTIALS -d @/usr/local/grafanaDashboard.json
fi

echo "Starting Locust : $LOCUST_OPTS"

$LOCUST_OPTS