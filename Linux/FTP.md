# FTP

- [FTP](#ftp)
  - [Client](#client)
  - [Server](#server)
    - [vsftpd](#vsftpd)
      - [停止](#停止)
    - [参考 : Docker](#参考--docker)

## Client


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

### 参考 : Docker

試してみたがうまく動かなかった。  
FTPサーバを構築することが目的ではないので、横に置いておく。  

- [【Docker】FTPサーバコンテナ構築手順と使い方（Pure-ftpd Server）:インフラエンジニアの技術LOG](https://genchan.net/it/virtualization/docker/13815/)
- [stilliard/docker-pure-ftpd:github](https://github.com/stilliard/docker-pure-ftpd)
  - 公式
- [FTP_Server_on_Docker:Github](https://github.com/SampleUser0001/FTP_Server_on_Docker)