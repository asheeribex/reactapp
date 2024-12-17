pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'mvn clean install' // Example build step for a Maven project
            }
        }

        stage('Dependency Check') {
            steps {
                echo 'Running OWASP Dependency-Check...'
                dependencyCheck additionalArguments: '--failOnCVSS 7 --out dependency-check-reports'
            }
        }

        stage('Archive Reports') {
            steps {
                archiveArtifacts artifacts: 'dependency-check-reports/*'
            }
        }
    }
}

