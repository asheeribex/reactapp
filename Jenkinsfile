pipeline {
  agent any

  stages {
    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }

    stage('Install GitLeaks') {
      steps {
        sh '''
          curl -sL https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks-linux-amd64 -o gitleaks
          chmod +x gitleaks
          ./gitleaks version
        '''
      }
    }

    stage('Run GitLeaks Scan') {
      steps {
        sh '''
          ./gitleaks detect --source=. --verbose --redact --exit-code 1
        '''
      }
    }
  }

  post {
    failure {
      echo '❌ GitLeaks scan failed — potential secrets found!'
    }
    success {
      echo '✅ GitLeaks scan passed — no secrets detected.'
    }
  }
}
