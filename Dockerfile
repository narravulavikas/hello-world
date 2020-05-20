node{
   def tomcatIp = '18.191.93.123'
   def tomcatUser = 'ec2-user'
   def stopTomcat = "ssh ${tomcatUser}@${tomcatIp} /opt/tomcat8/bin/shutdown.sh"
   def startTomcat = "ssh ${tomcatUser}@${tomcatIp} /opt/tomcat8/bin/startup.sh"
   def copyWar = "scp -o StrictHostKeyChecking=no target/myweb.war ${tomcatUser}@${tomcatIp}:/opt/tomcat8/webapps/"
   stage('SCM Checkout'){
        git branch: 'master', 
	 url: 'https://github.com/narravulavikas/hello-world.git'
   }
   stage('Maven Build'){
        def mvnHome = tool name: 'M3', type: 'maven'
		sh "${mvnHome}/bin/mvn clean package"
   }
   
   stage('Deploy Dev'){
	   sh 'mv target/webapp.war target/webapp.war' 
	   
       sshagent(['tomcat-dev']) {
			sh "${stopTomcat}"
			sh "${copyWar}"
			sh "${startTomcat}"
	   }
   }
}
