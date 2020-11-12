#!/bin/bash
# A shell script to change the master of a domain in powerDNS en re-sign DNSSEC if TLD supports it.
# Written by: TimVNL
# Set variables
DOMAIN=$1
IP4=$2
IP6=$3
SECTLDS='com|net|org|eu|nl'

# Script
echo "changing master for $DOMAIN to IPv4: $IP4 and IPv6: $IP6"
pdnsutil change-slave-zone-master $DOMAIN $IP4 $IP6
echo ""
echo "Retrieve DNS records for $DOMAIN from the new master"
pdns_control retrieve $DOMAIN
echo ""
if echo ${DOMAIN##*.} | grep -q -E $SECTLDS; then
dnssec_tool re-sign $DOMAIN
else
echo "$DOMAIN does not support DNSSEC skipping..."
fi
echo ""
echo "master for $DOMAIN has changed to $IP4 and IPv6: $IP6"
