pipeline {
    agent any

    environment {
        IMAGE_NAME = "tatajulistapwq/mobileapp"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/tatajulistap-wq/mobileapp.git',
                    credentialsId: 'github-credentials'
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
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',
                                                    usernameVariable: 'DOCKER_USER',
                                                    passwordVariable: 'DOCKER_PASS')]) {
                        bat """
                        docker login -u %DOCKER_USER% -p %DOCKER_PASS%
                        docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:latest
                        docker push ${IMAGE_NAME}:latest
                        docker logout
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build and push to Docker Hub successful!'
        }
        failure {
            echo '❌ Build failed! Check Docker Hub credentials or network.'
        }
    }
}
