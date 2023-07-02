# Docker SSH Server

### Docker Build
##### docker build
```
docker build --tag anti1346/centos8:sshd -f ./Dockerfile.sshd . --no-cache
```
```
docker build --tag anti1346/centos8:sshd --build-arg SSH_USER=centos --build-arg SSH_PASSWORD=centos -f ./Dockerfile.sshd .
```
##### docker push
```
docker push anti1346/centos8:sshd
```
##### docker run
```
docker run -d --name centos8-sshd anti1346/centos8:sshd
```
##### docker exec
```
docker exec -it centos8-sshd bash
```

### Docker Compose Build
##### docker-compose build
```
docker-compose build --no-cache
```
```
docker-compose up -d; docker-compose ps; docker-compose logs -f
```
```
docker-compose up --build -d; docker-compose ps; docker-compose logs -f
```
```
docker-compose exec ssh-server bash
```
##### docker container ip
```
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubuntu-sshd
```
##### ssh access info
centos / centos
