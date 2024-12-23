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

                        // Parse and display findings
                        def reportXml = new XmlSlurper().parse(reportPath)
                        def criticalFindings = reportXml.depthFirst().findAll { it.severity?.text() == 'CRITICAL' }
                        def highFindings = reportXml.depthFirst().findAll { it.severity?.text() == 'HIGH' }

                        if (criticalFindings || highFindings) {
                            echo "Critical Findings:\n" + criticalFindings.collect { it.description.text() }.join('\n')
                            echo "High Findings:\n" + highFindings.collect { it.description.text() }.join('\n')
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
