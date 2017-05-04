#!/bin/bash

# Ce script teste le header d'un serveur web
# Il prend en argument une url : exemple: ./testHeaders google.fr.
# KO si il detecte la version du serveur
# KO s'il detecte la version du langage
# OK sinon


clear

echo "#############################"
echo "##### Begin of the test #####"
echo "#############################"


HOST=$1

if  [[ $# == 0 ]]; then
	echo "Please give a host."
	read domain
	HOST=$domain
else
	if [[ $# == 1 ]]; then
		HOST=$1
		echo "Host is " $HOST
	fi
fi
echo "Testing $HOST"
SERVER_TAG=$(wget --server-response --spider $HOST 2>&1 | grep "Server")
SERVER=$(echo "$SERVER_TAG" | cut -d: -f2 )
if [[ "$SERVER" == *"/"* ]];then
	SERVER_VERSION=$(echo "$SERVER" | cut -d/ -f2 )
else
	SERVER_VERSION=''
fi
PHP=$(wget --server-response --spider $HOST 2>&1 | grep "PHP/" | cut -d: -f2 )
PHP_VERSION=$(wget --server-response --spider $HOST 2>&1 | grep "PHP/" | cut -d/ -f2 )
echo $SERVER_TAG
echo $SERVER
echo $SERVER_VERSION
echo $PHP
echo $PHP_VERSION
if  [ "$SERVER_VERSION" != '' ];then
	echo "Bad ! Server version detected $SERVER_VERSION"
	exit 1
fi
if [ "$PHP_VERSION" != '' ];then
	echo "Bad ! PHP version detected $PHP_VERSION"
	exit 1
else
	echo "Good ! No version founded"
	exit 0
fi