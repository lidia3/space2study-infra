pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh '/opt/homebrew/bin/terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh '/opt/homebrew/bin/terraform validate'
                }
            }
        }

        stage('Ansible Version') {
            steps {
                sh '/opt/homebrew/bin/ansible --version'
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh '/opt/homebrew/bin/terraform plan'
        }
    }
}

    }
}
