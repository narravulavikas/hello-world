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
	           sh "scp -o StrictHostKeyChecking=no 3.133.7.26:/var/lib/jenkins/workspace/project1/webapp/target/webapp.war ec2-user@18.220.0.141:/opt/tomcat/webapp/"
    

    
     }
   
   }

}
