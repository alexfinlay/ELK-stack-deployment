#!/bin/bash
echo "Hello $($USER) it is: $(date)"
echo "Uname info: $(uname)"
echo "IP Addresses: $(ip addr|grep 'inet ')"
echo "Hostname: $(hostname)"
echo "DNS: $(grep 'nameserver ' /etc/resolv.conf)"