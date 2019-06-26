node('node1') { 
  def DockerImage = "noamshmueli/projectimage"
  def ContainerName = "project_container"

  stage('Pre') { // Run pre-build steps
    cleanWs()
    sh "docker rm -f ${ContainerName} || true"
  }

  
  stage('Git') { // Get code from GitLab repository
    git branch: 'master',
      url: 'http://github.com/Noamshmueli/middleproject-app.git'
  }
  
  stage('Build') { // Run the docker build
    sh "docker image build -t ${DockerImage} ."
  }
  
  stage('Run') { // Run the built image
    sh "docker run --rm -d --name ${ContainerName} -p 8081:5000 ${DockerImage}; sleep 5"
  }
  


  stage('Push') { // Push the image to repository
   withDockerRegistry([ credentialsId: "docker-hub-credentials", url: "" ]) {
         sh "docker push ${DockerImage}"
       }
   return
 }




  stage('Deploy on kubernetes') {
   kubernetesDeploy(
      kubeconfigId: 'kubeconfig',
      configs: 'k8s/*',
      enableConfigSubstitution: true
     )
}


}
