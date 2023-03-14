# FTP

- [FTP](#ftp)
  - [Client](#client)
    - [接続](#接続)
  - [Server](#server)
    - [vsftpd](#vsftpd)
      - [停止](#停止)
    - [Docker](#docker)
      - [参考](#参考)

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