#!/bin/bash

source secret.conf

OVH_APP_KEY=$OVH_APP_KEY
OVH_APP_SECRET=$OVH_APP_SECRET
OVH_CONSUMER_KEY=$OVH_CONSUMER_KEY

HTTP_METHOD="POST"
HTTP_QUERY="https://api.ovh.com/1.0/domain/zone/probatou.com/refresh"
TIME=$(curl -s https://api.ovh.com/1.0/auth/time)
CLEAR_SIGN=$OVH_APP_SECRET"+"$OVH_CONSUMER_KEY"+"$HTTP_METHOD"+"$HTTP_QUERY"++"$TIME
SIG='$1$'$(echo -n $CLEAR_SIGN | openssl dgst -sha1 -hex | cut -f 2 -d ' ' )

curl -X $HTTP_METHOD \
$HTTP_QUERY \
-H "Accept: application/json" \
-H "Host: api.ovh.com" \
-H "X-Ovh-Application: $OVH_APP_KEY" \
-H "X-Ovh-Consumer: $OVH_CONSUMER_KEY" \
-H "X-Ovh-Signature: $SIG" \
-H "X-Ovh-Timestamp: $TIME"
