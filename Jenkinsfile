pipeline {
  agent any

  stages {
    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }

    stage('Run GitLeaks Scan') {
      steps {
        sh 'gitleaks detect --source=. --verbose --redact --exit-code 1'
      }
    }
  }

  post {
    failure {
      echo '❌ GitLeaks scan failed — secrets found!'
    }
    success {
      echo '✅ GitLeaks scan passed — no secrets detected.'
    }
  }
}
