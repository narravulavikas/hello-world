node{
   
   stage('SCM Checkout'){
        git branch: 'master', 
	 url: 'https://github.com/narravulavikas/hello-world.git'
   }
   stage('Maven Build'){
        def mvnHome = tool name: 'M3', type: 'maven'
		sh "${mvnHome}/bin/mvn clean package"
   }
   
   stage('allure_repots'){
       allure includeProperties: false, jdk: '', results: [[path: '/var/lib/jenkins/workspace/project1/allure-report']]
       
   }
   
   stage('nexus upload'){
      nexusArtifactUploader artifacts: [[artifactId: 'maven-project', classifier: '', file: 'target/webapp.war', type: 'war ']], credentialsId: 'nexus3', groupId: 'com.example.maven-project', nexusUrl: '18.219.142.2:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'apprelease/', version: '1.0-SNAPSHOT'
    }
    
    
 }
