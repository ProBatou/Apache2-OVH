#!/bin/bash

source secret.conf
txt_domain=$txt_domain

if [[ -z $1 ]]; then
    echo -e "missing add or delete argument"
    exit
elif [[ -z $2 ]]; then
    echo -e "missing subdomain argument"
    exit
else
    if [[ $1 == "add" ]]; then
        $PWD/ovh_add.sh $1
        sed "s/subdomain/$2/ ; s/domain.ext/$txt_domain/" $PWD/template.conf > /etc/apache2/sites-enabled/$2.conf
        certbot --reinstall --expand --test-cert
        nano /etc/apache2/sites-enabled/$2-le-ssl.conf
    elif [[ $1 == "del" ]]; then
        $PWD/ovh_delete.sh $2
        rm /etc/apache2/sites-enabled/$2.conf
        rm /etc/apache2/sites-enabled/$2-le-ssl.conf
        certbot revoke --cert-name $txt_domain --delete-after-revoke
        certbot certonly --standalone --preferred-challenges http -d $txt_domain
        certbot --reinstall --expand
    else
        echo -e "unrecognized argument"
        exit
    fi
fi