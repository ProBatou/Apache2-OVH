#!/bin/bash

if [[ -z $1 ]]; then
echo -e "missing subdomain"
exit
else

source secret.conf
txt_domain=$txt_domain

$PWD/ovh_delete.sh $1

rm /etc/apache2/sites-enabled/$1.conf

rm /etc/apache2/sites-enabled/$1-le-ssl.conf

certbot revoke --cert-name $txt_domain --delete-after-revoke

certbot certonly --standalone --preferred-challenges http -d $txt_domain

certbot --reinstall --expand

fi
