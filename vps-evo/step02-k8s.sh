#!/bin/sh
set -e

# --- microk8s
apt update -y
apt upgrade -y
apt install -y snapd git proftpd apache2-utils
snap install microk8s --classic
snap alias microk8s.kubectl kubectl
snap alias microk8s.kubectl k
microk8s.enable dns dashboard storage ingress
apt install -y certbot 

echo "========================================================================================="
echo "Installing kubeconfig locally"
echo "========================================================================================="
microk8s.config > ~/.kube/config

# https://microk8s.io/docs/addon-cert-manager
microk8s enable cert-manager
microk8s kubectl apply -f - <<EOF
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
 name: lets-encrypt
spec:
 acme:
   email: fabrice.pipart+letsencrypt@gmail.com
   server: https://acme-v02.api.letsencrypt.org/directory
   privateKeySecretRef:
     # Secret resource that will be used to store the account's private key.
     name: lets-encrypt-priviate-key
   # Add a single challenge solver, HTTP01 using nginx
   solvers:
   - http01:
       ingress:
         class: public
EOF

sleep 5
microk8s kubectl get clusterissuer -o wide

# DNS Challenge was not needed
# https://github.com/scaleway/cert-manager-webhook-scaleway