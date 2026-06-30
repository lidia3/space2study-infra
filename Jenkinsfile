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
                    sh '/opt/homebrew/bin/terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh '/opt/homebrew/bin/terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Wait for EC2') {
            steps {
                sleep(time: 30, unit: 'SECONDS')
            }
        }

        stage('Ansible Ping') {
            steps {
                dir('ansible/native') {
                    withCredentials([
                        string(
                            credentialsId: 'ansible-vault-password',
                            variable: 'VAULT_PASS'
                        )
                    ]) {
                        sh '''
                        echo "$VAULT_PASS" > .vault_pass

                        /opt/homebrew/bin/ansible all \
                        -i inventory.ini \
                        -m ping \
                        --vault-password-file .vault_pass

                        rm -f .vault_pass
                        '''
                    }
                }
            }
        }

        stage('Ansible Deploy') {
            steps {
                dir('ansible/native') {
                    withCredentials([
                        string(
                            credentialsId: 'ansible-vault-password',
                            variable: 'VAULT_PASS'
                        )
                    ]) {
                        sh '''
                        echo "$VAULT_PASS" > .vault_pass

                        /opt/homebrew/bin/ansible-playbook \
                        -i inventory.ini \
                        site.yml \
                        --vault-password-file .vault_pass

                        rm -f .vault_pass
                        '''
                    }
                }
            }
        }

        stage('Backend Health Check') {
            steps {
                dir('ansible/native') {
                    withCredentials([
                        string(
                            credentialsId: 'ansible-vault-password',
                            variable: 'VAULT_PASS'
                        )
                    ]) {
                        sh '''
                        echo "$VAULT_PASS" > .vault_pass
                        /opt/homebrew/bin/ansible backend \
                        -i inventory.ini \
                        -m shell \
                        -a "systemctl is-active space2study-backend" \
                        --vault-password-file .vault_pass

                        rm -f .vault_pass
                        '''
                    }
                }
            }
        }

        stage('Frontend Health Check') {
            steps {
                dir('ansible/native') {
                    withCredentials([
                        string(
                            credentialsId: 'ansible-vault-password',
                            variable: 'VAULT_PASS'
                        )
                    ]) {
                        sh '''
                        /opt/homebrew/bin/ansible frontend \
                        -i inventory.ini \
                        -m shell \
                        -a "systemctl is-active space2study-frontend" \
                        --vault-password-file .vault_pass

                        rm -f .vault_pass

                        '''
                    }
                }
            }
        }

        stage('Backend API Check') {
            steps {
                dir('ansible/native') {
                    sh '''
                    /opt/homebrew/bin/ansible backend \
                    -i inventory.ini \
                    -m shell \
                    -a "curl -I http://localhost:3000  > /dev/null"
                    '''
                }
            }
        }

        stage('Frontend HTTP Check') {
            steps {
                dir('ansible/native') {
                    sh '''
                    /opt/homebrew/bin/ansible frontend \
                    -i inventory.ini \
                    -m shell \
                    -a "curl -I http://localhost:3001  > /dev/null"
                    '''
                }
            }
        }

    }
}
