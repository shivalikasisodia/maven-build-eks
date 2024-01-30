@Library('my-shared-library') _

pipeline {
    agent any
    stages{
        stage('Git checkout'){
            steps{
            gitCheckout{
                branch: "master",
                url: "https://github.com/shivalikasisodia/maven-build-eks.git"
                    }
            }
        }
         stage('Unit Test maven'){
         
         

            steps{
               script{
                   
                   mvnTest()
               }
            }
        }
         stage('Integration Test maven'){
         
            steps{
               script{
                   
                   mvnIntegrationTest()
               }
            }
        }
    }
}