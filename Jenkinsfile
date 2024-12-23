pipeline {
    agent any

    stages {
        stage('Dependency-Check-CLI') {
            steps {
                script {
                    // Run OWASP Dependency-Check with the necessary arguments
                    dependencyCheck additionalArguments: '''
                        -o './' 
                        -s './src' 
                        -f 'ALL' 
                        --prettyPrint
                    ''', odcInstallation: 'Dependency-Check-CLI' 

                    // Publish the generated report
                    dependencyCheckPublisher pattern: 'dependency-check-report.xml'
                }
            }
        }

        stage('Check Vulnerabilities') {
            steps {
                script {
                    // Define the path to the Dependency-Check report
                    def reportPath = './dependency-check-report.xml'

                    // Check if the report exists
                    if (!fileExists(reportPath)) {
                        error("Dependency-Check report not found at ${reportPath}")
                    }

                    // Read and parse the report content
                    def reportContent = readFile(reportPath)
                    def findings = []

                    // Extract vulnerabilities using regex for severity
                    reportContent.eachMatch(/<severity>(Critical|High|Medium|Low)<\/severity>/) { match ->
                        findings << match[0]
                    }

                    // Handle findings
                    if (findings) {
                        echo "Vulnerabilities found:\n${findings.join('\n')}"
                        currentBuild.result = 'FAILED' 
                    } else {
                        echo "No vulnerabilities found in Dependency-Check report."
                    }
                }
            }
        }
    }
}
