if kubectl get secret -n kube-system letsencrypt-certificate
then
    kubectl delete secret -n kube-system letsencrypt-certificate
    certbot delete
else
    echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew" | sudo tee -a /etc/crontab > /dev/null
fi

certbot certonly --manual --preferred-challenges dns --manual-public-ip-logging-ok
# Your certificate and chain have been saved at:    /etc/letsencrypt/live/teknichrono.fr/fullchain.pem
# Your key file has been saved at:    /etc/letsencrypt/live/teknichrono.fr/privkey.pem
kubectl create secret -n kube-system tls letsencrypt-certificate --key /etc/letsencrypt/live/teknichrono.fr/privkey.pem --cert /etc/letsencrypt/live/teknichrono.fr/fullchain.pem
