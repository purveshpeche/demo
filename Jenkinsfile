pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'sample-app'
        DOCKER_TAG = "${env.BUILD_NUMBER}"
        CONTAINER_NAME = "sample-app-${env.BUILD_NUMBER}"
        GITHUB_REPO = "${env.GIT_URL ?: 'https://github.com/your-username/sample-app'}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code from GitHub...'
                checkout scm
                script {
                    env.GIT_COMMIT_SHORT = sh(
                        script: 'git rev-parse --short HEAD',
                        returnStdout: true
                    ).trim()
                    env.GIT_BRANCH = sh(
                        script: 'git rev-parse --abbrev-ref HEAD',
                        returnStdout: true
                    ).trim()
                }
                echo "Building commit: ${env.GIT_COMMIT_SHORT} on branch: ${env.GIT_BRANCH}"
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing Node.js dependencies...'
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running application tests...'
                sh 'npm test'
            }
        }

        stage('Security Scan') {
            steps {
                echo 'Running security audit...'
                sh 'npm audit --audit-level moderate'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh """
                    docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                    docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest
                    docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:${GIT_COMMIT_SHORT}
                    docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:${GIT_BRANCH}
                """
            }
        }

        stage('Test Docker Container') {
            steps {
                echo 'Testing Docker container...'
                sh """
                    docker run -d --name ${CONTAINER_NAME} -p 3000:3000 ${DOCKER_IMAGE}:${DOCKER_TAG}
                    sleep 10
                    docker exec ${CONTAINER_NAME} curl -f http://localhost:3000/ || exit 1
                    docker exec ${CONTAINER_NAME} curl -f http://localhost:3000/error && exit 1 || true
                """
            }
        }

        stage('Integration Tests') {
            steps {
                echo 'Running integration tests...'
                sh """
                    curl -f http://localhost:3000/ || exit 1
                    curl -f http://localhost:3000/error && exit 1 || true
                """
            }
        }

        stage('Cleanup') {
            steps {
                echo 'Cleaning up test containers...'
                sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                """
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed'
            sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
            """
        }
        success {
            echo 'Pipeline succeeded!'
            script {
                // Optional: Push Docker image to registry
                // sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ghcr.io/your-username/sample-app:${DOCKER_TAG}"
                // sh "docker push ghcr.io/your-username/sample-app:${DOCKER_TAG}"
            }
        }
        failure {
            echo 'Pipeline failed!'
            // Optional: Send GitHub/Slack notifications
        }
    }
}
