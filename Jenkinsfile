pipeline {
    agent any
    
    stages {
        stage('checkout') {
            steps {
                git url: 'https://github.com/VinayPuvvala/Microservice_test.git'
        }
        }
        stage('build') {
            steps {
                    withMaven(jdk: 'Java', maven: 'Maven') {
                      sh 'mvn clean compile'
                    }     
                  }
            }
        
        
        stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                   withMaven(jdk: 'Java', maven: 'Maven') {
                      sh 'mvn sonar:sonar'
                    }
                }
            }
        }
        
        stage("Quality Gate") {
           steps {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
           }
        }
        stage('Package') {
            steps {
                      withMaven(jdk: 'Java', maven: 'Maven') {
                        sh 'mvn package'
                    }
                }
        }
        stage('Build Docker Image') {
            
            steps {
                 docker.build(demo)
                    }
                }
        stage('Push Docker Image') {
            
            steps {
                    docker.withRegistry('475485431052.dkr.ecr.us-east-1.amazonaws.com', 'aws') {
                        docker.image('demo').push('latest')
                    }
                }
            }
            
        /*stage('DeployToProduction') {
            
            steps {
                /*input 'Deploy to Production?'
               milestone(1)
                withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'aws',
                accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
            ]]) {
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'sample.yml',
                    enableConfigSubstitution: true
                )
                }
                sh '''
                export PATH=$PATH:/var/lib/jenkins
                kubectl get nodes
                kubectl create -f sample.yml
                '''                
             }
            
        }*/
        
    }
}
