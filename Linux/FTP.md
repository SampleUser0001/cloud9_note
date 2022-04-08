# FTP

- [FTP](#ftp)
  - [Client](#client)
  - [Server](#server)
    - [ユーザ作成](#ユーザ作成)
    - [参考](#参考)

## Client


## Server

``` yml
version: '3'
services:
  ftp_server:
    image: stilliard/pure-ftpd:latest
    container_name: ftp_server
    ports: 
      - "21:21"
      - "30000-30009:30000-30009"
    environment:
      - PUBLICHOST="localhost"
```

``` Dockerfile
FROM stilliard/pure-ftpd:latest

RUN apt update && apt -y upgrade && apt -y install less

WORKDIR /home/ftpusers/
```

``` bash
docker-compose up -d
```

### ユーザ作成

``` bash
docker-compose exec ftp_server /bin/bash
```

``` bash
# ユーザ : testを作成する。
pure-pw useradd test -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u ftpuser -d /home/ftpusers/test
# パスワードを聞かれる。
Password: 
Enter it again: 
```

### 参考

- [【Docker】FTPサーバコンテナ構築手順と使い方（Pure-ftpd Server）:インフラエンジニアの技術LOG](https://genchan.net/it/virtualization/docker/13815/)
- [stilliard/docker-pure-ftpd:github](https://github.com/stilliard/docker-pure-ftpd)
  - 公式
- [FTP_Server_on_Docker:Github](https://github.com/SampleUser0001/FTP_Server_on_Docker)