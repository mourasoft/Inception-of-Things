#!/bin/bash

sudo su 
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s - --flannel-iface=eth1