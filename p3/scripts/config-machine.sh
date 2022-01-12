#!/bin/bash
echo "Configuring machine..."

apt-get update 

echo "Installing packages..."

# install docke

echo "Configuring docker..."

apt-get install -y docker.io

# #install k3d

echo "Configuring k3d..."

curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash


# #install kubectl

echo "Configuring kubectl..."

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# # create a cluster

echo 'Creating a cluster...'

k3d cluster create mmeski --api-port 6443 -p 80:80@loadbalancer

# # create a namespace argocd

echo 'Creating a namespace argocd...'

kubectl create namespace argocd

# #install argocd yaml file in the namespace

echo 'Installing argocd yaml file in the namespace...'

kubectl apply -f argocd.yml -n argocd

# # install ingress controller 

echo 'Installing ingress controller...'

kubectl apply -f ingress.yml -n argocd 

# # modify argocd Password 

kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$12$jhhnO8A482jMs5pDQVOwH.aNxnDgJ6pe3oukrz9lGgRnL.edHuHEq",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'

# #creat a namespace dev

kubectl create ns dev

# # Deploy argo project

kubectl apply -f project.yaml -n argocd