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
                    ''', 
                    odcInstallation: 'Dependency-Check-CLI',
                    stopBuild: true  // Stop the build if findings are detected

                    // Publish the generated report
                    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
                }
            }
        }
    }

    post {
        success {
            echo 'OWASP Dependency-Check completed successfully!'
        }
        failure {
            echo 'OWASP Dependency-Check failed.'
        }
    }
}






