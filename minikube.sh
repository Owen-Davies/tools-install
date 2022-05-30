#!/bin/bash 
set -e

CMD=minikube
NAME="minikube"

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[35m\e[33m$NAME\e[0m ..."


# Install instructions from the following link, includes WSL2 prerequisites 
# https://www.virtualizationhowto.com/2021/11/install-minikube-in-wsl-2-with-kubectl-and-helm/

git clone https://github.com/DamionGans/ubuntu-wsl2-systemd-script.git ~/source/ubuntu-wsl2-systemd-script/

cd ~/source/ubuntu-wsl2-systemd-script/
bash ubuntu-wsl2-systemd-script.sh

sudo apt install -y conntrack

# Download the latest Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Make it executable
chmod +x ./minikube

# Move it to your user's executable PATH
sudo mv ./minikube /usr/local/bin/

#Set the driver version to Docker
minikube config set driver docker

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"

#Below is the command to set the context to Minikube:
kubectl config use-context minikube
