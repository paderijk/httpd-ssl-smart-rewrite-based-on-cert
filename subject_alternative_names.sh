#!/bin/bash
#
# Written by Pieter de Rijk - https;//github.com/paderjk
#
# Up to date information available on:
#        https://github.com/paderijk/httpd-ssl-smart-rewrite-based-on-cert
#

CERT_FILE=/etc/httpd/conf/ssl.crt/server.crt
NAME_SPOOL="/var/spool/pki/san/"
CURRENT_DATE=$(date)
if [ ! -d $NAME_SPOOL ];
then
    echo "[I] Creating Spool file $NAME_SPOOL"
    mkdir -p $NAME_SPOOL
fi

echo "[I] Clean spool content"
rm -f $NAME_SPOOL/*-san
echo "[I] Populating spool content based in $CERT_FILE"
for x in $(openssl x509 -text -noout -in $CERT_FILE | grep DNS | sed -e 's/DNS://g' -e 's/, / /g');
do
    echo "  [I] \"$x\" is in certificate"
    echo $CURRENT_DATE > $NAME_SPOOL/$x-san
done
