# Docker

- [Docker](#docker)
  - [nginxイメージを使用して公開する](#nginxイメージを使用して公開する)
    - [docker-compose.yml](#docker-composeyml)
    - [起動コマンド](#起動コマンド)
  - [nginxイメージを使用してhttpsとして公開する](#nginxイメージを使用してhttpsとして公開する)
    - [起動コマンド](#起動コマンド-1)
    - [参照方法](#参照方法)
  - [docker login](#docker-login)
  - [コンテナ内からホスト側のサービスを呼ぶ](#コンテナ内からホスト側のサービスを呼ぶ)
  - [shを実行する](#shを実行する)
    - [ディレクトリ構造](#ディレクトリ構造)
    - [Dockerfile](#dockerfile)
    - [docker-compose.yml](#docker-composeyml-1)
    - [start.sh](#startsh)
    - [Dockerコマンド](#dockerコマンド)
  - [docker-composeコマンドに渡した引数をコンテナ内のshファイルに渡す](#docker-composeコマンドに渡した引数をコンテナ内のshファイルに渡す)
    - [docker-compose.yml](#docker-composeyml-2)
    - [sh](#sh)
    - [コマンド](#コマンド)
      - [実行結果](#実行結果)
  - [docker-compose使用時にENTRYPOINTに引数を渡す](#docker-compose使用時にentrypointに引数を渡す)
  - [複数のdocker-compose.ymlファイルを使用する](#複数のdocker-composeymlファイルを使用する)
    - [実行例](#実行例)
  - [イメージのビルド](#イメージのビルド)
  - [イメージのpush](#イメージのpush)
  - [イメージの保存/読み込み](#イメージの保存読み込み)
  - [docker-compose 起動オプション](#docker-compose-起動オプション)
  - [docker-compose.yml ファイルで使用可能な値](#docker-composeyml-ファイルで使用可能な値)
    - [何もしないコンテナでも上がり続ける](#何もしないコンテナでも上がり続ける)
    - [読み取り専用(ReadOnly)としてバインドする](#読み取り専用readonlyとしてバインドする)
  - [コンテナ内でホストと同じユーザになる](#コンテナ内でホストと同じユーザになる)
    - [実際にやってみた](#実際にやってみた)
  - [ホストとコンテナで同じユーザを使用する（やってることは上と同じ）](#ホストとコンテナで同じユーザを使用するやってることは上と同じ)
    - [docker-compose.yml](#docker-composeyml-3)
    - [実行](#実行)
    - [参考](#参考)
  - [ログ出力](#ログ出力)
    - [ログローテ](#ログローテ)
    - [参考](#参考-1)
  - [docker psのオプション](#docker-psのオプション)
    - [Nameで検索](#nameで検索)
    - [参考](#参考-2)
  - [fs.file-max](#fsfile-max)
  - [Dockerfile内で使用できるコマンド](#dockerfile内で使用できるコマンド)
    - [ARG](#arg)
      - [コマンド](#コマンド-1)
      - [参考](#参考-3)
      - [例](#例)
      - [備考](#備考)
  - [ホストからコンテナの環境変数を設定する](#ホストからコンテナの環境変数を設定する)
  - [WSL2でDockerサービスを起動する](#wsl2でdockerサービスを起動する)

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

## docker login

``` bash
# username=
# password=
# server=https://hub.docker.com/

# serverは省略可能。省略した場合はhttps://hub.docker.com/にログイン。
docker login -u ${username} -p ${password} ${server}
```

## コンテナ内からホスト側のサービスを呼ぶ

localhostは使えない。ホスト側のIPを指定する。（プライベートIPでOK。）

``` bash
# 実行例
sftp -i ./.ssh/id_rsa -P2222 foo@192.168.1.16
```

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

## docker-composeコマンドに渡した引数をコンテナ内のshファイルに渡す

### docker-compose.yml

``` yml
version: '3'
services:
  shell: # ここの値を使う
    build: .
    container_name: container_shell
    volumes:
      - ./start.sh:/start.sh
```

### sh

``` sh
#!/bin/bash

echo 'Hello' $1 '!!'
```

### コマンド

``` sh
docker-compose run shell ${引数に渡したい値}
```

#### 実行結果

``` txt
Creating docker_args_shell_run ... done
Hello hoge !!
```

## docker-compose使用時にENTRYPOINTに引数を渡す

[docker-compose_args:SampleUser0001:Github](https://github.com/SampleUser0001/docker-compose_args)

## 複数のdocker-compose.ymlファイルを使用する

上書きできる。

``` sh
docker-compose -f ${ベースになるファイル.yml} -f ${上書きする内容.yml} ${docker-composeコマンド}
```

### 実行例

- [Docker-compose_override:SampleUser0001:Github](https://github.com/SampleUser0001/Docker-compose_override)

## イメージのビルド

```
docker build -t {ユーザ名}/{イメージ名}:{タグ名} {Dockerfileがあるディレクトリ}
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

``` bash
export USERID=$(id -u)
export GROUPID=$(id -g)
export HOSTUSER=`whoami`
docker-compose up
```

docker-compose.yml

``` yml 
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

``` bash
chown -R ${HOSTUSER}: ${所有者を変更するディレクトリ}
```

groupidの指定は不要。コロンだけ書いて実行すると、ユーザのプライマリグループに変更される。

### 実際にやってみた

- (https://github.com/SampleUser0001/Create_files_in_Docker_Container)[Create_files_in_Docker_Container]

## ホストとコンテナで同じユーザを使用する（やってることは上と同じ）

### docker-compose.yml

``` /etc/passwd ``` と ``` /etc/group ``` をバインドする。

``` yml
version: '3'
services:
  sh:
    build: .
    container_name: hogehoge
    volumes:
      - ./work:/tmp/work
      - /etc/passwd:/etc/passwd:ro
      - /etc/group:/etc/group:ro
    command: sh /tmp/work/create_directory.sh
```

### 実行

``` -u ``` オプションでコンテナ内で実行するユーザを指定する。

``` sh
docker-compose run  -u "$(id -u $USER):$(id -g $USER)"  --rm sh 
```

### 参考

- [Docker コンテナ内で Docker ホストと同じユーザを使う:CUBE SUGAR CONTAINER](https://blog.amedama.jp/entry/docker-container-host-same-user)
- [SameUser_onDocker:SampleUser0001:Github](https://github.com/SampleUser0001/SameUser_onDocker)
  - 実際にやってみた。


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

## Dockerfile内で使用できるコマンド

### ARG

```docker build```時に引数で受けた値を環境変数として設定できる。

#### コマンド

``` sh
docker build --build-arg ${ARGで宣言した環境変数}=${渡したい値} ${Dockerfileが配置されているパス}
```

#### 参考

[Dockerfile リファレンス](http://docs.docker.jp/engine/reference/builder.html#arg)

#### 例

``` Dockerfile
FROM ubuntu:latest

ARG HOGE

RUN echo $HOGE

```

``` sh
$ docker build --build-arg HOGE=hogehoge .
```

``` txt
Sending build context to Docker daemon  2.048kB
Step 1/3 : FROM ubuntu:latest
 ---> 1318b700e415
Step 2/3 : ARG HOGE
 ---> Running in f8e120639f74
Removing intermediate container f8e120639f74
 ---> 53121a4f0530
Step 3/3 : RUN echo $HOGE
 ---> Running in d04a646dc28d
hogehoge
Removing intermediate container d04a646dc28d
 ---> 55a01aafb8e9
Successfully built 55a01aafb8e9
```

#### 備考

大文字/小文字の判定がある。

## ホストからコンテナの環境変数を設定する

少し試してみた。

- [docker-compose_environment_sample](https://github.com/SampleUser0001/docker-compose_environment_sample)

## WSL2でDockerサービスを起動する

``` bash
sudo service docker start
```

