# Docker

- [Docker](#docker)
  - [nginxイメージを使用して公開する](#nginxイメージを使用して公開する)
    - [docker-compose.yml](#docker-composeyml)
    - [起動コマンド](#起動コマンド)
  - [nginxイメージを使用してhttpsとして公開する](#nginxイメージを使用してhttpsとして公開する)
    - [起動コマンド](#起動コマンド-1)
    - [参照方法](#参照方法)
  - [shを実行する](#shを実行する)
    - [ディレクトリ構造](#ディレクトリ構造)
    - [Dockerfile](#dockerfile)
    - [docker-compose.yml](#docker-composeyml-1)
    - [start.sh](#startsh)
    - [Dockerコマンド](#dockerコマンド)
  - [イメージの保存/読み込み](#イメージの保存読み込み)

## nginxイメージを使用して公開する

### docker-compose.yml

```yml
version: '3'
services:
  nginx:
    image: nginx
    container_name: <任意のコンテナ名>
    ports: 
      - "80:80"
    volumes:
      - ./<任意のパス>:/usr/share/nginx/html/
```

### 起動コマンド

```
docker-compose up
```

## nginxイメージを使用してhttpsとして公開する

当然オレオレ証明書。

```
version: '3'
services:
  nginx:
    image: nginx
    container_name: <任意のコンテナ名>
    ports: 
      - "8080:80"
    volumes:
      - ./<任意のパス>:/usr/share/nginx/html/
  https-portal:
    image: steveltn/https-portal:1.15.0
    ports:
      - '80:80'
      - '443:443'
    links:
      - nginx
    restart: always
    environment:
      DOMAINS: 'localhost => http://nginx:3000'
      STAGE: local
```

### 起動コマンド

```
docker-compose up
```

### 参照方法

1. cloud9
2. Preview
3. Preview Running Application

※外部から参照する場合も同じURL。

## shを実行する

### ディレクトリ構造

```
.
├── Dockerfile
├── app
│   └── app.js
├── docker-compose.yml
└── start.sh
```

### Dockerfile

```
# 任意のイメージを取得
FROM node

WORKDIR /app

COPY app /app
COPY start.sh /start.sh

RUN chmod 755 /start.sh

CMD [ "/start.sh" ]
```

### docker-compose.yml

サービス名、コンテナ名は任意。  
ポートは外からアクセスするために必要なポートを開ける。
```
version: '3'
services:
  node:
    build: .
    container_name: node
    ports:
      - "3000:3000"
    volumes:
      - ./start.sh:/start.sh
      - ./app:/app
```

### start.sh

```
#!/bin/bash

exec node app.js
```

### Dockerコマンド

```
chmod 755 start.sh
docker-compose build
docker-compose up -d
```

## イメージの保存/読み込み

保存
```
docker save <イメージ名> > <イメージ名>.tar
```

読み込み
```
docker load < <イメージ名>.tar
```

