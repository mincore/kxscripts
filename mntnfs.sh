#!/bin/bash

NFSIP=`echo $SSH_CLIENT | cut -d ' ' -f 1`

if [ -z ""$NFSIP ]; then
    exit
fi

sudo mount -t nfs $NFSIP:/f/src /home/csp/win -o tcp,nolock
