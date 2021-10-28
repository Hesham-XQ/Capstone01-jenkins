pipeline {
    agent any

    

    stages {  
        
        stage('Cloning Git') {
            steps {
                git credentialsId: 'wardahsana', url: 'https://github.com/wardahsana/capstoneprojectudacity.git'
        
      }
    }           
      
        
        stage('Install dependencies') {
            steps {
                  echo "Installing dependencies"
                  
                  sh 'sudo npm install -g npm@latest'
                  sh 'sudo npm install react'
                  

                  

            }      
                
        }              
        stage('Build Application') {
            steps {
                  echo "Building app"
                  sh 'npm run build'
            }      
                
        }
         
        
        stage('Run Lint') {
            steps {
                  echo "Linting Dockerfile"
                  sh 'hadolint Dockerfile'
            }
        }    

        stage('Docker Build and Push Image') {  
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]) {
                    sh '''#!/bin/bash
                        sudo docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                        sudo docker build -t capstone:new .
                        sudo docker tag capstone:new wardahsana/capstone:new
                        sudo docker push wardahsana/capstone:new
                        
                    '''  
                }
            }
        }
              
              
              
              
                    
        stage('Create kube config file and Deploy container to AWS EKS cluster') {
            steps {
                withAWS(region: 'us-east-2', credentials: 'aws_access_id') {
                    sh 'aws eks --region us-east-2 update-kubeconfig --name capstone'
                    sh "kubectl config use-context arn:aws:eks:us-east-2:610575826472:cluster/capstone"
                    sh "kubectl set image deployment/capston-deployment capston-pod-reactapp=wardahsana/capstone:new"
                    sh "kubectl apply -f deployment.yml"
                    sh "kubectl get nodes"
                    sh "kubectl get deployment"
                    sh "kubectl get pod -o wide"
                    sh "kubectl get service/capston-service"  
                    
                    }
                }       
            }

       
       }
}
