#!/bin/bash
set -x #echo on 

#We are using certbot standalone and it will need access to port 80
systemctl stop httpd
certbot renew $1
systemctl start httpd

#Prosody uses one of theses certificates, keep it up to date
systemctl stop prosody
echo "updating certificates for prosody server"
cp /etc/letsencrypt/live/ybalrid.info/privkey.pem /var/lib/prosody/xmpp_ybalrid.key
cp /etc/letsencrypt/live/ybalrid.info/fullchain.pem /var/lib/prosody/xmpp_ybalrid.crt
chown -R prosody:prosody /var/lib/prosody/*.crt /var/lib/prosody/*.key                  #prosody needs to be able to open theses files
echo "done" 
systemctl start prosody
