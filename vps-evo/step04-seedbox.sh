#!/bin/sh
set -e

# https://hub.docker.com/r/diameter/rtorrent-rutorrent


source $(dirname -- "$0")/.secrets.sh

podname=$(kubectl get po -n seedbox -o name | grep rtorrent)
kubectl exec -it $podname -n seedbox -- bash -c "echo '"$TORRENTS_USER":$(openssl passwd -1 "$TORRENTS_PASSWORD")' > /downloads/.htpasswd"

TORRENTS_HTPWD=$(htpasswd -n -b $TORRENTS_USER $TORRENTS_PASSWORD)
kubectl create secret -n seedbox generic seedbox-credentials \
    --from-literal=TORRENTS_USER=$TORRENTS_USER \
    --from-literal=TORRENTS_PASSWORD=$TORRENTS_PASSWORD \
    --from-literal=TORRENTS_HTPWD=$TORRENTS_HTPWD

