#!/bin/bash

if [[ -z $1 ]]; then
echo -e "missing subdomain argument"
exit
else

source secret.conf
txt_domain=$txt_domain

$PWD/ovh_add.sh $1

sed "s/subdomain/$1/ ; s/domain.ext/$txt_domain/" $PWD/template.conf > /etc/apache2/sites-enabled/$1.conf

certbot --reinstall --expand --test-cert

#nano /etc/apache2/sites-enabled/$1-le-ssl.conf

fi
