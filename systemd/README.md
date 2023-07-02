# CentOS 8

#### CentOS Linux 8(systemd)
##### docker build
```
docker build -t anti1346/centos8:systemd -f Dockerfile.systemd . --no-cache
```
##### docker push(Upload to Docker Hub)
```
docker push anti1346/centos8:systemd
```
##### Privileged 모드로 컨테이너 실행
```
docker run -d --privileged --name centos8-systemd anti1346/centos8:systemd
```
##### 컨테이너에 액세스(접속)
```
docker exec -it centos8-systemd bash
```
##### Privileged 모드로 컨테이너 실행 후 컨테이너에 액세스(접속)
```
docker run -it --rm --privileged --name centos8-systemd anti1346/centos8:systemd bash
```
