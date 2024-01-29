pipeline {
    agent any
    stages{
        stage('Git checkout'){
            steps{
                script{
                    git 'https://github.com/shivalikasisodia/maven-build-eks.git'
                }
            }
        }
    }
}