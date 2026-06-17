pipeline {
    agent any

    stages {

        stage('Terraform Version') {
            steps {
                sh '/opt/homebrew/bin/terraform version'
            }
        }

        stage('Ansible Version') {
            steps {
                sh '/opt/homebrew/bin/ansible --version'
            }
        }
    }
}
