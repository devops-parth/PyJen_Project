# SONARQUBE DASHBOARD
- 34.238.180.161:9090
- admin/admin
- Create Project
- Token

- Administrations > Webhooks > jenkins > URL: ip:8080/
webhook: http://34.238.180.161:8080/sonarqube-webhook/

# JENKINS DASHBOARD

## Plugin Manager
- SonarScanner
- Cloudbees Docker Build & Publish
- Docker
- Terraform

## Global Tool Config
- SonarQube Scanner (Auto Install ON)
- Terraform (Auto Install OFF) - Install Directroy: which terraform (/usr/bin/)

## Config System
- Sqube + URL

## CodeQuality Freestyle
- Github URL
- Github HTTPS
- POLL SCM
- BUILD
    - Execute SonarQube
 ```
sonar.projectKey=python
sonar.projectName=python
sonar.projectVersion=1.0
sonar.sources= /var/lib/jenkins/workspace/$JOB_NAME
sonar.language=py
 ```    
- Docker Build & Publish
    - Repo Name: devops/parth
    - Tag: ${BUILD_NUMBER}
    - Registry Credential: DockerHub

## Terraform Pipeline
- Declarative Pipeline
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





