#!/bin/sh
set -e


# https://argo-cd.readthedocs.io/en/stable/getting_started/
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64



# https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#kubernetesingress-nginx
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
 name: argocd-server-ingress
 namespace: argocd
 annotations:
   cert-manager.io/cluster-issuer: lets-encrypt
   nginx.ingress.kubernetes.io/ssl-passthrough: "true"
   nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
spec:
 tls:
 - hosts:
   - argocd.evo.teknichrono.fr
   secretName: argocd-ingress-tls
 rules:
 - host: argocd.evo.teknichrono.fr
   http:
     paths:
     - backend:
         service:
           name: argocd-server
           port:
             name: https
       path: /
       pathType: Prefix
EOF

argocd admin initial-password -n argocd
argocd login argocd.evo.teknichrono.fr
argocd account update-password

argocd cluster add microk8s

kubectl config set-context --current --namespace=argocd
argocd app create root --repo https://github.com/fabricepipart/build-infra --path vps-evo/argo/root --directory-recurse --sync-policy auto --auto-prune --self-heal --dest-name in-cluster --dest-namespace argocd