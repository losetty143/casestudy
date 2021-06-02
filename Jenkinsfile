node {
    try {
        
        stage('checkout'){
            git 'https://github.com/losetty143/casestudy.git'
        }
        currentBuild.result = 'SUCCESS'
        emailext body: 'Your build has been successful on checkout', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    } catch (Exception err) {
        currentBuild.result = 'FAILURE'
        emailext body: 'Your build has been unsuccessful on checkout', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    }
    echo "RESULT: ${currentBuild.result}"
    try {
        
        stage('Build, Test and Package'){
           echo "Building the addressbook application..."
           sh "mvn clean package"
        }
        
        currentBuild.result = 'SUCCESS'
        emailext body: 'Your build has been successful on packaging', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    } catch (Exception err) {
        currentBuild.result = 'FAILURE'
        emailext body: 'Your build has been unsuccessful on packging', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    }
    echo "RESULT: ${currentBuild.result}"
    try {
        
        stage('Sonar Scan'){
           echo "Scanning application for vulnerabilities...."
           sh "mvn sonar:sonar -Dsonar.host.url=http://35.232.107.113:9000/ -Dsonar.login=admin -Dsonar.password=Rajsasi@143"
        }
        
        currentBuild.result = 'SUCCESS'
        emailext body: 'Your build has been successful on Sonar stage', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    } catch (Exception err) {
        currentBuild.result = 'FAILURE'
        emailext body: 'Your build has been unsuccessful on Sonar stage', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    }
    echo "RESULT: ${currentBuild.result}"
    try {
        
        stage('publish report'){
           echo "Publishing HTML report.."
           publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/casestudy', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: ''])

        }
        
        currentBuild.result = 'SUCCESS'
        emailext body: 'Your build has been successful on HTML Report', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    } catch (Exception err) {
        currentBuild.result = 'FAILURE'
        //emailext body: 'Your build has been unsuccessful on HTML Report', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    }
    echo "RESULT: ${currentBuild.result}"
    try {
        
        stage('Build Docker Image'){
           echo "Building docker image for addressbook application ..."
          sh "docker build -t rlosetty/addressbook:1.0 ." 

        }
        //echo "Im not going to fail"
        currentBuild.result = 'SUCCESS'
        emailext body: 'Your build has been successful on Docker image', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    } catch (Exception err) {
        currentBuild.result = 'FAILURE'
        emailext body: 'Your build has been unsuccessful on Docker Image', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    }
    echo "RESULT: ${currentBuild.result}"
    try {
        
        stage('Push Docker Image to Docker Registry'){
           echo "Pushing image to docker hub"
            withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                
            sh "docker login -u ${USERNAME} -p ${PASSWORD}"
            sh "docker push rlosetty/addressbook:1.0"
            }
                     
        }
        
        currentBuild.result = 'SUCCESS'
        emailext body: 'Your build has been successful on Docker image Pushing', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    } catch (Exception err) {
        currentBuild.result = 'FAILURE'
        emailext body: 'Your build has been unsuccessful on Docker Image Pushing', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    }
    echo "RESULT: ${currentBuild.result}"
    try {
        
        stage('Deploy GCP instance'){
         echo "Deploying GCP instance"
         ansiblePlaybook installation: 'ansible-2.9.22', inventory: '/etc/ansible/hosts', playbook: '/var/lib/jenkins/workspace/instance.yml'  
        }
        
        currentBuild.result = 'SUCCESS'
        emailext body: 'Your build has been successful on Deploying GCP instance', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    } catch (Exception err) {
        currentBuild.result = 'FAILURE'
        emailext body: 'Your build has been unsuccessful on Deploying GCP instance', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    }
    echo "RESULT: ${currentBuild.result}"
     try {
        
        stage('Deploying'){
        echo "Deploying into VM which created using Ansible playbook"
        deploy adapters: [tomcat7(credentialsId: 'TomcatCred', path: '', url: 'http://34.136.39.153:8080/')], contextPath: 'index', war: '**/*.war'
       }
        
        currentBuild.result = 'SUCCESS'
        emailext body: 'Your build has been successful on Deployment', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    } catch (Exception err) {
        currentBuild.result = 'FAILURE'
        emailext body: 'Your build has been unsuccessful on Deployment', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    }
    echo "RESULT: ${currentBuild.result}"
    try {
        
        stage('Clean up'){
        echo "Cleaning Work Space"
        cleanWs()  
        }
        
        currentBuild.result = 'SUCCESS'
        emailext body: 'Your build has been successful on Work Space', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    } catch (Exception err) {
        currentBuild.result = 'FAILURE'
        emailext body: 'Your build has been unsuccessful on Work Space', subject: 'Build Result', to: 'rajesh.losetty@gmail.com'
    }
    echo "RESULT: ${currentBuild.result}"
   
 }
