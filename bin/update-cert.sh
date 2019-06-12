#!/bin/bash

cd /opt/eff.org/certbot/venv
source bin/activate

# Modify me
SITE="example.com"
NAME="example-com-wildcard"
TARGET_PROXY="target-proxy"

# Do not touch
ROOT_PATH="/etc/letsencrypt/live/$SITE"

certbot certonly --dns-google --keep-until-expiring --expand --non-interactive --dns-google-propagation-seconds 120 --dns-google-credentials ~/.secrets/certbot/google.json -d "$SITE,*.$SITE"

UUID=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 4 | head -n 1)
OLD_CERT=$(gcloud compute ssl-certificates list --filter="name~'$NAME'" | sed -n 2p | awk '{print $1}')

echo "Found old cert: $OLD_CERT"

DATE=`date +%m-%Y`
NEW_CERT="$NAME-$DATE-$UUID"

gcloud compute ssl-certificates create $NEW_CERT --certificate "$ROOT_PATH/fullchain.pem" --private-key "$ROOT_PATH/privkey.pem"

gcloud compute target-https-proxies update $TARGET_PROXY --ssl-certificates $NEW_CERT

gcloud compute ssl-certificates delete --quiet $OLD_CERT

deactivate
cd -
