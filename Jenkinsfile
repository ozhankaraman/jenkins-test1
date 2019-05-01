node {
    def app
    def registry = 'ozhank/docker-test'
    def registryCredential = 'dockerhub'

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        //app = docker.build("ozhank/docker-test")
        
        
        docker.withRegistry( 'https://' + registry, registryCredential ) {
			app = docker.build registry + ":$BUILD_NUMBER"
			app.push()
        }
        
        
        
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * Just an example */

        app.inside {
            sh 'echo "Tests passed"'
            /*sh 'curl http://localhost:80 || exit 1'*/
        }
    }

     stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
            //app.push("latest")
        }
    }
    
    stage('Removing image') {
        sh "docker rmi ${app.id}"
        sh "docker rmi registry.hub.docker.com/ozhank/docker-test:${env.BUILD_NUMBER}"
    }
    
}
