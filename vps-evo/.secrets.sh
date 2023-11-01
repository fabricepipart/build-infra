#!/usr/bin/env bash

TORRENTS_USER=USER
TORRENTS_PASSWORD=ASSWORD





SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
MYSELF=$SCRIPT_DIR/.secrets.sh
if cat $MYSELF | grep '[A-Z_-]\+=[A-Z_-]\+' | cut -d'=' -f2 | grep 'PASSWORD' >& /dev/null
then
    echo "Please modify $MYSELF so that it contains real passwords"
    exit
else
    echo "Password variables loaded"
fi
