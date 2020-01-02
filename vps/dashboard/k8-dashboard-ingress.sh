kubectl -n kube-system apply -f vps/dashboard/k8-dashboard-ingress.yml


token=$(kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
kubectl -n kube-system describe secret $token

echo "-------------------------------------"
echo "Please note the Dashboard token above"
read -p "Press [Enter] key when done..."