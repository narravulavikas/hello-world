node{
   
   stage('SCM Checkout'){
        git branch: 'master', 
	 url: 'https://github.com/narravulavikas/hello-world.git'
   }
   stage('Maven Build'){
        def mvnHome = tool name: 'M3', type: 'maven'
		sh "${mvnHome}/bin/mvn clean package"
		archiveArtifacts artifacts: 'webapp/target/webapp.war', fingerprint: true
   }
   
   stage('allure_repots'){
       allure includeProperties: false, jdk: '', results: [[path: '/var/lib/jenkins/workspace/project1/allure-report']]
       
   }
   
   stage('nexus upload'){
     nexusArtifactUploader artifacts: [[artifactId: 'maven-project', classifier: '', file: '/var/lib/jenkins/workspace/project1/webapp/target/webapp.war', type: 'war ']], credentialsId: 'sona', groupId: 'com.example.maven-project', nexusUrl: '172.31.12.116:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'apprelease/', version: '1.0-SNAPSHOT '
     
   }
   
   stage('deploy to tomcat){
    
            sshagent(['ssh']) {
             sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/project1/webapp/target/webapp.war ec2-user@172.31.42.97:/opt/tomcat/webapps'
             }
	    
   }     
    
 }
