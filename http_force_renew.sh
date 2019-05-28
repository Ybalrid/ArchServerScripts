#!/bin/bash
set -x #echo on 

systemctl stop httpd

certbot renew $1

systemctl start httpd

systemctl stop prosody
echo "updating certificates for prosody server"
cp /etc/letsencrypt/live/ybalrid.info/privkey.pem /var/lib/prosody/xmpp_ybalrid.key
cp /etc/letsencrypt/live/ybalrid.info/fullchain.pem /var/lib/prosody/xmpp_ybalrid.crt
chown -R prosody:prosody /var/lib/prosody/*.crt /var/lib/prosody/*.key
echo "done" 
systemctl start prosody


