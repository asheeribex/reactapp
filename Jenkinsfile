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

                        // Check if the report file exists
                        def reportPath = 'dependency-check-report.xml'
                        if (!fileExists(reportPath)) {
                            error "Dependency-Check report not found at ${reportPath}. Build halted."
                        }

                        // Read the report file and search for findings
                        def findings = readFile(reportPath)
                        def criticalCount = findings.findAll(/<severity>CRITICAL<\/severity>/).size()
                        def highCount = findings.findAll(/<severity>HIGH<\/severity>/).size()

                        if (criticalCount > 0 || highCount > 0) {
                            echo "Critical Findings: ${criticalCount}\nHigh Findings: ${highCount}"
                            echo "Detailed Report:\n" + findings
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
