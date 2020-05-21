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
	  
	  sshagent(['tomcat1 ']) {
	    sh 'scp -o StrictHostKeyChecking=no target/*.war ec2-user@18.220.0.141:/opt/tomcat/webapp/'
    
       }
   }
}
