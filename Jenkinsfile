pipeline {
    agent any

    stages {
        stage('Dependency-Check-CLI') {
            steps {
                script {
                    // Run OWASP Dependency-Check with the necessary arguments
                    dependencyCheck additionalArguments: '''
                        -o './' 
                        -s './' 
                        -f 'ALL' 
                        --prettyPrint
                    ''', odcInstallation: 'Dependency-Check-CLI'

                    // Publish the generated report
                    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
                }
            }
        }
    }
}
