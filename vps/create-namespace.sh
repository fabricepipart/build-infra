
echo "========================================================================================="
echo "Create namespace"
echo "========================================================================================="
nsinput=$1
if [ -z "$nsinput" ]
then
    echo "Namespace: "
    read nsinput
fi

if ! kubectl get ns $nsinput &> /dev/null
then
    kubectl create ns $nsinput
else
    echo "Namespace $nsinput exists"
fi

if [ -z "$2" ]
then
    echo "MySQL Password: "
    read -s pwdinput
    mysqlpwd=$(/bin/echo -n $pwdinput | base64)
else
    mysqlpwd=$(/bin/echo -n $2 | base64)
fi

echo "========================================================================================="
echo "MySQL secret"
echo "========================================================================================="
sed "s/BASE64_PASSWORD/$mysqlpwd/g" vps/database/mysql/ns-secret.yml | kubectl -n $nsinput apply -f -

echo "========================================================================================="
echo "Certificate secret"
echo "========================================================================================="
if ! kubectl get secret -n $nsinput letsencrypt-certificate
then
    kubectl create secret -n $nsinput tls letsencrypt-certificate --key /etc/letsencrypt/live/teknichrono.fr/privkey.pem --cert /etc/letsencrypt/live/teknichrono.fr/fullchain.pem
fi

echo "========================================================================================="
echo "Overlay"
echo "========================================================================================="
echo "Please create a new overlay in src/main/k8/overlays and specify the new URL"
read -p "Press [Enter] key when done..."

echo "========================================================================================="
echo "New stage"
echo "========================================================================================="
echo "Please add a new stage in .travis.yml and specify the right namespace"
read -p "Press [Enter] key when done..."

echo "========================================================================================="
echo "Create a new database"
echo "========================================================================================="
echo "Please add a new database"
echo "- Click new in the top left"
echo "- Create a new database named after the namespace with collation utf8_general_ci"
echo "- Go to Home page / User accounts / teknichrono / Edit privileges / Database"
echo "- Select the new database"
echo "- Check All"
echo "- Go"
read -p "Press [Enter] key when done..."

