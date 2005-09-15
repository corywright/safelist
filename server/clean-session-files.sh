#!/bin/sh

# remove rails session files older than 24 hours
find /tmp -mtime +1 -a -name 'ruby_sess*' -exec rm -f {} \;
