pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'mvn clean install' // Example build step for a Maven project
            }
        }

        stages {
        stage('Dependency Check') {
            steps {
                dependencyCheck additionalArguments: '--failOnCVSS 7 --out dependency-check-reports', odcInstallation: 'Dependency-Check-CLI'
            }
        }
    }

        stage('Archive Reports') {
            steps {
                archiveArtifacts artifacts: 'dependency-check-reports/*'
            }
        }
    }
}

