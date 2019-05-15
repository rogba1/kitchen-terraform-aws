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
                stage('Check Terraform configurations with tflint'){
                    steps {
                        // To install tflint
                        // curl -L -o /tmp/tflint.zip https://github.com/wata727/tflint/releases/download/v0.4.2/tflint_linux_amd64.zip && unzip /tmp/tflint.zip -d /usr/local/bin
                        sh  "tflint"
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
