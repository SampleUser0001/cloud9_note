# FTP

- [FTP](#ftp)
  - [Client](#client)
    - [接続](#接続)
  - [Server](#server)
    - [vsftpd](#vsftpd)
      - [停止](#停止)
    - [atmoz/sftp(1)](#atmozsftp1)
      - [参考](#参考)
    - [atmoz/sftp](#atmozsftp)
      - [Dockerホストから接続](#dockerホストから接続)
      - [クライアントDockerコンテナを作る](#クライアントdockerコンテナを作る)
        - [参考](#参考-1)

## Client

### 接続

``` bash
# 下記のどちらか
# 1.
ftp ${接続先ホスト} ${接続先ポート}

# 2.
ftp
ftp> open ${接続先ホスト} ${接続先ポート}
```

## Server

### vsftpd

``` bash
sudo apt update && sudo apt -y upgrade && sudo apt -y install vsftpd
sudo systemctl enable vsftpd
sudo systemctl restart vsftpd
```

#### 停止

``` bash
sudo systemctl disable vsftpd
```

### atmoz/sftp(1)

``` yaml
version: '3'

services:
  sftp:
    image: atmoz/sftp
    container_name: sftp-test
    # docker-compose.ymlがあるディレクトリに、コンテナとの共有ディレクトリを作る
    volumes:
        - ./data:/home/testuser/data
    ports:
        - "2222:22"
    command: testuser:test123:::data
```

#### 参考

- [dockerでSFTPサーバーを作成し、Pythonで作成した一時ファイルをアップロードしてみた:DevelopersIO](https://dev.classmethod.jp/articles/docker-sftp-python-paramiko-practice/)

### atmoz/sftp

鍵を使って接続する。

1. 鍵作成する。
2. 下記コマンドで起動。
``` sh
docker run \
    -v <host-dir>/id_rsa.pub:/home/foo/.ssh/keys/id_rsa.pub:ro \
    -v <host-dir>/id_other.pub:/home/foo/.ssh/keys/id_other.pub:ro \
    -v <host-dir>/share:/home/foo/share \
    -p 2222:22 -d atmoz/sftp \
    foo::1001
```

コンテナ側の```${HOME}/.ssh/keys``` 配下に公開鍵を配置すると、authorized_keysに追記してくれる。  
dokcer-composeだとうまく行かない？

#### Dockerホストから接続
``` sh
sftp -i <host-dir>/id_rsa -P2222 foo@localhost
```

#### クライアントDockerコンテナを作る

``` Dockerfile
FROM ubuntu:latest

RUN apt update && apt upgrade -y && apt install -y less nano openssh-client sudo

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG PASSWORD=user
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME
WORKDIR /home/$USERNAME/

COPY .ssh/ /home/$USERNAME/.ssh/

RUN sudo chown -R $USERNAME:$GROUPNAME /home/$USERNAME
```

```.ssh```配下に鍵ファイルがある想定。


``` yml
version: '3'

services:
  sftp_client:
    build: ./docker/client
    container_name: sftp_client
    tty: true
```

鍵ファイルはvolumeで渡しても良さそうな気がするが、未確認。

``` bash
docker exec -it sftp_client /bin/bash
```

``` bash
sftp -i ./.ssh/id_rsa -P2222 foo@${ホストローカルIP}
```

##### 参考

- [atomz/sftp:Github](https://github.com/atmoz/sftp#logging-in-with-ssh-keys)