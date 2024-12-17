node('built-in') {  // Ensure to run on the built-in node
    try {
        stage('SCM Checkout') {
            // Checkout code from your GitHub repository
            git credentialsId: 'github-credentials', url: 'https://github.com/asheeribex/reactapp.git'
        }

        stage('Building Image') {
            // Build the Docker image
            sh 'docker build -t test .'
        }

        stage('OWASP Dependency Check') {
            // Run OWASP Dependency-Check plugin (you should have it installed and configured)
            step([$class: 'DependencyCheckBuilder', 
                  applicationName: 'reactapp', 
                  odcInstallation: 'OWASP Dependency-Check'])
        }

    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        // Clean up or perform any final steps here
        echo 'Pipeline finished.'
    }
}


