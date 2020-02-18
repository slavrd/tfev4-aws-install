#!/usr/bin/env bash
private_ip=$(curl -sS 'http://169.254.169.254/latest/meta-data/local-ipv4')
public_ip=$(curl -sS 'http://169.254.169.254/latest/meta-data/public-ipv4')
[ -z "$public_ip" ] && public_ip=${private_ip}
./install.sh airgap no-proxy private-address=$private_ip public-address=$public_ip
