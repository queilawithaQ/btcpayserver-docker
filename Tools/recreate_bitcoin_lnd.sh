#!/bin/bash

set -e

read -p "This script will delete and recreate your LND Bitcoin container. THIS OPERATION IS NOT UNDOABLE, ALL FUNDS THAT YOU CURRENTLY HAVE ON THIS LND WILL BE LOST! Type 'yes' to proceed only after you've transfered all your funds from this LND instance `echo $'\n> '`" yn
if [ $yn != "yes" ]; then
	exit 0
fi

read -p "Only proceed if you've removed all the funds from LND Bitcoin container! This LND instance will be completely deleted and all data from it unrecoverable. Type 'yes' to proceed only if you are 100% sure `echo $'\n> '`" yn
if [ $yn != "yes" ]; then
	exit 0
fi

read -p "OK, last chance to abort. Type 'yes' to continue! `echo $'\n> '`" yn
if [ $yn != "yes" ]; then
	exit 0
fi

../btcpay-down.sh

docker volume rm --force generated_lnd_bitcoin_datadir

../btcpay-up.sh

echo "LND container recreated"