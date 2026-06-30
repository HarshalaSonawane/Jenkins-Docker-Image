pipeline {

    agent any


    parameters {

        choice(
            name: 'ENVIRONMENT',
            choices: ['DEV','SIT','UAT','PROD'],
            description: 'Select environment'
        )

    }


    environment {

        IMAGE_NAME = "docker-demo"

        IMAGE_TAG = "${params.ENVIRONMENT.toLowerCase()}-${BUILD_NUMBER}"

    }


    stages {


        stage('Checkout Code') {

            steps {

                checkout scm

            }
        }



        stage('Build Docker Image') {

            steps {

                echo "Building image..."

                sh """
                docker build \
                -t ${IMAGE_NAME}:${IMAGE_TAG} .
                """

            }
        }



        stage('Check Image') {

            steps {

                sh """

                docker images | grep ${IMAGE_NAME}

                """

            }

        }



        stage('Run Container') {

            steps {

                sh """

                docker stop ${IMAGE_NAME} || true

                docker rm ${IMAGE_NAME} || true


                docker run -d \
                --name ${IMAGE_NAME} \
                -p 8080:8080 \
                ${IMAGE_NAME}:${IMAGE_TAG}

                """

            }

        }


    }


    post {

        success {

            echo "Docker deployment completed successfully"

        }


        failure {

            echo "Build failed"

        }

    }

}
