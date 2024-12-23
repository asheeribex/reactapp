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
                    def reportPath = './dependency-check-reports/dependency-check-report.xml'
                    if (!fileExists(reportPath)) {
                        error("Dependency-Check report not found at ${reportPath}")
                    }

                    def reportContent = readFile(reportPath)
                    def findings = []

                    // Extract vulnerabilities using simple regex for severity
                    reportContent.eachMatch(/<severity>(Critical|High|Medium|Low)<\/severity>/) { match ->
                        findings << match[0]
                    }

                    if (findings) {
                        echo "Vulnerabilities found:\n${findings.join('\n')}"
                        error("Pipeline failed due to findings in Dependency-Check.")
                    } else {
                        echo "No vulnerabilities found in Dependency-Check report."
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
            echo 'Pipeline failed due to findings in Dependency-Check.'
        }
    }
}
