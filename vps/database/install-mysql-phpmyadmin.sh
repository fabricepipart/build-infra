if [ -z "$1" ]
then
    echo "MySQL root Password: "
    read -s rootpwdinput
    rootpwd=$(/bin/echo -n $rootpwdinput | base64)
else
    rootpwd=$(/bin/echo -n $1 | base64)
fi

nsinput=${2:-teknichrono}
if [ -z "$2" ]
then
    echo "Namespace: "
    read -s nsinput
fi

if ! kubectl get ns $nsinput &> /dev/null
then
    kubectl create ns $nsinput
else
    echo "Namespace $nsinput exists"
fi


sed "s/BASE64_ROOT_PASSWORD/$rootpwd/g" vps/database/mysql/secret.yml | kubectl -n $nsinput apply -f -
kubectl -n $nsinput apply -f vps/database/mysql/persistentVolumeClaim.yml
kubectl -n $nsinput apply -f vps/database/mysql/deployment.yml
kubectl -n $nsinput apply -f vps/database/mysql/service.yml

if ! kubectl get secret -n $nsinput letsencrypt-certificate
then
    kubectl create secret -n $nsinput tls letsencrypt-certificate --key /etc/letsencrypt/live/teknichrono.fr/privkey.pem --cert /etc/letsencrypt/live/teknichrono.fr/fullchain.pem
fi

kubectl -n $nsinput apply -f vps/database/phpmyadmin/deployment.yml
kubectl -n $nsinput apply -f vps/database/phpmyadmin/service.yml
kubectl -n $nsinput apply -f vps/database/phpmyadmin/ingress.yml

echo "========================================================================================="
echo "Avoid strict date mode"
echo "========================================================================================="
echo "Go to 'phpmyadmin'."
echo "Once phpmyadmin is loaded up, click on the 'variables' tab."
echo "Search for 'sql mode'."
echo "Click on the Edit option and remove NO_ZERO_DATE (and its trailing comma) from the configuration."
read -p "Press [Enter] key when done..."