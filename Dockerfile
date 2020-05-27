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
       allure includeProperties: false, jdk: '', properties: [[key: '', value: '']], results: [[path: 'allure-results'], [path: '/var/lib/jenkins/workspace/project1/allure-report']]
       
   }

}
