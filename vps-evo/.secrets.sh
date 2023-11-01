#!/usr/bin/env bash

TORRENTS_USER=USER
TORRENTS_PASSWORD=PASSWORD











if cat $0 | grep '[A-Z_-]\+=[A-Z_-]\+' | cut -d'=' -f2 | grep 'PASSWORD' >& /dev/null
then
    echo "Please modify $0 so that it contains real passwords"
    false
else
    echo "Password variables loaded"
fi
