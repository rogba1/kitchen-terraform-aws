pipeline {
    agent any 
    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }
        stage('Validations'){
            parallel {
                stage('Validate Terraform configurations') {
                    steps {
                        sh 'find . -type f -name "*.tf" -exec dirname {} \\;|sort -u | while read m; do (terraform validate -check-variables=false "$m" && echo "√ $m") || exit 1 ; done'
                    }
                }
                stage('Check if Terraform configurations are properly formatted') {
                    steps {
                        sh "if [[ -n \"\$(terraform fmt -write=false)\" ]]; then echo \"Some terraform files need be formatted, run 'terraform fmt' to fix\"; exit 1; fi"
                    }
                }

            }
        }
        stage('Terraform Kitchen') {
            steps {
                sh 'kitchen test'
            }
        }
    }
}
