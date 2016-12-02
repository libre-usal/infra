# Libre-USAL infrastructure

To set up a server and deploy to it:

```
$ ssh user@server
# mkdir -p /etc/libre-usal && cd /etc/libre-usal
# git clone https://github.com/libre-usal/infra /etc/libre-usal/infra
# ^D
$ DEPLOYER=user@server ./deploy.sh
```
