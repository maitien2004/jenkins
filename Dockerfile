FROM jenkins/jenkins:lts

ENV ANDROID_NDK_PATH "/opt/android/ndk"
ENV ANDROID_SDK_PATH "/opt/android/sdk"
ENV ANDROID_HOME "/opt/android/sdk"
ENV JENKINS_HOME "/var/jenkins_home"

USER root

# Packages
RUN apt-get update && apt-get install -y software-properties-common apt-transport-https ca-certificates curl zip unzip gnupg2
RUN chown -R jenkins:jenkins $ANDROID_NDK_PATH && \
  chown -R jenkins:jenkins $ANDROID_SDK_PATH &&\
  chown -R jenkins:jenkins $JENKINS_HOME

# Docker
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
	add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce && \
	usermod -aG docker $(whoami) && \
	usermod -aG docker jenkins

# Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.13.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
	chmod +x /usr/local/bin/docker-compose

# AWS CLI
RUN apt-get install -y python-minimal && \
	curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
	unzip -n awscli-bundle.zip && \
	./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
	rm -r ./awscli-bundle && \
	rm ./awscli-bundle.zip

USER jenkins