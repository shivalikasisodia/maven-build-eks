@Library('my-share-libraries') _

pipeline {
    agent any
    stages{
        stage('Git checkout'){
            steps{
                script{
                    gitCheckout{
                        url: "https://github.com/shivalikasisodia/jenkins_shared_lib.git"
                    }
                }
            }
        }
    }
}