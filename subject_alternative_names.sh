#!/bin/bash
#
# Written by Pieter de Rijk - https;//github.com/paderjk
#
# Up to date information available on:
#        https://github.com/paderijk/httpd-ssl-smart-rewrite-based-on-cert
#

# Certificate file to use
CERT_FILE=/etc/httpd/conf/ssl.crt/server.crt

# Location of the SPOOL
SPOOL_PATH="/var/spool/pki/san/"

# Use current date so in the spool-dir you can see once it was updated
CURRENT_DATE=$(date)
if [ ! -d $SPOOL_PATH ];
then
    echo "[I] Creating Spool file $SPOOL_PATH"
    mkdir -p $SPOOL_PATH
fi

# Clean current content of the spool
# so changes (additions, but especially deletion) 
# are reflected correctly
echo "[I] Clean spool content"
rm -f $SPOOL_PATH/*-san

# Populate the spool
echo "[I] Populating spool content based in $CERT_FILE"
for x in $(openssl x509 -text -noout -in $CERT_FILE | grep DNS | sed -e 's/DNS://g' -e 's/, / /g');
do
    echo "  [I] \"$x\" is in certificate"
    echo $CURRENT_DATE > $SPOOL_PATH/$x-san
done
