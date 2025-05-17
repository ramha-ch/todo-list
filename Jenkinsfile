pipeline {
    agent any

    triggers {
        githubPush() 
        ##pollSCM('* * * * *')  // This means every minute
    }

    stages {
        stage('Clone') {
            steps {
                script {
                    echo "Cloning repository..."
                    checkout([$class: 'GitSCM', branches: [[name: env.BRANCH_NAME]], userRemoteConfigs: [[url: 'https://github.com/ramha-ch/todo-list.git']]])
                }
            }
        }

        stage('Build') {
            when {
                anyOf {
                    branch 'dev'
                    branch 'test'
                    branch 'main'
                }
            }
            steps {
                echo "Building Docker image..."
                sh "docker build -t rimsha524/todo-list:${env.BRANCH_NAME} ."
            }
        }

        stage('Test') {
            when {
                branch 'test'
            }
            steps {
                echo "Running Tests..."
                // Add your test commands here
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'jenkins_security', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                            docker push rimsha524/todo-list:main
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}
