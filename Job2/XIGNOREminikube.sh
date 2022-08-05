sudo apt update
sudo apt install apt-transport-https
sudo apt upgrade
sudo apt install virtualbox virtualbox-ext-pack
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube
minikube version

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl

minikube start

kubectl cluster-info

kubectl config view



# https://computingforgeeks.com/how-to-install-minikube-on-ubuntu-debian-linux/