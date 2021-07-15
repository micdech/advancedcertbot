#!/bin/bash

#### 15/07/2021 letencrypt non funziona attualmente per le wildcard. utilizzare lego + acme-dns
#### Questo script inoltre è ottimizzato per il passaggio ulteriore
#### di rendere il certificato creato da lego, disponibile su haproxy
echo @@@@@ inizio script @@@@@
#echo `service haproxy stop`
#echo @@@@@ chiusura del server haproxy @@@@@

CERTFOLDER=###put your certfolder###
TODAY=`date +%Y%m%d`

echo @@@@@ Inizio procedura in data $TODAY @@@@@
echo certbot certonly --standalone

echo `ACME_DNS_API_BASE=https://auth.acme-dns.io ACME_DNS_STORAGE_PATH=###put your path to save json (generally: /home/user/.lego-acme-dns-accounts.json)### lego --email ###your@email.com### --dns acme-dns -accept-tos --pem --domains *.example.com --domains example.com run`
echo "chiamo lego"
echo `cat /root/.lego/certificates/_.example.com.pem > $CERTFOLDER/example.com.pem`
echo "scrivo il pem"
echo $CERTFOLDER/example.com.pem >> $CERTFOLDER/certs.txt
echo `service haproxy reload`

echo @@@@@ eseguo reload del server haproxy @@@@@
echo @@@@@ fine script @@@@@
