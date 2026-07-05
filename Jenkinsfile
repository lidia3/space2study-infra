pipeline {
    agent any

    stages {

        stage('Debug Terraform') {
            steps {
                dir('terraform/k8s') {
                    sh '''
                    pwd
                    ls -la
                    '''
                }
            }
         }


        stage('Terraform Init') {
            steps {
                dir('terraform/k8s') {
                    sh '/opt/homebrew/bin/terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform/k8s') {
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
                dir('terraform/k8s') {
                    sh '/opt/homebrew/bin/terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform/k8s') {
                    sh '/opt/homebrew/bin/terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Wait for EC2') {
            steps {
                sleep(time: 40, unit: 'SECONDS')
            }
        }

        stage('Generate Inventory') {
            steps {
                script {

                    dir('terraform/k8s') {

                        env.CONTROL_PLANE_IP = sh(
                            script: "/opt/homebrew/bin/terraform output -raw control_plane_public_ip",
                            returnStdout: true
                        ).trim()

                        env.WORKER_IP = sh(
                            script: "/opt/homebrew/bin/terraform output -raw worker_public_ip",
                            returnStdout: true
                        ).trim()
                    }

                    writeFile file: 'ansible/kuber/inventory.ini', text: """
[control_plane]
${env.CONTROL_PLANE_IP} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/aws-space2study

[worker]
${env.WORKER_IP} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/aws-space2study

[kubernetes:children]
control_plane
worker
"""
                }
            }
        }

        stage('Ansible Ping') {
            steps {
                dir('ansible/kuber') {
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

        stage('Deploy Kubernetes Cluster') {
            steps {
                dir('ansible/kuber') {
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
                        playbooks/site.yml \
                        --vault-password-file .vault_pass

                        rm -f .vault_pass
                        '''
                    }
                }
            }
        }

        stage('Check Kubernetes Nodes') {
            steps {
                sh """
                ssh -o StrictHostKeyChecking=no \
                -i ~/.ssh/aws-space2study \
                ubuntu@${CONTROL_PLANE_IP} \
                "kubectl get nodes"
                """
            }
        }

        stage('Check Kubernetes Pods') {
            steps {
                sh """
                ssh -o StrictHostKeyChecking=no \
                -i ~/.ssh/aws-space2study \
                ubuntu@${CONTROL_PLANE_IP} \
                "kubectl get pods -A"
                """
            }
        }

    }
}
