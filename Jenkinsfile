pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        IMAGE_NAME = "tatajulistapwq/mobileapp"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/tatajulistap-wq/mobileapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build and push completed successfully!'
        }
        failure {
            echo '❌ Build failed! Please check logs.'
        }
    }
}
