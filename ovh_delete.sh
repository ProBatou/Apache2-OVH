#!/bin/bash

source secret.conf

txt_domain=$txt_domain
txt_target=$txt_target
OVH_APP_KEY=$OVH_APP_KEY
OVH_APP_SECRET=$OVH_APP_SECRET
OVH_CONSUMER_KEY=$OVH_CONSUMER_KEY

HTTP_METHOD="DELETE"
txt_type="CNAME"
txt_subdomain=$1
CNAME_id=$($PWD/ovh_find_id.sh $txt_subdomain)
HTTP_QUERY="https://api.ovh.com/1.0/domain/zone/"$txt_domain"/record/"$CNAME_id""
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
--data "$HTTP_BODY"
