# Cloud9 init note

Cloud9を起動したときに行うことの備忘録。

- [Cloud9 init note](#cloud9-init-note)
  - [git](#git)
    - [アカウントの設定](#アカウントの設定)
    - [エディタの設定](#エディタの設定)
      - [永続](#永続)
      - [一時](#一時)
  - [Java](#java)
    - [yumでJavaをインストール](#yumでjavaをインストール)
      - [参考](#参考)
    - [antでJavaをインストール](#antでjavaをインストール)
      - [参考](#参考-1)
  - [Maven](#maven)
    - [Mavenインストール](#mavenインストール)
    - [参考](#参考-2)
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
  - [pip3](#pip3)
    - [apt](#apt)
  - [PHP](#php)
    - [ソースからコンパイル](#ソースからコンパイル)
      - [参考](#参考-3)
    - [apt](#apt-1)
  - [Composer](#composer)
  - [go](#go)
    - [go(参考)](#go参考)
  - [goofys](#goofys)
    - [goofysインストール](#goofysインストール)
    - [自動マウント設定](#自動マウント設定)
    - [参考](#参考-4)
  - [Node.js](#nodejs)
    - [動作確認](#動作確認)
    - [参考](#参考-5)
  - [webpack](#webpack)
  - [TypeScript](#typescript)
  - [forever](#forever)
    - [systemdを使って自動起動するように設定する(Ubuntu)](#systemdを使って自動起動するように設定するubuntu)
    - [参考:systemdを使って自動起動するように設定する(Ubuntu)](#参考systemdを使って自動起動するように設定するubuntu)
  - [Vue.js](#vuejs)
    - [準備](#準備)
    - [インストール](#インストール)
    - [init](#init)
    - [init 別パターン](#init-別パターン)
    - [参考](#参考-6)
  - [OWASP ZAP](#owasp-zap)
    - [メニュー日本語化](#メニュー日本語化)
    - [備考](#備考)
    - [参考](#参考-7)

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

### yumでJavaをインストール

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


#### 参考
[https://docs.aws.amazon.com/ja_jp/cloud9/latest/user-guide/sample-java.html](https://docs.aws.amazon.com/ja_jp/cloud9/latest/user-guide/sample-java.html)

### antでJavaをインストール

```
sudo apt install default-jdk
```

```
$ java --version
openjdk 11.0.9.1 2020-11-04
OpenJDK Runtime Environment (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04)
OpenJDK 64-Bit Server VM (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04, mixed mode, sharing)
```

```
$ javac --version
javac 11.0.9.1
```

#### 参考

[Ubuntu 20.04にAptを使用してJavaをインストールする方法](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-20-04-ja)

## Maven
インストールされていない。

### Mavenインストール
```
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
```

### 参考
[https://docs.aws.amazon.com/ja_jp/cloud9/latest/user-guide/sample-java.html](https://docs.aws.amazon.com/ja_jp/cloud9/latest/user-guide/sample-java.html)


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
[https://qiita.com/youtangai/items/ff67ceff5497a0e0b1af](https://qiita.com/youtangai/items/ff67ceff5497a0e0b1af)

## pip3

### apt

``` sh
sudo apt update && sudo apt -y upgrade
sudo apt install -y python3-pip
```

${HOME}/.bashrc
``` sh
alias pip=pip3
```

## PHP

LaravelのComposerをインストールするときに使う。

Laravelをローカルで管理するだけなら、Dockerとdocker-composeがあればいいが、gitのリモートリポジトリにpushする場合は、(デフォルトでは)vender配下がpushされない。  
```composer update```が必要だが、composerインストールでphpコマンドを使う。

### ソースからコンパイル

あとで書く。

#### 参考

- [Qiita:CentOS 7 PHP 7.2.3のソースファイルからのインストール](https://qiita.com/knutpb1205/items/cba2610b4ccb5ecd7b92)

### apt

この方法は最新バージョンが手に入らない。

``` sh
sudo apt install -y php
```

``` sh
php --version
```

## Composer

Laravelで使う。

``` sh
cd /tmp
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

``` sh
cd
composer --version
```


## go

Ubuntu版

``` sh
sudo apt install golang
```

### go(参考)

- [Qiita:Ubuntuに最新のGolangをインストールする](https://qiita.com/notchi/items/5f76b2f77cff39eca4d8)
  - 最新が欲しい時に使う。

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

## Node.js

```
cd tmp
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
reboot
```

```
nvm ls-remote
```

```
nvm install <インストールしたいバージョン>
```

```
vi $HOME/.bashrc
```

```
# Node.js setting
source ~/.nvm/nvm.sh
nvm use v14.15.4
```

### 動作確認

```
node -v
npm -v
```

```
echo "console.log( 'Hello' );" > hello.js | node hello
```

### 参考

- [Qiita:ChromeOSにNode.jsをnvmでインストールする](https://qiita.com/Hiroki_M/items/f1af64fa0d6807d1cbb0)
- [node.js - Node.jsバージョンは、再起動時に0.6から0.6に戻ります(NVM)](https://ja.ojit.com/so/node.js/1601993)
- [Qiita:Node.jsアプリをLinux環境で常駐化させる　forever編](https://qiita.com/chihiro/items/24ca8ac81cb20c22b47e)

## webpack

ビルドで使う…つもりだったが、使えていない。
```
npm install -g webpack
npm install -g webpack-cli
```

## TypeScript

``` sh
npm install -g typescript
```

## forever

Nodeをサービス化する。

``` sh
npm install -g forever
```

登録方法

``` sh
forever start <JavaScriptファイル>
```

### systemdを使って自動起動するように設定する(Ubuntu)

/etc/systemd/system/forever.service

``` service
[Unit]
Description=forever service
After=network.target

[Service]
Type=forking
Environment="NODE_ENV=production"
ExecStart=<which foreverのパス> start <登録しておきたいサービス>
ExecStop=<which foreverのパス> stop <登録しておきたいサービス>
Restart=always
RestartSec=10
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=forever-example

[Install]
WantedBy=multi-user.target
```

自動起動有効化

``` sh
sudo systemctl start forever.service
sudo systemctl enable forever.service
```

ステータス確認

``` sh
systemctl status forever.service
```

### 参考:systemdを使って自動起動するように設定する(Ubuntu)

- [Qiita:Ubuntu16.04以降でsystemdを使ってforeverを自動起動する](https://qiita.com/subaru44k/items/eb19b8549a294145b103)

## Vue.js

### 準備

``` sh
ec2-user:~/environment/Sample_Vue $ node -v
v10.19.0
ec2-user:~/environment/Sample_Vue $ npm -v
6.13.4
```

### インストール

npmを入れた記憶がないが…まあいいか。

``` sh
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

## OWASP ZAP

- 事前にJREがインストールされていること。
- root権限が必要。
- 基本的にはウィンドウで動かすもの

``` sh
mkdir Download
cd Download

# URL,ファイル名は都度確認。
wget https://github.com/zaproxy/zaproxy/releases/download/v2.10.0/ZAP_2.10.0_Linux.tar.gz
tar xvfz ZAP_2.10.0_Linux.tar.gz
sudo mv ZAP_2.10.0/ /opt/
```

エイリアスの設定  
${HOME}/.bashrc

``` sh 
# OWASP ZAP
alias owaspzap='java -jar /opt/ZAP_2.10.0/zap-2.10.0.jar'
```

起動確認。

``` sh
owaspzap -version
```

``` txt
Defaulting ZAP install dir to /opt/ZAP_2.10.0
2.10.0
```

### メニュー日本語化

1. 起動
2. Tool→Options...
3. Language → 日本語 → OK
4. 再起動

### 備考

- Xubuntuでインストーラを実行したら、画面が起動した。（コンソールを叩いてインストールしたい。）

### 参考

- [Qiita:ubuntu18.04 + OWASP ZAP でWEB脆弱性診断](https://qiita.com/crash-boy/items/cb35eadaa4cf4d2cef3f)
- [OWASP ZAP](https://owasp.org/www-project-zap/)
- [OWASP Japan](https://owasp.org/www-chapter-japan/)