pipeline {
    agent any

    stages {
        stage('Dependency-Check-CLI') {
            steps {
                script {
                    // Run OWASP Dependency-Check with the necessary arguments
                    dependencyCheck additionalArguments: '''
                        -o './dependency-check-reports' 
                        -s './src' 
                        -f 'ALL' 
                        --prettyPrint
                    ''', odcInstallation: 'Dependency-Check-CLI'

                    // Publish the generated report
                    dependencyCheckPublisher pattern: '**/dependency-check-reports/dependency-check-report.xml'
                }
            }
        }

        stage('Check Vulnerabilities') {
            steps {
                script {
                    // Parse the dependency-check-report.xml to check for vulnerabilities
                    def reportPath = './dependency-check-reports/dependency-check-report.xml'
                    def reportContent = readFile(reportPath)
                    def hasVulnerabilities = reportContent.contains('<severity>')

                    if (hasVulnerabilities) {
                        error('Vulnerabilities detected in Dependency-Check report.')
                    } else {
                        echo 'No vulnerabilities detected.'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed due to detected vulnerabilities or other errors.'
        }
    }
}
