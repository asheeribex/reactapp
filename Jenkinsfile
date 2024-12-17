pipeline {
    agent any

    stages {
        stage('Dependency Check') {
            steps {
                dependencyCheck additionalArguments: '--failOnCVSS 7 --out dependency-check-reports', odcInstallation: 'Dependency-Check-CLI'
            }
        }

        stage('Archive Reports') {
            steps {
                archiveArtifacts artifacts: 'dependency-check-reports/*'
            }
        }
    }
}
