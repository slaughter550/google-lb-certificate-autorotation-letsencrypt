Google Load Balancer Auto Update for Wildcard SSL Certificates
=====================

This script provides the ability to automate the rotation of Google Load Balancer target proxy endpoints. The goal of this script is to enable the stable deployment of ["LetsEncrypt"](https://letsencrypt.org) wildcard SSL Certificates to a staging or production environment.

Requirements
----
* [Google Cloud Account](https://cloud.google.com)
* [Google Cloud Service Account](https://cloud.google.com/iam/docs/creating-managing-service-accounts)
* [LetsEncrypt](https://letsencrypt.org)
* [CertBot DNS Plugin](https://certbot-dns-google.readthedocs.io)
* NS Records pointed to [Google Cloud DNS](https://cloud.google.com/dns/docs/migrating)

Setup
----
1. Clone repo locally
2. Edit the variables `SITE`, `NAME` and `TARGET_PROXY` inside of [update-cert.sh](update-cert.sh#7-9) to configure the domain
3. Edit `crontab -e` and a daily record to perform the update.
> A scheduler is recommended for prod envs. This is just a bootstrap example.
```
0 0 * * * /root/update-cert.sh >> /root/logs/cron 2>&1
```
4. Enjoy having auto-updated wildcard certs on GCP!
