#!/bin/bash
sudo su
export K3S_TOKEN_FILE=/vagrant/token
export K3S_URL=https://192.168.42.110:6443
export INSTALL_K3S_EXEC="--flannel-iface=eth1"
curl -sfL https://get.k3s.io | sh -