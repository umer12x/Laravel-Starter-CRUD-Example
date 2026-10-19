pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Starting Laravel Build...'
                sh '''
                    php -v
                    composer --version
                    composer install --no-interaction --prefer-dist --no-progress --ignore-platform-req=php
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Running Tests...'
                sh 'php artisan test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to Nginx...'
                sh '''
                    rsync -av --exclude='.git' $WORKSPACE/ /var/www/laravel/
                    cd /var/www/laravel
                    cp .env.example .env
                    php artisan key:generate
                    php artisan config:cache
                '''
            }
        }
    }
}
