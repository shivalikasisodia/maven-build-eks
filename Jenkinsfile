@Library('my-shared-library') _
pipeline {
    agent any
    stages{
        stage('Git checkout'){
            steps{
            ggitCheckout{
                branch: "main",
                url: "https://github.com/shivalikasisodia/maven-build-eks.git"
            }
            }
        }
    }
}