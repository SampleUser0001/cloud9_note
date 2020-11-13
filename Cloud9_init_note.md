# Cloud9 init note
Cloud9を起動したときに行うことの備忘録。

- [Cloud9 init note](#cloud9-init-note)
  - [git](#git)
    - [アカウントの設定](#アカウントの設定)
    - [エディタの設定](#エディタの設定)
      - [永続](#永続)
      - [一時](#一時)
  - [Java](#java)
  - [Javaインストール](#javaインストール)
    - [参考](#参考)
  - [Maven](#maven)
  - [Mavenインストール](#mavenインストール)
    - [参考](#参考-1)
  - [ant](#ant)
    - [antインストール](#antインストール)
  - [jd-cli](#jd-cli)
  - [telnet](#telnet)
    - [telnetインストール](#telnetインストール)
  - [docker](#docker)
    - [dockerインストール](#dockerインストール)
  - [docker-compose](#docker-compose)
    - [docker-composeインストール](#docker-composeインストール)
    - [参考サイト](#参考サイト)
  - [goofys](#goofys)
    - [goofysインストール](#goofysインストール)
    - [自動マウント設定](#自動マウント設定)
    - [参考](#参考-2)
  - [Vue.js](#vuejs)
    - [準備](#準備)
    - [インストール](#インストール)
    - [init](#init)
    - [init 別パターン](#init-別パターン)
    - [参考](#参考-3)

## git
```
ec2-user:~/environment $ git --version
git version 2.14.5
```
### アカウントの設定
```
git config --global user.name "Your Name"
git config --global user.email you@example.com
```

### エディタの設定
#### 永続
```
cd 
vi .bashrc
```

```
    # git config --global core.editor /usr/bin/nano
    git config --global core.editor /usr/bin/vim
```

#### 一時
git config --global core.editor 'vim -c "set fenc=utf-8"'

## Java
インストールされているが…
```
ec2-user:~/environment $ java -version
java version "1.7.0_251"
OpenJDK Runtime Environment (amzn-2.6.21.0.82.amzn1-x86_64 u251-b02)
OpenJDK 64-Bit Server VM (build 24.251-b02, mixed mode)
```

## Javaインストール
```
sudo yum -y update
sudo yum -y install java-1.8.0-openjdk-devel
```

```
sudo update-alternatives --config java
```

```
sudo update-alternatives --config javac
```


### 参考
https://docs.aws.amazon.com/ja_jp/cloud9/latest/user-guide/sample-java.html

## Maven
インストールされていない。

## Mavenインストール
```
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
```

### 参考
https://docs.aws.amazon.com/ja_jp/cloud9/latest/user-guide/sample-java.html


## ant
いらないかもしれないが入れたのでメモを残す。

### antインストール
```
wget https://ftp.yz.yamagata-u.ac.jp/pub/network/apache//ant/binaries/apache-ant-1.10.7-bin.tar.gz
tar zxvf apache-ant-1.10.7-bin.tar.gz
sudo mkdir /usr/share/ant
sudo mv apache-ant-1.10.7 /usr/share/ant
sudo ln -s /usr/share/ant/apache-ant-1.10.7/bin/ant /usr/bin/ant
```
※yumのantは古いため使わない。

## jd-cli

Javaの逆コンパイルツール。

※バージョンは事前に確認。
```
mkdir tmp
cd tmp
wget https://github.com/kwart/jd-cli/releases/download/jd-cmd-1.1.0.Final/jd-cli-1.1.0.Final-dist.tar.gz
tar -zxvf jd-cli-1.1.0.Final-dist.tar.gz
sudo cp jd-cli /usr/local/bin/
sudo cp jd-cli.jar /usr/local/bin/
cd ..
```

```
jd-cli --version
```

## telnet 

### telnetインストール
```
sudo yum -y install telnet
```

## docker

入ってたっけ…？記憶にない。

### dockerインストール

```
sudo yum install docker
```

## docker-compose
### docker-composeインストール
```
sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

※バージョンは参考サイトから確認。

### 参考サイト
https://qiita.com/youtangai/items/ff67ceff5497a0e0b1af

## goofys

S3バケットをEC2のストレージとしてマウントすることができる。

### goofysインストール

S3バケットは作成済み、AWS CLIは設定済みの前提。

go, fuseインストール
```
sudo yum install golang fuse
```

goofysインストール
```
export GOPATH=$HOME/go
go get github.com/kahing/goofys
go install github.com/kahing/goofys
```

S3マウント
```
mkdir ~/mount-goofys
./go/bin/goofys kohei-goofys ~/mount-goofys
```

### 自動マウント設定

上記だけだと再起動したときにマウントが解除されてしまう。  
参考サイトに手順が書いてあるが、まだ対応していない。  
（どこにマウントしたらいいか、考える。）

### 参考

[Qiita : goofysを使ってAmazon LinuxにS3をマウントする。](https://qiita.com/kooohei/items/a14f22cb0381342d1861)

## Vue.js

### 準備
```
ec2-user:~/environment/Sample_Vue $ node -v
v10.19.0
ec2-user:~/environment/Sample_Vue $ npm -v
6.13.4
```

### インストール

npmを入れた記憶がないが…まあいいか。
```
npm install -g @vue/cli
npm install -g @vue/cli-service-global
```

```
ec2-user:~/environment/Sample_Vue/test-vue (master) $ vue -V
@vue/cli 4.5.3
```

### init

```
vue create test-vue
cd test-vue

touch  vue.config.js
```

vue.config.jsの中身
```
module.exports = {
  devServer: {
    disableHostCheck: true
  }
}
```

```
npm run serve
```

http://<IPアドレス>:8080  
にアクセス

### init 別パターン

[公式サンプル](./Vuejs_init/index.html)

### 参考

[Qitt:Vue.jsについての基礎(インストール)](https://qiita.com/watataku/items/26f2ce546fcd562e4b46)  
[Qiita:AWS Cloud9 で Vue.js を使う](https://qiita.com/tamusan100/items/32acfd5e70336f33273f)
