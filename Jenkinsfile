pipeline {
    agent any
    stages {
        stage('Build Image') {
            steps {
                echo 'Building Docker container image locally...'
                sh 'docker build -t laravel-local:latest .'
            }
        }
        stage('Run Container') {
            steps {
                echo 'Deploying Laravel inside a local Docker container...'
                sh '''
                    docker stop laravel-app || true
                    docker rm laravel-app || true
                    docker run -d --name laravel-app -p 8000:8000 laravel-local:latest
                '''
            }
        }
    }
}
