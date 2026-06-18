pipeline {
    agent any

    stages {

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

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh '/opt/homebrew/bin/terraform apply -auto-approve'
                }
            }
        }

    }
}
