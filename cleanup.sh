#!/bin/bash

#TODO there's a problem with journald on this system taking too much ram,
#something is probalby spamming the logs... Instead of fixing the issue,
#just cleanup things
date >> ~/cleanup_log
systemctl restart systemd-journald
swapoff -a
swapon -a
free -h >> ~/cleanup_log
