#!/bin/sh

set -e
set -x

# This is an example script for updating Phabricator, similar to the one used to
# update <https://secure.phabricator.com/>. It might not work perfectly on your
# system, but hopefully it should be easy to adapt. This script is not intended
# to work without modifications.

# NOTE: This script assumes you are running it from a directory which contains
# arcanist/, libphutil/, and phabricator/.

# Note from Ybalrid, This is my spin on this script, it's used to upgrade my 
# instance, it has an hardcoded file path and systemctl calls to restart 
# daemons. I'm using a systemclt script for phd too.

ROOT=/home/vhost/phabricator/ # You can hard-code the path here instead.

### UPDATE WORKING COPIES ######################################################

cd $ROOT/libphutil
git pull

cd $ROOT/arcanist
git pull

cd $ROOT/phabricator
git pull


### CYCLE WEB SERVER AND DAEMONS ###############################################

# Stop daemons.
sudo systemctl stop phd

# If running the notification server, stop it.
# $ROOT/phabricator/bin/aphlict stop

# Stop the webserver (apache, nginx, lighttpd, etc). This command will differ
# depending on which system and webserver you are running: replace it with an
# appropriate command for your system.
# NOTE: If you're running php-fpm, you should stop it here too.

sudo systemctl stop httpd


# Upgrade the database schema. You may want to add the "--force" flag to allow
# this script to run noninteractively.
$ROOT/phabricator/bin/storage upgrade

# Restart the webserver. As above, this depends on your system and webserver.
# NOTE: If you're running php-fpm, restart it here too.
sudo systemctl start httpd

# Restart daemons.
sudo systemctl start phd

# If running the notification server, start it.
# $ROOT/phabricator/bin/aphlict start
