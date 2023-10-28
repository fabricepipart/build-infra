https://microk8s.io/docs/
https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7
https://hackernoon.com/setting-up-nginx-ingress-on-kubernetes-2b733d8d2f45
https://kubernetes.github.io/ingress-nginx/troubleshooting/
https://tutorials.ubuntu.com/tutorial/install-a-local-kubernetes-with-microk8s#3
https://www.serverlab.ca/tutorials/containers/kubernetes/deploy-phpmyadmin-to-kubernetes-to-manage-mysql-pods/
https://www.serverlab.ca/tutorials/containers/kubernetes/how-to-deploy-mysql-server-5-7-to-kubernetes/
https://kubernetes.io/blog/2018/05/29/introducing-kustomize-template-free-configuration-customization-for-kubernetes/
https://github.com/kubernetes-sigs/kustomize


kubectl get namespace "stucked-namespace" -o json \
            | tr -d "\n" | sed "s/\"finalizers\": \[[^]]\+\]/\"finalizers\": []/" \
            | kubectl replace --raw /api/v1/namespaces/stucked-namespace/finalize -f -