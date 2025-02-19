stage('Dependency-Check-CLI') {
            steps {
                script {
                    // Run OWASP Dependency-Check with the necessary arguments
                    dependencyCheck additionalArguments: '''
                        -o './' 
                        -s './' 
                        -f 'ALL' 
                        --prettyPrint
                        --failOnCVSS '0'
                    ''', odcInstallation: 'Dependency-Check-CLI'

                    // Publish the generated report
                    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
                    
                    // Check the last 50 lines of the build log for specific error messages
                    def logs = currentBuild.rawBuild.getLog(50).join('\n')
                    
                    
                    // Check for the ERROR block related to vulnerabilities found
                    if (logs.contains('[ERROR]')) {
                        error("Build failed due to vulnerabilities found during dependencyCheck")
                    } else {
                        echo "No vulnerabilities found during dependencyCheck"
                    }
                }
            }
        }


