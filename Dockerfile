FROM ubuntu:16.04

# Packages
RUN apt-get update && apt-get install -y software-properties-common debconf-utils apt-transport-https ca-certificates curl zip unzip

# JDK
RUN add-apt-repository --yes ppa:webupd8team/java
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get update && apt-get install -y oracle-java8-installer oracle-java8-set-default

# Jenkins
RUN wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
RUN echo "deb https://pkg.jenkins.io/debian-stable binary/" | tee /etc/apt/sources.list.d/jenkins.list
RUN apt-get update && apt-get install -y jenkins

# Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - 
RUN echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
	tee /etc/apt/sources.list.d/docker.list	
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

# Supervisord
RUN apt-get install -y supervisor && mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 50000 8080

CMD ["/usr/bin/supervisord"]