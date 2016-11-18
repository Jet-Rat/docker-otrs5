#!/bin/bash

/usr/sbin/apache2ctl -k graceful
echo $(date) ok > /tmp/tmp.tmp
