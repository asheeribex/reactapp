
The error in your Jenkinsfile is due to nested stages blocks, which is not allowed in Jenkins pipelines. There should only be one stages block containing all stage blocks.

Corrected Jenkinsfile
Here's the corrected version of your script:

groovy
Copy code
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
     
