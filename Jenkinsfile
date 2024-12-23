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
    }
}
