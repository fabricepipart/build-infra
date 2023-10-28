# New

Try `sh renew-certificate-complete.sh`


# To renew

```
certbot delete
sh create-certs.sh
```
# Manual steps

* You re asked the domain name : `*.teknichrono.fr`
* Go to the DNS management console `https://console.online.net/en/domain/zone/299625` and change the challenge (don't forget the double quotes)
* Save new version
* Type Enter

```
sh renew-certificate.sh
```

Done!