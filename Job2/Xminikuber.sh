#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo apt install apt-transport-https -y
sudo apt upgrade -y
sudo apt install virtualbox virtualbox-ext-pack -y
sudo wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo chmod +x /home/ubuntu/minikube-linux-amd64
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x /home/ubuntu/kubectl
sudo cp kubectl /usr/local/bin/kubectl
sudo usermod -aG docker ubuntu
minikube start
sudo apt install git -y
git init
git clone https://github.com/devops-parth/pyterrakube.git
sudo apt-get update -y
cd pyterrakube/
kubectl apply -f deployment.yml
kubectl apply -f service.yml
