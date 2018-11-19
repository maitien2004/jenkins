# Jenkins
Ubuntu 16.04 + Jenkins + Docker + Docker Compose + AWS CLI

### Build
```
sudo chmod u+x prereqs-ubuntu.sh start-jenkins.sh start-jenkins-without-docker.sh && ./prereqs-ubuntu
```
### Run with images
```sh
./start-jenkins
```
### Run without images
```sh
./start-jenkins-without-docker
```
### Admin Password
```sh
docker exec -it jenkins cat /var/lib/jenkins/secrets/initialAdminPassword
```
### Jenkins Plugins
- [Pipeline](https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin)
- [Build Pipeline Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Build+Pipeline+Plugin)
- [Pipeline: AWS Steps](https://wiki.jenkins.io/display/JENKINS/Pipeline+AWS+Plugin)
- [Amazon ECR plugin](https://wiki.jenkins-ci.org/display/JENKINS/Amazon+ECR)
- [Docker plugin](http://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin)
- [GitLab Plugin](https://wiki.jenkins-ci.org/display/JENKINS/GitLab+Plugin)
- [NodeJS Plugin](http://wiki.jenkins-ci.org/display/JENKINS/NodeJS+Plugin)
- [Slack Notification Plugin](http://wiki.jenkins-ci.org/display/JENKINS/Slack+Plugin)

