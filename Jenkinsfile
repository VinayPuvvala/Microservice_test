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
                script {
                 docker.build('harrisdemorepo')
                }
                    }
                }
        stage('Push Docker Image') {
            
            steps {
                script {
                    docker.withRegistry('http://475485431052.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:aws') {
                        docker.image('harrisdemorepo').push('latest')
                    }
                    }
                }
            }
            /*stage('Pull Docker Image') {
            
            steps {
                script {
                    docker.withRegistry('http://475485431052.dkr.ecr.us-east-1.amazonaws.com') {
                        docker.image('harrisdemorepo').pull()
                    }
                    }
                }
            }*/
        /*stage('DeployToKubernetes') {
            
            steps {
                //input 'Deploy?'
               //milestone(1)
                    kubernetesDeploy configs: 'sample.yml', dockerCredentials: [[credentialsId: 'ecr:us-east-1:aws', url: 'http://475485431052.dkr.ecr.us-east-1.amazonaws.com']], kubeConfig: [path: ''], kubeconfigId: 'kubeconfig', secretName: 'my-aws-credentials', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']

                /*kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'sample.yml',
                    enableConfigSubstitution: true
                )*/
                }
                /*sh '''
                export PATH=$PATH:/var/lib/jenkins
                kubectl get svc
                //kubectl create -f sample.yml
                '''                
             }*/
            
        }*/
        
    }
}
