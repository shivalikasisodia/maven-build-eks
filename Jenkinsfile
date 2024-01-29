@Library('my-share-libraries') _

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
    }
}