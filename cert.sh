#!/bin/bash

echo ######## inizio script #########

USER=***PUT YOU USER HERE*** ;generally root
PASSWORD=***PUT YOUR PASSWORD HERE***
DATABASE=***PUT YOUR DBNAME HERE***
HOST=***PUT YOUR DBHOST HERE***
CERTFOLDER=/etc/haproxy/certs
TODAY=`date +%Y%m%d`

echo ######## Inizio procedura in data `$TODAY` ########
#echo certbot certonly --standalone 

echo ######## copio la catella dei vecchi certificati #########
echo `cp -r $CERTFOLDER $CERTFOLDER'_'$TODAY`

echo ######## rimuovo i certificati vecchi dalla cartella `$CERTFOLDER` #########
echo `rm -r $CERTFOLDER'/*'`

echo ######## Inizio procedura di creazione certificati ########
for d in `mysql -u$USER -p$PASSWORD -h $HOST -D $DATABASE -e "select domain from wp_domain_mapping"`
do
	if [ $d != 'domain' ];
		then
			#echo `letsencrypt certonly --standalone -d $d`
			#echo `./certbot-auto certonly --server https://acme-v02.api.letsencrypt.org/directory -d $d -d www.$d`
			echo `certbot certonly --standalone -d $d -d www.$d`
			#echo -d $d -d www.$d  
			echo `cat /etc/letsencrypt/live/$d/fullchain.pem /etc/letsencrypt/live/$d/privkey.pem > /etc/haproxy/certs/$d.pem`
			echo `/etc/haproxy/certs/$d.pem` > `/etc/haproxy/certs/certs.txt`
	fi
done

#echo `cat /etc/letsencrypt/live/*/*.* > /etc/haproxy/certs/certs.pem`

echo ######## fine script ########
