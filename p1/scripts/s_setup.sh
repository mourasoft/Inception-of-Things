#!/bin/bash
sudo su 
echo "instaling k3s"
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - --flannel-iface=eth1
echo "sleep 5s"
sleep 5
echo ""
sudo cat /var/lib/rancher/k3s/server/token > /home/vagrant/token
