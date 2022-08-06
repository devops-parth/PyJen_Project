```
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
```

## ====================================================

```
apt-get install docker.io

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client -o json

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_1.6.2.deb  && sudo dpkg -i minikube_1.6.2.deb

sudo minikube config set vm-driver none
sudo minikube start &  


sudo minikube status
	host: Running
	kubelet: Running
	apiserver: Running
	kubeconfig: Configured
```
