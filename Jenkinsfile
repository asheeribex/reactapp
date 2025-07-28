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
          GITLEAKS_VERSION="v8.18.2"
          curl -sL https://github.com/gitleaks/gitleaks/releases/download/${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION#v}_linux_x64.tar.gz -o gitleaks.tar.gz
          tar -xzf gitleaks.tar.gz
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
      echo '❌ GitLeaks scan failed — potential secrets found or install issue!'
    }
    success {
      echo '✅ GitLeaks scan passed — no secrets detected.'
    }
  }
}
