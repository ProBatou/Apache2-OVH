#!/bin/bash

source secret.conf

txt_domain=$txt_domain
txt_target=$txt_target
OVH_APP_KEY=$OVH_APP_KEY
OVH_APP_SECRET=$OVH_APP_SECRET
OVH_CONSUMER_KEY=$OVH_CONSUMER_KEY

HTTP_METHOD="GET"
HTTP_QUERY="https://api.ovh.com/1.0/domain/zone/"$txt_domain"/record?fieldType=CNAME&subDomain="$1""
txt_type="CNAME"
txt_subdomain=$1
TIME=$(curl -s https://api.ovh.com/1.0/auth/time)
CLEAR_SIGN=$OVH_APP_SECRET"+"$OVH_CONSUMER_KEY"+"$HTTP_METHOD"+"$HTTP_QUERY"++"$TIME
SIG='$1$'$(echo -n $CLEAR_SIGN | openssl dgst -sha1 -hex | cut -f 2 -d ' ' )

curl -X $HTTP_METHOD \
$HTTP_QUERY \
-H "Content-Type: application/json" \
-H "X-Ovh-Application: $OVH_APP_KEY" \
-H "X-Ovh-Consumer: $OVH_CONSUMER_KEY" \
-H "X-Ovh-Signature: $SIG" \
-H "X-Ovh-Timestamp: $TIME" \
--data "$HTTP_BODY" | jq -c  '.[]'
