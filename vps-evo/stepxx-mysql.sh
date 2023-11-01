#!/bin/sh
set -e

# --- microk8s
apt update -y
apt upgrade -y
apt install -y snapd git proftpd
snap install microk8s --classic
snap alias microk8s.kubectl kubectl
snap alias microk8s.kubectl k
microk8s.enable dns dashboard storage ingress
apt install -y certbot 




apt install -y epel-release
systemctl enable --now snapd
systemctl enable --now snapd.socket
systemctl enable --now snapd.seeded.service
ln -s /var/lib/snapd/snap /snap
export PATH=$PATH:/var/lib/snapd/snap/bin
echo "========================================================================================="
echo "You need to reload your shell bash to have alias kubectl and microk8s commands to work."
echo "Or you can enhance your PATH using:"
echo ""
echo "    export PATH=$PATH:/var/lib/snapd/snap/bin"
echo ""
echo "Don't forget to enable needed microk8s addons (dns, ingress, dashboard, ...) with microk8s.enable"



echo "========================================================================================="
echo "Installing kubeconfig locally"
echo "========================================================================================="
sh vps/kubeconfig/setup-k8.sh

echo "========================================================================================="
echo "Installing dashboard"
echo "========================================================================================="
sh vps/dashboard/k8-dashboard-ingress.sh

echo "========================================================================================="
echo "Installing MySQL"
echo "========================================================================================="
sh vps/database/install-mysql-phpmyadmin.sh
