@Library('my-shared-library') _
pipeline{

    agent any
    parameters{

        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'ImageName', description: "name of the docker build", defaultValue: 'javapp')
        string(name: 'ImageTag', description: "tag of the docker build", defaultValue: 'v1')
        string(name: 'DockerHubUser', description: "name of the Application", defaultValue: 'shivisis')
    }
    environment{

        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_KEY_ID')
        AWS_CRED = credentials('aws-auth')
    }
    stages{
        
        stage('Git Checkout'){
        when { expression {  params.action == 'create' } }            
            steps{
            gitCheckout(
                branch: "main",
                url: "https://github.com/shivalikasisodia/maven-build-eks.git"
            )
            }
        }
         stage('Unit Test maven'){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   mvnTest()
               }
            }
        }
         stage('Integration Test maven'){
         when { expression {  params.action == 'create' } }
            steps{
               script{ 
                   mvnIntegrationTest()
               }
            }
        }
         stage('Static Code Analysis: Sonarqube'){
         when { expression {  params.action == 'create' } }
            steps{
               script{ 
                   def SonarQubeCredentialsId = 'sonarqube-api'
                   staticCodeAnalysis(SonarQubeCredentialsId)
               }
            }
        }
         stage('Quality Gate Status: Sonarqube'){
         when { expression {  params.action == 'create' } }
            steps{
               script{ 
                   def SonarQubeCredentialsId = 'sonarqube-api'
                   QualityGateStatus(SonarQubeCredentialsId)
               }
            }
        }
         stage('Maven build: maven'){
         when { expression {  params.action == 'create' } }
            steps{
               script{ 
                  mavenBuild()
               }
            }
        }
         stage('Docker Image Build'){
         when { expression {  params.action == 'create' } }
            steps{
               script{ 
                  dockerBuild("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }
         stage('Docker Image Scan: trivy '){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   dockerImageScan("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }
         stage('Docker Image Push : DockerHub '){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   dockerImagePush("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        }   
         stage('Docker Image Cleanup : DockerHub '){
         when { expression {  params.action == 'create' } }
            steps{
               script{
                   
                   dockerImageCleanup("${params.ImageName}","${params.ImageTag}","${params.DockerHubUser}")
               }
            }
        } 
        stage('AWS Configure'){
         when { expression {  params.action == 'create' } }
            steps{   
                withCredentials([[
                  $class: 'AmazonWebServicesCredentialsBinding',
                  credentialsId: 'aws-auth',
                  accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                  secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh "aws ec2 describe-instances --region ${params.Region}"
                  }
            }
       }   
         stage('Create EKS Cluster : Terraform'){
            when { expression {  params.action == 'create' } }
            steps{
                script{

                    dir('eks_module') {
                      sh """
                          
                          terraform init 
                          terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'region=${params.Region}' --var-file=./config/terraform.tfvars
                          terraform apply -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' -var 'region=${params.Region}' --var-file=./config/terraform.tfvars --auto-approve
                      """
                  }
                }
            }
        }
        stage('Connect to EKS '){
            when { expression {  params.action == 'create' } }
        steps{

            script{

                sh """
                aws configure set aws_access_key_id "$ACCESS_KEY"
                aws configure set aws_secret_access_key "$SECRET_KEY"
                aws configure set region "${params.Region}"
                aws eks --region ${params.Region} update-kubeconfig --name ${params.cluster}
                """
            }
        }
        } 
        stage('Deployment on EKS Cluster'){
            when { expression {  params.action == 'create' } }
            steps{
                script{
                  
                  def apply = false

                  try{
                    input message: 'please confirm to deploy on eks', ok: 'Ready to apply the config ?'
                    apply = true
                  }catch(err){
                    apply= false
                    currentBuild.result  = 'UNSTABLE'
                  }
                  if(apply){

                    sh """
                      kubectl apply -f .
                    """
                  }
                }
            }
        }    
    }
}     


    }
}