# Apache2-OVH
Add or remove CNAME for apache and OVHcloud


### Configuration

Create secret.conf file with ovh token

```sh
OVH_CONSUMER_KEY="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
OVH_APP_KEY="XXXXXXXXXXXXXXXX"
OVH_APP_SECRET="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
txt_domain="DOMAIN.com"
txt_target="DOMAIN.com."
```

### Use

```sh
./apache2-ovh.sh "add|del" "CNAME"
```