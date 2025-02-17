#!/usr/bin/env bash

subscription-manager status


subscription-manager register --username=effiovadia --password=eXye4PJloRsdhCcmJijk

#@ Verify repositories are enabled
subscription-manager repos --list-enabled
#@ Add repo if not exist
sudo subscription-manager repos --enable=rhel-8-server-rpms


#@ Check for updates
sudo yum check-update

#@ Verify content access
sudo yum update -y ca-certificates
sudo update-ca-trust
ls -lh /etc/pki/tls/certs/ca-bundle.crt

echo | openssl s_client -showcerts -servername cdn.redhat.com -connect cdn.redhat.com:443 2>/dev/null | awk '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/' > /etc/pki/ca-trust/source/anchors/redhat-entitlement-master-ca.crt


curl -v https://cdn.redhat.com

#@ Confirm Simple Content Access (You should see: simple_content_access = 1)
subscription-manager config --list | grep -i simple

#@ revert to raditional subscription model
#subscription-manager config --set=auto-attach=false
#subscription-manager unregister
#subscription-manager register --username=<your_username> --password=<your_password> --auto-attach


subscription-manager attach --pool=2c948adb93444a6e019399e3cd490012

curl -v --cert /etc/pki/entitlement/8775866342582188678.pem --key /etc/pki/entitlement/8775866342582188678-key.pem https://cdn.redhat.com

curl -v --cert /etc/pki/entitlement/8775866342582188678.pem \
    --key /etc/pki/entitlement/8775866342582188678-key.pem \
    -H "User-Agent: libdnf (Red Hat Enterprise Linux 9.5; generic; Linux.x86_64)" \
    -H "Referer: https://cdn.redhat.com/content/" \
    -H "Authorization: Bearer <your_token_here>" \
    -H "X-RH-IDENTITY: <your_base64_encoded_identity>" \
    https://cdn.redhat.com
