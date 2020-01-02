#!/bin/sh
set -e

# --- microk8s
yum update -y
yum install -y epel-release
yum install -y snapd git proftpd
systemctl enable --now snapd
systemctl enable --now snapd.socket
systemctl enable --now snapd.seeded.service
ln -s /var/lib/snapd/snap /snap
export PATH=$PATH:/var/lib/snapd/snap/bin
snap install microk8s --classic
snap alias microk8s.kubectl kubectl

echo "========================================================================================="
echo "You need to reload your shell bash to have alias kubectl and microk8s commands to work."
echo "Or you can enhance your PATH using:"
echo ""
echo "    export PATH=$PATH:/var/lib/snapd/snap/bin"
echo ""
echo "Don't forget to enable needed microk8s addons (dns, ingress, dashboard, ...) with microk8s.enable"

microk8s.enable dns dashboard storage ingress

yum install -y certbot 

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
