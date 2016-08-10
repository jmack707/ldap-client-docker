#!/bin/bash

if [ "$LDAP_SSL" == "true" ]; then
    if [ ! "$(ls -A /ssl)" ]; then
        echo "No SSL certificates found,"
        echo -e "dont forget to run:\nchown 76:70 private.pem\nchmod 'og=-rwx' private.pem"
        exit 1
    fi
    echo "copy public keys to /etc/pki/trust/anchors/ and update trusted certificates"
    cp /ssl/*public* /etc/pki/trust/anchors/
    /usr/sbin/update-ca-certificates -f -v
else
    sed -i "s/port 636/port 389/g" /etc/ldap.conf
    sed -i "s/^ssl on$/ssl off/g" /etc/ldap.conf
    sed -i "s/^tls_.*$//g" /etc/ldap.conf
    sed -i "s/port 636/port 389/g" /etc/ldap.conf
fi

sed -i "s/^host.*$/host $LDAP_HOST/g" /etc/ldap.conf
sed -i "s/^base.*$/base $LDAP_BASE/g" /etc/ldap.conf

exec $@
