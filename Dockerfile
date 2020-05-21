node{
   
   stage('SCM Checkout'){
        git branch: 'master', 
	 url: 'https://github.com/narravulavikas/hello-world.git'
   }
   stage('Maven Build'){
        def mvnHome = tool name: 'M3', type: 'maven'
		sh "${mvnHome}/bin/mvn clean package"
   }
   
   stage('Deploy Dev'){
	    sshagent(['tomcat21']) {
	           sh "scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/project1/webapp/target/webapp.war ec2-user@172.31.42.228:/opt/tomcat/webapps"
    

    
     }
   
   }

}
