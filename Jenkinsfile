pipeline {
    agent any
    environment {
        GIT_CREDENTIALS = 'git' // Git credential ID
        DOCKER_CREDENTIALS = 'docker' // Docker credential ID
        DOCKER_REPOSITORY = 'chandanuikey97/k8s-eks-image' // Docker repository name
        KUBECONFIG = '/var/lib/jenkins/.kube/config' // Path to kubeconfig
        AWS_CREDENTIALS = 'cred' // Your AWS credential ID
        EKS_CLUSTER_NAME = 'three-tier-cluster' // EKS Cluster Name
        AWS_REGION = 'us-west-2' // AWS Region
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm: [$class: 'GitSCM',
                               branches: [[name: '*/main']],
                               userRemoteConfigs: [[credentialsId: GIT_CREDENTIALS, url: 'https://github.com/chan-764/pyhtondeployment.git']]]
            }
        }
        stage('Build and Push Images') {
            parallel {
                stage('Build & Push API') {
                    steps {
                        script {
                            def image = "${DOCKER_REPOSITORY}-api:latest"
                            withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                                sh """
                                    docker build -t ${image} -f api/Dockerfile api
                                    echo \$DOCKERHUB_PASSWORD | docker login -u \$DOCKERHUB_USERNAME --password-stdin
                                    docker push ${image}
                                """
                            }
                        }
                    }
                }
                stage('Build & Push App') {
                    steps {
                        script {
                            def image = "${DOCKER_REPOSITORY}-app:latest"
                            withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                                sh """
                                    docker build -t ${image} -f app/Dockerfile app
                                    echo \$DOCKERHUB_PASSWORD | docker login -u \$DOCKERHUB_USERNAME --password-stdin
                                    docker push ${image}
                                """
                            }
                        }
                    }
                }
                stage('Build & Push DB') {
                    steps {
                        script {
                            def image = "${DOCKER_REPOSITORY}-db:latest"
                            withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                                sh """
                                    docker build -t ${image} -f db/Dockerfile db
                                    echo \$DOCKERHUB_PASSWORD | docker login -u \$DOCKERHUB_USERNAME --password-stdin
                                    docker push ${image}
                                """
                            }
                        }
                    }
                }
            }
        }
        stage('AWS Login') {
            steps {
                script {
                    withCredentials([aws(credentialsId: AWS_CREDENTIALS)]) {
                        sh """
                            # Configure AWS CLI with the provided credentials
                            aws configure set aws_access_key_id \$AWS_ACCESS_KEY_ID
                            aws configure set aws_secret_access_key \$AWS_SECRET_ACCESS_KEY
                            aws configure set default.region ${AWS_REGION}
                        """
                    }
                }
            }
        }
        stage('EKS Login') {
            steps {
                script {
                    sh """
                        # Update the kubeconfig to use EKS
                        aws eks --region ${AWS_REGION} update-kubeconfig --name ${EKS_CLUSTER_NAME}
                    """
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh """
                        # Replace image placeholders in deployment files
                        sed -i 's|image:.*backend.*|image: ${DOCKER_REPOSITORY}-api:latest|' k8s/backend/deployment.yaml
                        sed -i 's|image:.*frontend.*|image: ${DOCKER_REPOSITORY}-app:latest|' k8s/frontend/deployment.yaml
                        sed -i 's|image:.*database.*|image: ${DOCKER_REPOSITORY}-db:latest|' k8s/database/deployment.yaml

                        # Apply Kubernetes manifests
                        kubectl apply -f k8s/backend/deployment.yaml -n workshop
                        kubectl apply -f k8s/backend/service.yaml -n workshop
                        kubectl apply -f k8s/backend/scr.yaml -n workshop
                        kubectl apply -f k8s/frontend/deployment.yaml -n workshop
                        kubectl apply -f k8s/frontend/service.yaml -n workshop

                        # Apply database-specific Kubernetes resources
                        kubectl apply -f k8s/database/pv.yaml -n workshop
                        kubectl apply -f k8s/database/pvc.yaml -n workshop
                        kubectl apply -f k8s/database/secrets.yaml -n workshop
                        kubectl apply -f k8s/database/deployment.yaml -n workshop
                        kubectl apply -f k8s/database/service.yaml -n workshop

                    """
                }
            }
        }
        stage('Check Kubernetes Resources') {
            steps {
                script {
                    sh """
                        echo "Fetching Pods..."
                        kubectl get pods -n workshop
                        echo "Fetching Services..."
                        kubectl get svc -n workshop
                    """
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution complete.'
        }
        success {
            echo 'Application deployed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for more details.'
        }
    }
}
