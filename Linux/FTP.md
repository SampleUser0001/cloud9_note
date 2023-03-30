# FTP

- [FTP](#ftp)
  - [Client](#client)
    - [接続](#接続)
  - [Server](#server)
    - [vsftpd](#vsftpd)
      - [停止](#停止)
    - [Docker](#docker)
      - [atmoz/sftp(1)](#atmozsftp1)
        - [参考](#参考)
      - [atmoz/sftp(2)](#atmozsftp2)
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

### Docker

#### atmoz/sftp(1)

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

##### 参考

- [dockerでSFTPサーバーを作成し、Pythonで作成した一時ファイルをアップロードしてみた:DevelopersIO](https://dev.classmethod.jp/articles/docker-sftp-python-paramiko-practice/)

#### atmoz/sftp(2)

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
    - ```.ssh/keys```配下に公開鍵を配置すると、authorized_keysに追記してくれる。
    - dokcer-composeだとうまく行かない？
3. Dockerホストから接続
    ``` sh
    sftp -i <host-dir>/id_rsa -P2222 foo@localhost
    ```

##### 参考

- [atomz/sftp:Github](https://github.com/atmoz/sftp#logging-in-with-ssh-keys)