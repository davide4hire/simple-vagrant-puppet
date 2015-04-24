#!/bin/bash

factDir="/etc/facter/facts.d"

if [ ! -d $factDir ] ; then
    mkdir -p $factDir
fi
cat >$factDir/sorry-servers.txt <<EOF
sorry_generic_eu=192.168.33.20
sorry_blank=192.168.33.21
EOF
