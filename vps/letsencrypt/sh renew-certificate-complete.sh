certbot delete

echo =============================================
echo "1. You will now be asked to enter your domain name : *.teknichrono.fr"
echo "2. Go to your DNS management console : https://console.online.net/en/domain/zone/299625"
echo "3. Change the challenge (don't forget the double quotes)"
echo =============================================

sh create-certs.sh || echo "There has been an error but your certificate should be created"

namespaces=$(kubectl get namespaces | grep Active | awk '{print $1}')
for ns in $namespaces
do
	echo "Secret in $ns"
	kubectl delete --ignore-not-found=true secret -n $ns letsencrypt-certificate
	kubectl create secret -n $ns tls letsencrypt-certificate --key /etc/letsencrypt/live/teknichrono.fr/privkey.pem --cert /etc/letsencrypt/live/teknichrono.fr/fullchain.pem
	echo "--"
done