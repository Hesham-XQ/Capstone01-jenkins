pipeline {
    agent any

    

    stages {  
        
           
        stage('Install dependencies') {
            steps {
                  echo "Installing dependencies"
                  
                  sh 'sudo apt install npm'
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

        stage('Build Green Docker Image') {
            steps {
                sh 'docker build -t heshamxq/flask-app .'
            }
        }

        stage('Upload Green Image to Docker-Hub'){
            steps{
                sh 'docker login -u heshamxq -p Hpassvf@90'
                sh 'docker push heshamxq/flask-app'
            }
        }

                    
              
                    
        stage('Create kube config file and Deploy container to AWS EKS cluster') {
            steps {
                withAWS(region: 'us-east-1', credentials: '25967a97-5647-4269-a6cb-a88477ad3460') {
                    sh 'aws eks --region us-east-1 update-kubeconfig --name UdacityCluster'
                    sh "kubectl config use-context arn:aws:eks:us-east-1:089377575339:cluster/UdacityCluster"
                    sh "kubectl set image deployment/capston-deployment capston-pod-reactapp=heshamxq/flask-app"
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
