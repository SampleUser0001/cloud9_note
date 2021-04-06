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
  - [イメージのビルド](#イメージのビルド)
  - [イメージのpush](#イメージのpush)
  - [イメージの保存/読み込み](#イメージの保存読み込み)
  - [docker-compose 起動オプション](#docker-compose-起動オプション)
  - [docker-compose.yml ファイルで使用可能な値](#docker-composeyml-ファイルで使用可能な値)
    - [何もしないコンテナでも上がり続ける](#何もしないコンテナでも上がり続ける)
    - [読み取り専用(ReadOnly)としてバインドする](#読み取り専用readonlyとしてバインドする)
  - [コンテナ内でホストと同じユーザになる](#コンテナ内でホストと同じユーザになる)
  - [ログ出力](#ログ出力)
    - [ログローテ](#ログローテ)
    - [参考](#参考)
  - [docker psのオプション](#docker-psのオプション)
    - [Nameで検索](#nameで検索)
    - [参考](#参考-1)
  - [fs.file-max](#fsfile-max)

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

``` yaml
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

``` sh
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

```yaml
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

``` sh
#!/bin/bash

exec node app.js
```

### Dockerコマンド

``` sh
chmod 755 start.sh
docker-compose build
docker-compose up -d
```

## イメージのビルド

```
docker build　-t {ユーザ名}/{イメージ名}:{タグ名} {Dockerfileがあるディレクトリ}
```

## イメージのpush

```
docker push {ユーザ名}/{イメージ名}:{タグ名}
```

## イメージの保存/読み込み

保存

``` sh
docker save <イメージ名> > <イメージ名>.tar
```

読み込み

```sh
docker load < <イメージ名>.tar
```

## docker-compose 起動オプション

- up
  - 個々のコンテナの出力をまとめる。
  - 開始 or 再起動
- -d
  - バックグラウンドで動く
- --build
  - 開始時にビルドする
- run
  - ワンオフ起動
- start
  - 再起動


## docker-compose.yml ファイルで使用可能な値

### 何もしないコンテナでも上がり続ける

``` yaml
tty: true
```

### 読み取り専用(ReadOnly)としてバインドする

``` yaml
volumes:
  - <ホスト側パス>:<コンテナ側パス>:ro
```

## コンテナ内でホストと同じユーザになる

注意点

1. ホスト側とユーザ側のOS（権限管理）が一致している必要がある。
   - ディストリビューションが違う場合も注意が必要なはずだが、未確認。

ホスト側

``` sh
export USERID=$(id -u)
export GROUPID=$(id -g)
export HOSTUSER=`whoami`
docker-compose up
```

docker-compose.yml

``` yml : docker-compose.yml
version: '3'
services:
  hoge:
    # userでコンテナ内で実行するユーザを変更できるが、
    # 実行する内容によってはrootが必要なので、rootのまま実行したほうが無難。
    # user: "${USERID}:${GROUPID}"
    volumes:
      - /etc/passwd:/etc/passwd:ro
      - /etc/group:/etc/group:ro
    environment:
      - USERID=${USERID}
      - GROUPID=${GROUPID}
      - HOSTUSER=${HOSTUSER}
```

コンテナ内

``` sh
chown -R ${HOSTUSER}: ${所有者を変更するディレクトリ}
```

groupidの指定は不要。コロンだけ書いて実行すると、ユーザのプライマリグループに変更される。

## ログ出力

下記ファイルに出力される。

``` sh
/var/lib/docker/containers/${コンテナID}/${コンテナID}-json.log
```

### ログローテ

``` yml
    logging:
      driver: "json-file" # defaults if not specified
      options:
        max-size: "10m"
        max-file: "3"
```

### 参考

- [Qiita:Dockerコンテナのログは標準オプションでローテートできる](https://qiita.com/hidekuro/items/b1c7ce58c9d9fe342907)

## docker psのオプション

### Nameで検索

コンテナ名は部分一致検索。

``` sh
docker ps --filter="name=${コンテナ名}"
```

### 参考

- [Docker-docs-ja:ps](https://docs.docker.jp/engine/reference/commandline/ps.html)

## fs.file-max

``` 
sudo sysctl -w fs.file-max=524288
```

