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
### Logs
```sh
docker logs jenkins
```
