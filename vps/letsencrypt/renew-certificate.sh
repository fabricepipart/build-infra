namespaces=$(kubectl get namespaces | grep Active | awk '{print $1}')
for ns in $namespaces
do
	echo "Secret in $ns"
	kubectl delete --ignore-not-found=true secret -n $ns letsencrypt-certificate
	kubectl create secret -n $ns tls letsencrypt-certificate --key /etc/letsencrypt/live/teknichrono.fr/privkey.pem --cert /etc/letsencrypt/live/teknichrono.fr/fullchain.pem
	echo "--"
done