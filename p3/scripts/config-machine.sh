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

k3d cluster create my-cluster --api-port 6443 -p 80:80@loadbalancer

# # create a namespace argocd

echo 'Creating a namespace argocd...'

kubectl create namespace argocd

# #install argocd yaml file in the namespace

echo 'Installing argocd yaml file in the namespace...'

kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -n argocd

# # install ingress controller 

echo 'Installing ingress controller...'

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml -n argocd 

