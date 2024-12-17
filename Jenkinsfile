node {  // This will run on the master node
    stage('SCM Checkout') {
        git credentialsId: 'github-credentials', url: 'https://github.com/asheeribex/reactapp.git'
    }

    stage('Building Image from Code') {
        sh 'docker build -t test .'
    }

    stage('OWASP Dependency-Check') {
        dependencyCheck additionalArguments: '',
                       odcInstallation: 'OWASP Dependency-Check',
                       outputDirectory: 'dependency-check-report',
                       scanPath: '.'
    }

    stage('Publish Reports') {
        publishHTML(target: [
            reportDir: 'dependency-check-report',
            reportFiles: 'index.html',
            reportName: 'OWASP Dependency-Check Report'
        ])
    }
}

    
