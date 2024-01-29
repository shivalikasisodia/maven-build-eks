@Library('my-share-libraries')

pipeline {
    agent any
    stages{
        stage('Git checkout'){
            steps{
                script{
                    gitCheckout{
                        branch: "master",
                        url: "https://github.com/shivalikasisodia/maven-build-eks.git"
                    }
                }
            }
        }
    }
}