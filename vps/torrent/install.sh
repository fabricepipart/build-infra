
echo "========================================================================================="
echo "Namespace"
echo "========================================================================================="

kubectl create ns seedbox


echo "========================================================================================="
echo "Certificate secret"
echo "========================================================================================="
if ! kubectl get secret -n seedbox letsencrypt-certificate
then
    kubectl create secret -n seedbox tls letsencrypt-certificate --key /etc/letsencrypt/live/teknichrono.fr/privkey.pem --cert /etc/letsencrypt/live/teknichrono.fr/fullchain.pem
fi

kubectl -n seedbox apply -f vps/torrent/persistentVolumeClaim.yml
kubectl -n seedbox apply -f vps/torrent/rutorrent.yaml