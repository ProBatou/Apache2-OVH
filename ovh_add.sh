#!/bin/bash

source secret.conf

txt_domain=$txt_domain
txt_target=$txt_target
OVH_APP_KEY=$OVH_APP_KEY
OVH_APP_SECRET=$OVH_APP_SECRET
OVH_CONSUMER_KEY=$OVH_CONSUMER_KEY

HTTP_METHOD="POST"
HTTP_QUERY="https://api.ovh.com/1.0/domain/zone/"$txt_domain"/record"
txt_type="CNAME"
txt_subdomain=$1
HTTP_BODY={"\"fieldType\"":"\"$txt_type\"","\"subDomain\"":"\"$txt_subdomain\"","\"target\"":"\"$txt_target\""}
TIME=$(curl -s https://api.ovh.com/1.0/auth/time)
CLEAR_SIGN=$OVH_APP_SECRET"+"$OVH_CONSUMER_KEY"+"$HTTP_METHOD"+"$HTTP_QUERY"+"$HTTP_BODY"+"$TIME
SIG='$1$'$(echo -n $CLEAR_SIGN | openssl dgst -sha1 -hex | cut -f 2 -d ' ' )

curl -X $HTTP_METHOD \
$HTTP_QUERY \
-H "Content-Type: application/json" \
-H "X-Ovh-Application: $OVH_APP_KEY" \
-H "X-Ovh-Consumer: $OVH_CONSUMER_KEY" \
-H "X-Ovh-Signature: $SIG" \
-H "X-Ovh-Timestamp: $TIME" \
--data "$HTTP_BODY"
