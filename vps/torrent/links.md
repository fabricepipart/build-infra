https://hub.docker.com/r/diameter/rtorrent-rutorrent
https://github.com/linuxserver/docker-rutorrent
https://github.com/ArchiFleKs/containers/blob/master/kubernetes/zero.vsense.fr/seedbox/rtorrent.yml

# DNS issue

https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
```kubectl exec -i -t dnsutils -- nslookup kubernetes.default```

https://github.com/kubernetes/kubernetes/issues/21613
```echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables```