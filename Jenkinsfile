pipeline{
    agent{
		label 'docker'
	}
	environment{
	IMAGE_NAME = 'bbcnews'
	CONTAINER_NAME = 'newsapp'	
  DOCKERHUB_USERNAME = 'harikrishnanknr'
                    }

	stages{
	stage('checkout'){
	steps{
	git branch: 'main', url: 'https://github.com/harikrishnan-knr/Nodejs-01.git'

                    }
    }
	stage('build'){
	steps{
	sh 'docker build -t ${IMAGE_NAME}:latest .'
                    }
    }
	stage('stop old containers'){
	steps{
	sh 'docker stop ${CONTAINER_NAME} || true'
	sh 'docker rm ${CONTAINER_NAME} || true'
	}
}
	stage('docker image run'){
	steps{
	sh 'docker run -d --name ${CONTAINER_NAME} -p 80:80 ${IMAGE_NAME}:latest'
	sh 'docker ps'
	}
}
		stage('docker push'){
			steps{
				withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
					          docker tag ${IMAGE_NAME}:latest ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest
                    docker push ${DOCKERHUB_USERNAME}/${IMAGE_NAME}:latest
                    docker logout
                    '''
                }
            }
}
}
  agent{
    label 'kuber'
  }
  	environment{
      KUBE_FILE = 'service.yaml'
	    }
  stages{
    stage('git checkout'){
      steps{
        git branch: 'main', url: 'https://github.com/harikrishnan-knr/Nodejs-01.git'
      }
    }
    stage('kuberternes version check')
    steps{
      sh '''kubectl version
            eskctl version'''
    }
  }
  stage('verifying kuberternes files are exist or not'){
    steps{
      sh 'ls -la'
    }
  }
  stage('kuberternes manifestation'){
    steps{
      sh 'kubectl apply -f ${KUBE_FILE}'
    }
  }
  stage('pod checkout'){
    steps{
      sh 'kubectl get pod -o wide'
    }
  }
}
}
