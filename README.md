# PyJen_Project
Running Python App with SonarQube &amp; Jenkins

## System

- t2.medium
- roles: EC2
- SG: port 22, 8080, 9000
- Jenkins>> ip:8080
- Sonarqube>> ip:9000
```
visudo
ubuntu  ALL=(ALL:ALL) NOPASSWD: ALL
nano /etc/ssh/sshd_config
PermitRootLogin yes
PasswordAuthentication no
```

ubuntu@ip-172-31-19-112:~$ sudo visudo
ubuntu@ip-172-31-19-112:~$ sudo nano /etc/ssh/sshd_config
ubuntu@ip-172-31-19-112:~$ sudo systemctl restart sshd
ubuntu@ip-172-31-19-112:~$ sudo systemctl restart sshd

## Docker
ubuntu@ip-172-31-19-112:~$ nano docker.sh
```
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo systemctl status docker
sudo usermod -aG docker ${USER}
```
ubuntu@ip-172-31-19-112:~$ bash docker.sh

# DockerCompose
ubuntu@ip-172-31-19-112:~$ nano doccom.sh
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
 
mkdir compose-dir
cd compose-dir
 
docker-compose --version
```
ubuntu@ip-172-31-19-112:~$ bash doccom.sh

# Docker Compose YAML
ubuntu@ip-172-31-19-112:~$ docker-compose.yml
```
version: '2'
 
services:
 
  sonarqube:
    image: sonarqube:7.6-community
    volumes:
      - sonarqube_conf:/opt/sonarqube/conf
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions
      - sonarqube_bundled-plugins:/opt/sonarqube/lib/bundled-plugins
    networks:
      - sonarnet
    ports:
      - '9000:9000'
    environment:
      - sonar.jdbc.username=sonar
      - sonar.jdbc.password=sonar
      - sonar.jdbc.url=jdbc:postgresql://db:5432/sonar
 
  db:
    image: postgres
    networks:
      - sonarnet
    environment:
      - POSTGRES_USER=sonar
      - POSTGRES_PASSWORD=sonar
    volumes:
      - postgresql:/var/lib/postgresql
      - postgresql_data:/var/lib/postgresql/data
 
networks:
  sonarnet:
    driver: bridge
 
volumes:
  sonarqube_conf:
  sonarqube_data:
  sonarqube_extensions:
  sonarqube_bundled-plugins:
  postgresql:
  postgresql_data:
  jenkins_data:
```
ubuntu@ip-172-31-19-112:~$ sudo docker-compose up -d
ubuntu@ip-172-31-19-112:~$ docker ps
root@ip-172-31-19-112:~# docker logs 9dcf50d5813f
docker exec -it containerID bash
root@ip-172-31-19-112:~# ssh-keygen
root@ip-172-31-19-112:~# ls -a
.  ..  .bashrc  .lesshst  .local  .profile  .ssh  snap
root@ip-172-31-19-112:~# cd .ssh
root@ip-172-31-19-112:~/.ssh# ls
authorized_keys  id_rsa  id_rsa.pub
root@ip-172-31-19-112:~/.ssh# cat id_rsa.pub
ubuntu@ip-172-31-19-112:~$ sudo ssh ubuntu@44.207.187.63

root@ip-172-31-19-112:~# docker ps
root@ip-172-31-19-112:~# docker restart 9dcf50d5813f


# TERRAFORM
ubuntu@ip-172-31-19-112:~$ sudo apt-get update
root@ip-172-31-19-112:~# nano terrafor.sh
```
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

root@ip-172-31-19-112:~# bash terrafor.sh

# JENKINS
ubuntu@ip-172-31-19-112:~$ sudo apt update
ubuntu@ip-172-31-19-112:~$ sudo nano jenkins.sh
```
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins
sudo systemctl start jenkins
 
# sudo ufw allow 8080
# sudo ufw allow OpenSSH
# sudo ufw enable
```
ubuntu@ip-172-31-19-112:~$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# JENKINS PIPELINE
```
pipeline {
    agent any
    tools {
       terraform 'Terraform'
    }
    stages {
        stage('Git checkout') {
           steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/devops-parth/pyterrakube']]])
            }
        }
        stage('terraform Init') {
            steps{
                sh 'terraform init'
            }
        }
        stage('terraform apply') {
            steps{
                sh 'terraform apply --auto-approve'
            }
        }
    }  
}
```


ubuntu@ip-172-31-19-112:~$ nano docker-compose.yml
ubuntu@ip-172-31-19-112:~$ sudo docker-compose up -d

# AWS CLI
```
root@ip-172-31-19-112:~# sudo apt-get install awscli -y &&
sudo apt install python-pip -y &&
sudo apt install openjdk-8-jdk
```
ubuntu@ip-172-31-19-112:~$ aws configure
ubuntu@ip-172-31-19-112:~$ aws --version
ubuntu@ip-172-31-19-112:~$ sudo chmod 777 /var/run/docker.sock
ubuntu@ip-172-31-19-112:~$ sudo chmod 777 ///var/run/docker.sock
ubuntu@ip-172-31-19-112:~$ which terraform
/usr/bin/terraform

ubuntu@ip-172-31-19-112:~/dele/pyterrakube$ terraform init
ubuntu@ip-172-31-19-112:~/dele/pyterrakube$ terraform plan

ubuntu@ip-172-31-19-112:~$ ls
Jenkins.pem  compose-dir  dele  doccom.sh  docker-compose.yml  docker.sh
ubuntu@ip-172-31-19-112:~$ chmod 400 Jenkins.pem
ubuntu@ip-172-31-19-112:~$ sudo mv Jenkins.pem /var/lib/jenkins/workspace/terra_pipe/

ubuntu@ip-172-31-19-112:/var/lib/jenkins/workspace/terra_pipe$ terraform destroy -lock=false



ubuntu@ip-172-31-19-112:/var/lib/jenkins/workspace/terra_pipe$ aws ec2 describe-instances --filters "Name=tag:name,Values=kube_inst" | grep '"PublicIp":' | awk 'NR==1 {print $2}' | tr '"' ' '
 54.204.185.231


# GIT
```
root@ip-172-31-19-112:~# git init
root@ip-172-31-19-112:~# git remote add origin 
root@ip-172-31-19-112:~# git push origin master
Username for 'https://github.com': devops-parth
Password for 'https://devops-parth@github.com':
```

# Dockerfile
```
FROM python
WORKDIR /app
COPY c29.py /app
EXPOSE 8080
CMD [ "python","c29.py" ]
```
