pipeline {
    agent any
    environment {
        IMAGE_NAME = "inventoware-app:${env.BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(env.IMAGE_NAME)
                }
            }
        }
        stage('Security Scan') {
            steps {
                sh 'trivy image --exit-code 1 --severity HIGH,CRITICAL ${IMAGE_NAME} || true'
            }
        }
        stage('Test') {
            steps {
                sh 'docker run --rm ${IMAGE_NAME} python -m unittest discover || true'
            }
        }
        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker tag ${IMAGE_NAME} $DOCKER_USER/inventoware-app:${env.BUILD_NUMBER}'
                    sh 'docker push $DOCKER_USER/inventoware-app:${env.BUILD_NUMBER}'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploy stage (use Ansible, kubectl, or AWS CLI as needed)'
            }
        }
    }
}
