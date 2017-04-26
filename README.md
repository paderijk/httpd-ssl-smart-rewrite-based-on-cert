# Smart HTTPD Rewrites to https

## About

This script and settings are developed because on an VPS I run multiple websites, which do or do not have an SSL-Certificate.

## Prerequisites

* Apache webserver
* SSL Certificate using `X509v3 Subject Alternative Name` (for example from [LetsEncrypt](https://letsencrypt.org/))
* Ensure the locations/paths in the scripts/config are reflecting your set up

## How to use it

### Apache configuration

Ensure the `smart-rewrite.conf` file is included in your virtualhosts:

```
# ...
# Include smart-rewrite.conf
Include /etc/httpd/conf/extra/smart-rewrite.conf
# ...
```

Ensure you restart the webserver to make the 

### Run the script

Run the script `subject_alternative_names.sh` to populate the spool-directory after you requested/received a new certificate.

## Potential issues

I can think of some potential issues:
* SELinux is blocking apache for checking the spool-file
* The Certificate is not using `X509v3 Subject Alternative Name`
