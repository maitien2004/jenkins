# Jenkins
Ubuntu 16.04 + Jenkins + Docker + Docker Compose + AWS CLI

### Build
```
docker build -t jenkins .
```
### Run
```sh
docker run -d -p 50000:50000 -p 8080:8080 --name jenkins jenkins:latest
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

