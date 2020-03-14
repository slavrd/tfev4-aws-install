#!/usr/bin/env bash
private_ip=$(curl -sSf 'http://169.254.169.254/latest/meta-data/local-ipv4')
[ -z "$private_ip" ] && exit 1
public_ip=$(curl -sSf 'http://169.254.169.254/latest/meta-data/public-ipv4')
[ -z "$public_ip" ] && public_ip=${private_ip}
./install.sh airgap no-proxy private-address=${private_ip} public-address=${public_ip}
