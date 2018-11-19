# Jenkins
Ubuntu 16.04 + Jenkins + Docker + Docker Compose + AWS CLI

### Build
```
sudo chmod u+x prereqs-ubuntu.sh start-jenkins.sh start-jenkins-without-docker.sh && ./prereqs-ubuntu.sh
```
### Run with images
```sh
./start-jenkins.sh
```
### Run without images
```sh
./start-jenkins-without-docker.sh
```
### Admin Password
```sh
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```
### Jenkins Plugins
- [Pipeline: AWS Steps](https://wiki.jenkins.io/display/JENKINS/Pipeline+AWS+Plugin)
- [NodeJS Plugin](http://wiki.jenkins-ci.org/display/JENKINS/NodeJS+Plugin)
- [Slack Notification Plugin](http://wiki.jenkins-ci.org/display/JENKINS/Slack+Plugin)
- [and mores](https://updates.jenkins.io/2.138/latest/)

