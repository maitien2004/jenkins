#!/bin/bash

# Export
export ANDROID_SDK_PATH=/home/$(whoami)/android_sdk
export ANDROID_NDK_PATH=/home/$(whoami)/android_ndk
export JENKINS_HOME=/home/$(whoami)/jenkins_home

# Start
docker run -d --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $JENKINS_HOME:/var/jenkins_home \
  -v $ANDROID_NDK_PATH:/opt/android/ndk \
  -v $ANDROID_SDK_PATH:/opt/android/sdk jenkins/jenkins:lts

# Custom
docker exec -it -u root jenkins bash -c 'apt-get update && \
	apt-get -y install apt-transport-https \
		 ca-certificates \
		 curl \
		 gnupg2 \
		 software-properties-common && \
	curl -fsSL https://download.docker.com/linux/debian/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
	apt-get update && \
	apt-get -y install docker-ce && \
	apt-get install -y python-minimal && \
	curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
	unzip -n awscli-bundle.zip && \
	./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
	rm -r ./awscli-bundle && \
	rm ./awscli-bundle.zip && \
	curl https://cli-assets.heroku.com/install-ubuntu.sh | sh && \
	usermod -aG docker $(whoami) && \
	usermod -aG docker jenkins'	

# Restart
docker restart jenkins
