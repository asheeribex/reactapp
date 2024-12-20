pipeline {
    agent any

    stages {
        stage('Dependency-Check-CLI') {
            steps {
                script {
                    try {
                        // Run OWASP Dependency-Check
                        dependencyCheck additionalArguments: '''
                            -o './' 
                            -s './' 
                            -f 'ALL' 
                            --prettyPrint
                        ''', odcInstallation: 'Dependency-Check-CLI'

                        // Publish the generated report
                        dependencyCheckPublisher pattern: '**/dependency-check-report.xml'

                        // Read the report and check for findings
                        def findings = readFile('dependency-check-report.xml')
                        if (findings.contains('<severity>CRITICAL</severity>') || findings.contains('<severity>HIGH</severity>')) {
                            error "OWASP Dependency-Check found critical/high vulnerabilities. Build halted."
                        } else {
                            echo "No critical/high vulnerabilities found. Build passed successfully."
                        }
                    } catch (Exception e) {
                        error "Dependency-Check stage failed: ${e.message}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully. No findings were generated.'
        }
        failure {
            echo 'Pipeline failed due to findings in Dependency-Check.'
        }
    }
}
