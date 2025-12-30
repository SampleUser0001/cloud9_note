# Cloud9 init note

Cloud9を起動したときに行うことの備忘録。

- [Cloud9 init note](#cloud9-init-note)
  - [git](#git)
    - [アカウントの設定](#アカウントの設定)
    - [エディタの設定](#エディタの設定)
      - [永続](#永続)
      - [一時](#一時)
  - [aws-cli](#aws-cli)
    - [一時](#一時-1)
    - [永続](#永続-1)
    - [参考](#参考)
  - [AWS SAM CLI](#aws-sam-cli)
    - [参考](#参考-1)
  - [Homebrew](#homebrew)
    - [参考](#参考-2)
  - [Java](#java)
    - [yumでJavaをインストール](#yumでjavaをインストール)
      - [参考](#参考-3)
    - [aptでJavaをインストール](#aptでjavaをインストール)
      - [参考](#参考-4)
    - [update-alternativesの選択肢に上がってくるようにする](#update-alternativesの選択肢に上がってくるようにする)
  - [Gradle](#gradle)
  - [Maven](#maven)
    - [Maven(binary)](#mavenbinary)
      - [参考](#参考-5)
    - [Maven(yum)](#mavenyum)
      - [参考](#参考-6)
  - [jd-cli(jad)](#jd-clijad)
  - [ant](#ant)
    - [antインストール](#antインストール)
  - [Spring boot cli](#spring-boot-cli)
    - [参考](#参考-7)
  - [Flutter](#flutter)
    - [Android command-line tool](#android-command-line-tool)
    - [参考](#参考-8)
  - [telnet](#telnet)
    - [telnetインストール](#telnetインストール)
  - [docker](#docker)
    - [yum](#yum)
    - [apt](#apt)
    - [rootに紐付いていないとき](#rootに紐付いていないとき)
      - [参考](#参考-9)
  - [docker-compose](#docker-compose)
    - [docker-composeインストール](#docker-composeインストール)
    - [参考サイト](#参考サイト)
  - [python](#python)
    - [pyenv](#pyenv)
    - [3.10.x以上](#310x以上)
    - [参考](#参考-10)
  - [pip3](#pip3)
    - [apt](#apt-1)
  - [PHP](#php)
    - [amazon-linux-extras](#amazon-linux-extras)
      - [参考](#参考-11)
    - [apt](#apt-2)
    - [ソースからコンパイル](#ソースからコンパイル)
      - [libxml2](#libxml2)
      - [krb5](#krb5)
      - [参考](#参考-12)
  - [Composer](#composer)
    - [よく見るエラーの対応](#よく見るエラーの対応)
      - [mbstring](#mbstring)
      - [dom](#dom)
  - [go](#go)
    - [go(参考)](#go参考)
  - [goofys](#goofys)
    - [goofysインストール](#goofysインストール)
    - [自動マウント設定](#自動マウント設定)
    - [参考](#参考-13)
  - [Node.js](#nodejs)
    - [動作確認](#動作確認)
    - [参考](#参考-14)
  - [PHPコンテナに特定バージョンのNode.jsをインストールする](#phpコンテナに特定バージョンのnodejsをインストールする)
    - [参考](#参考-15)
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
    - [参考](#参考-16)
  - [Ruby](#ruby)
    - [rbenvを使う](#rbenvを使う)
      - [rbenvインストール](#rbenvインストール)
      - [rbenvでRubyインストール](#rbenvでrubyインストール)
      - [psychでエラー](#psychでエラー)
      - [参考](#参考-17)
    - [ソースからビルドする](#ソースからビルドする)
      - [参考](#参考-18)
  - [sqlite](#sqlite)
    - [最新をインストールする](#最新をインストールする)
    - [外部キー制約を常にONにする](#外部キー制約を常にonにする)
    - [参考](#参考-19)
  - [Terraform](#terraform)
    - [参考](#参考-20)
  - [gcloud](#gcloud)
    - [参考](#参考-21)
  - [OWASP ZAP](#owasp-zap)
    - [メニュー日本語化](#メニュー日本語化)
    - [備考](#備考)
    - [参考](#参考-22)
  - [shunit2](#shunit2)
  - [utPL/SQL, utPL/SQL-cli](#utplsql-utplsql-cli)
    - [前提](#前提)
    - [JDK](#jdk)
    - [utPL/SQL-cli](#utplsql-cli)
    - [utPL/SQL](#utplsql)
    - [.env](#env)
    - [docker-compose.yml](#docker-composeyml)
    - [起動](#起動)
    - [コンテナログイン](#コンテナログイン)
    - [utPL/SQLインストール](#utplsqlインストール)
      - [インストールに失敗した場合](#インストールに失敗した場合)
    - [インストール結果確認](#インストール結果確認)

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

``` bash
git config --global core.editor 'vim -c "set fenc=utf-8"'
```

## aws-cli

一応初期設定されているが、設定を変更したい場合に行う。

### 一時

``` bash
export AWS_ACCESS_KEY_ID=****5678
export AWS_SECRET_ACCESS_KEY=****5678
```

### 永続

1. Preferences(右上)をクリック。
2. AWS Settings -> Credentials -> AWS managed temporary credentialsをoffにする。
3. ```aws configure```を実行。

### 参考

- 一時
  - [AWS ECRでAWS CLIの認証で弾かれた問題:Qiita](https://qiita.com/kaito_program/items/7b9ba489e44d2295cf6f)
- 永続
  - [Cloud9からIAM Roleの権限でAWS CLIを実行する:Developers:IO](https://dev.classmethod.jp/articles/execute-aws-cli-with-iam-role-on-cloud9/)
    - credentialsのチェックをoffにする。

## AWS SAM CLI

``` bash
cd /tmp

# 下記URLでダウンロードするバージョンを確認。
# https://github.com/aws/aws-sam-cli/releases/tag/v1.81.0
wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip

# 上記のページを見て、下記の実行結果と比較する。
# sha256sum aws-sam-cli-linux-x86_64.zip

unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
sudo ./sam-installation/install

sam --version
```

### 参考

- [AWS SAM CLI のインストール:AWS Docs](https://docs.aws.amazon.com/ja_jp/serverless-application-model/latest/developerguide/install-sam-cli.html)

## Homebrew

AWS SAM CLIの前提条件。

``` bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

~/.profile
``` bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

``` bash
source ~/.profile
sudo apt-get install build-essential
```


### 参考

- [Homebrew](https://brew.sh/index_ja)
    - 公式

## Java

Amazon Linux 2でcloud9を再作成したすると、最初から入っている。  
Mavenをyumでインストールすると7がインストールされる。

``` sh
ec2-user:~/environment $ java -version
openjdk version "11.0.10" 2021-01-19 LTS
OpenJDK Runtime Environment Corretto-11.0.10.9.1 (build 11.0.10+9-LTS)
OpenJDK 64-Bit Server VM Corretto-11.0.10.9.1 (build 11.0.10+9-LTS, mixed mode)
```

``` sh
ec2-user:~/environment $ javac -version
javac 11.0.10
```


### yumでJavaをインストール

``` bash
sudo yum -y update
sudo yum -y install java-1.8.0-openjdk-devel
```

``` bash
sudo update-alternatives --config java
```

``` bash
sudo update-alternatives --config javac
```

#### 参考

[https://docs.aws.amazon.com/ja_jp/cloud9/latest/user-guide/sample-java.html](https://docs.aws.amazon.com/ja_jp/cloud9/latest/user-guide/sample-java.html)

### aptでJavaをインストール

```
sudo apt install default-jdk
```

``` bash
$ java --version
openjdk 11.0.9.1 2020-11-04
OpenJDK Runtime Environment (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04)
OpenJDK 64-Bit Server VM (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04, mixed mode, sharing)
```

``` bash
$ javac --version
javac 11.0.9.1
```

#### 参考

[Ubuntu 20.04にAptを使用してJavaをインストールする方法](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-20-04-ja)

### update-alternativesの選択肢に上がってくるようにする

前提: 手動でJDKをダウンロード->展開->`/usr/lib/jvm/`に配置していること。

``` bash
# 2500は優先度。大きいほうが優先だが、バージョンと同値にするのが一般的？
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-25.0.1/bin/java 2500
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-25.0.1/bin/javac 2500
```

`$JAVA_HOME`は自動で指定されない。手動で書く必要がある。

## Gradle

``` bash
cd /tmp

# download
# 最新バージョンを確認
# https://gradle.org/releases/
Gradle_version=7.6
wget https://services.gradle.org/distributions/gradle-${Gradle_version}-bin.zip

# install
sudo mkdir /opt/gradle
sudo mv ./gradle-${Gradle_version}-bin.zip /opt/gradle
cd /opt/gradle
sudo unzip -d . gradle-7.6-bin.zip 
ls gradle-${Gradle_version}

```

~/.bashrc に下記を追記。

``` bash
# gradle
export PATH="$PATH:/opt/gradle/gradle-7.6/bin"
```

``` bash
source ~/.bashrc
gradle -v

sudo rm /opt/gradle/gradle-${Gradle_version}-bin.zip
```

## Maven
インストールされていない。

### Maven(binary)

バージョンは[ダウンロードページ](https://maven.apache.org/download.cgi)で事前に確認する。

``` bash
export MAVEN_VERSION=3.6.3
cd /usr/local/lib/
sudo wget https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

sudo tar -xzvf apache-maven-${MAVEN_VERSION}-bin.tar.gz
sudo mv apache-maven-${MAVEN_VERSION} /opt/
cd /opt/
sudo ln -s /opt/apache-maven-${MAVEN_VERSION} apache-maven
```

パスの追加

``` sh
sudo vi /etc/profile
```

``` sh
# Maven
MVN_HOME=/opt/apache-maven
PATH=$PATH:$MVN_HOME/bin
```

``` bash
source /etc/profile
```

``` bash
mvn -version
```

#### 参考

- [Qiita:【AWS EC2】Amazon Linux 2にMavenをインストールする方法](https://qiita.com/tamorieeeen/items/bcdf9729a5e9194c5d20)

### Maven(yum)

Java7がインストールされるため、非推奨。

``` sh
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
```

#### 参考
[https://docs.aws.amazon.com/ja_jp/cloud9/latest/user-guide/sample-java.html](https://docs.aws.amazon.com/ja_jp/cloud9/latest/user-guide/sample-java.html)


## jd-cli(jad)

逆コンパイルツール。  
git, Java, Mavenインストール済みが前提。自分でビルドする。

``` bash
cd tmp
git clone git@github.com:intoolswetrust/jd-cli.git

cd jd-cli
mvn package

sudo cp ./jd-cli/target/jd-cli.jar /opt

```

~/.bashrc

``` bash
# jd-cli
alias jd-cli="java -jar /opt/jd-cli.jar"
```

```
source ~/.bashrc
jd-cli --version
rm -rf /tmp/jd-cli
```

## ant
いらないかもしれないが入れたのでメモを残す。

### antインストール
```
ANT_VERSION=
wget https://ftp.yz.yamagata-u.ac.jp/pub/network/apache//ant/binaries/apache-ant-$ANT_VERSION-bin.tar.gz
tar zxvf apache-ant-$ANT_VERSION-bin.tar.gz
sudo mkdir /usr/share/ant
sudo mv apache-ant-$ANT_VERSION /usr/share/ant
sudo ln -s /usr/share/ant/apache-ant-$ANT_VERSION/bin/ant /usr/bin/ant
```
※yumのantは古いため使わない。

## Spring boot cli

``` sh
# バージョンは事前に確認。
export SPRING_BOOT_CLI_INSTALL_VERSION=2.6.2
cd /opt
sudo wget https://repo.spring.io/release/org/springframework/boot/spring-boot-cli/${SPRING_BOOT_CLI_INSTALL_VERSION}/spring-boot-cli-${SPRING_BOOT_CLI_INSTALL_VERSION}-bin.tar.gz
sudo tar zxvf spring-boot-cli-${SPRING_BOOT_CLI_INSTALL_VERSION}-bin.tar.gz

# パスは要確認。
# SpringBootのドキュメントにはREADMEに従えと書いてあるが・・・
sudo ln -s ${PWD}/spring-${SPRING_BOOT_CLI_INSTALL_VERSION}/bin/spring /usr/local/bin/spring

# インストールできたことを確認
spring --version

# ダウンロードしてきたファイルを削除
sudo rm spring-boot-cli-${SPRING_BOOT_CLI_INSTALL_VERSION}-bin.tar.gz
```

### 参考

- [インストールマニュアル:spring](https://spring.pleiades.io/spring-boot/docs/current/reference/html/getting-started.html#getting-started.installing.cli.manual-installation)

## Flutter

snapコマンドでインストールできるが、ここでは手動で導入する。

``` bash
mkdir /tmp/flutter-install
cd /tmp/flutter-install

# ファイルパスを参考Webページから取得する。
# flutter-url=
wget ${flutter-url}

# flutter_version=
tar xf flutter_linux_${flutter_version}-stable.tar.xz 

cp -r flutter $HOME/.local/flutter-${flutter_version}-stable
sudo ln -s $HOME/.local/flutter-${flutter_version}-stable /usr/local/bin/flutter
```

~/.bashrc

``` bash
# Flutter
export FLUTTER_HOME="/usr/local/bin/flutter"
export PATH="$PATH:$FLUTTER_HOME/bin"
```

``` bash
source ~/.bashrc
flutter doctor
# 不足しているものが出力される。開発したいものと比較して不足があればインストールする。

# flutterコマンドで使うものをまとめてインストール
sudo apt install clang curl pkg-config ninja-build cmake libgtk-3-dev libblkid-dev liblzma-dev unzip
```

### Android command-line tool

1. https://developer.android.com/studio
2. Command line tools onlyのリンクをクリックする。
3. 承認 -> ダウンロード
4. ダウンロードしたファイルを解凍する。(cmdline-toolsフォルダ配下に解凍される。)
5. `mkdir -p $HOME/Android/Sdk/cmdline-tools/latest`
6. `cp cmdline-tools/* $HOME/Android/Sdk/cmdline-tools/latest`
7. ~/.bashrc更新
    ``` bash
    # Android commandline tool
    export ANDROID_HOME="/home/ubuntuuser/Android/Sdk"
    export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
    ```
8. `source ~/.bashrc`
9. `sdkmanager --help`
    - 設定が正しいか確認する。
10. `flutter doctor`
    - Flutterに取り込む。コマンドが表示されるので実行する。

### 参考

- [Linux install : Flutter](https://docs.flutter.dev/get-started/install/linux)
- [Flutter デスクトップ 環境構築 for Linux:Qiita](https://qiita.com/kurun_pan/items/47c25a4b2425725bc199)
- [Command-line tools:Android Studio](https://developer.android.com/tools#tools-sdk)

## telnet

### telnetインストール
```
sudo yum -y install telnet
```

## docker

入ってたっけ…？記憶にない。

### yum

```
sudo yum install docker
```

### apt

- [docker docks:Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)


### rootに紐付いていないとき

``` bash
sudo groupadd docker
sudo usermod -aG docker $USER

# 仮想マシンを使っているのであれば再起動

newgrp docker

docker ps
```

#### 参考

- [Manage Docker as a non-root user:公式](https://docs.docker.com/engine/install/linux-postinstall/)

## docker-compose

### docker-composeインストール

``` bash
# バージョンは https://github.com/docker/compose/releases/ で確認。
export DOCKER_COMPOSE_VERSION=v2.3.0
sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

### 参考サイト

- [https://qiita.com/youtangai/items/ff67ceff5497a0e0b1af](https://qiita.com/youtangai/items/ff67ceff5497a0e0b1af)
- [compose:docker:Github](https://github.com/docker/compose/releases)

## python

``` sh
# インストールバージョンは事前に確認
export INSTALL_PYTHON_VERSION=3.9.9

cd /opt 
sudo wget https://www.python.org/ftp/python/${INSTALL_PYTHON_VERSION}/Python-${INSTALL_PYTHON_VERSION}.tgz
sudo tar xzf Python-${INSTALL_PYTHON_VERSION}.tgz

cd Python-${INSTALL_PYTHON_VERSION}
sudo ./configure --enable-optimizations 
sudo make altinstall 

sudo rm -f /opt/Python-${INSTALL_PYTHON_VERSION}.tgz 

# /usr/local/binにインストールされる。シンボリックリンクを貼る。
cd /usr/local/bin

# ファイル名を確認
ls python*
sudo ln -s /usr/local/bin/${lsで確認したpythonコマンドのファイル名} python3
ls pip*
sudo ln -s /usr/local/bin/${lsで確認したpipコマンドのファイル名} pip3
```

### pyenv

``` bash
sudo yum update -y
# openssl-devalをインストールすると3.10.xをインストールするときに競合が発生するという情報がある。
sudo yum install gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
pyenv version

```

~/.bashrcに下記を追記
``` bashrc
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$HOME/.pyenv/bin"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
```

### 3.10.x以上

OpenSSL1.1.1以上が必要。

``` bash
# Amazon Linux 2の場合
sudo yum install -y openssl11 openssl11-devel

# 使っていたら削除する。
# sudo yum list openssl
# sudo yum remove -y openssl-devel
```


### 参考

- [Tecadmin](https://tecadmin.net/install-python-3-9-on-amazon-linux/)
- [OpenSSL 1.1.1 が必須なPython 3.10.x をAmazon Linux 2 にインストールする](https://blog.serverworks.co.jp/install-python3-with-openssl11)
- [Amazon Linux 2でDjango実行環境を構築する:DevelopersIO](https://dev.classmethod.jp/articles/run-django-on-amazon-linux-2/)

## pip3

### apt

``` sh
sudo apt update && sudo apt -y upgrade
sudo apt install -y python3-pip
```

`${HOME}/.bashrc`

``` sh
alias pip=pip3
```

## PHP

Laravel用のComposerをインストールするときに使う。

Laravelをローカルで管理するだけなら、Dockerとdocker-composeがあればいいが、gitのリモートリポジトリにpushする場合は、(デフォルトでは)vender配下がpushされない。  
```composer update```が必要だが、composerインストールでphpコマンドを使う。

AWS cloud9(Amazon Linux 2)には一応最初から入っている。

``` sh
ec2-user:~/environment $ php -v
PHP 7.2.24 (cli) (built: Oct 31 2019 18:27:08) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
```

### amazon-linux-extras

AWS cloud9用。

現在稼働中のバージョンとインストールできるバージョンの確認。

``` sh
amazon-linux-extras list | less
```

``` sh
sudo amazon-linux-extras disable lamp-mariadb10.2-php7.2
sudo amazon-linux-extras enable php8.0
```

``` sh
sudo yum remove mariadb-*
sudo yum remove php-*
```

``` sh
sudo yum clean metadata
sudo yum install php-cli php-pdo php-fpm php-mysqlnd 
```

``` sh
ec2-user:~/environment/Practice_Laravel/practice-laravel (main) $ php -v
PHP 8.0.2 (cli) (built: Feb 11 2021 18:25:29) ( NTS )
Copyright (c) The PHP Group
Zend Engine v4.0.2, Copyright (c) Zend Technologies
```

#### 参考

- [AWS:Amazon Linux 2 を実行している EC2 インスタンスに Extras Library からソフトウェアパッケージをインストールする方法を教えてください。](https://aws.amazon.com/jp/premiumsupport/knowledge-center/ec2-install-extras-library-software/)

### apt

この方法は最新バージョンが手に入らない。(Composer用なら気にしなくてよい？)

``` sh
sudo apt install -y php
```

``` sh
php --version
```

### ソースからコンパイル

最新を確認。

[PHP:Download](https://www.php.net/downloads.php)

足りないものは都度インストール。  
※完了できていない。

``` sh
sudo su
export PHP_VERSION=8.0.3
cd /usr/local/src
wget https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz
tar zxvf php-${PHP_VERSION}.tar.gz
cd php-${PHP_VERSION}
./buildconf --force
./configure --with-libdir=lib64 --with-pic --with-bz2 --with-freetype-dir --with-png-dir --with-xpm-dir --with-gettext --with-gmp --with-iconv --with-jpeg-dir --with-curl --with-webp-dir --with-png-dir --with-openssl --with-pcre-regex --with-zlib --with-layout=GNU --enable-exif --enable-ftp --enable-sockets --with-kerberos --enable-shmop --enable-calendar --with-libxml-dir --with-mhash --with-ldap --with-readline --with-snmp --with-tidy --with-xsl --with-gnu-ld --enable-mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-mysql-sock=/var/lib/mysql/mysql.sock --enable-mbstring --with-gd --with-apxs2=/usr/bin/apxs
make
make install
```

#### libxml2

``` sh
cd /tmp
git clone https://gitlab.gnome.org/GNOME/libxml2.git
cd libxml2
sh ./autogen.sh
./configure --prefix=/usr
make
make install
```

#### krb5

``` sh
apt install krb5-*
```

#### 参考

- [Qiita:CentOS 7 PHP 7.2.3のソースファイルからのインストール](https://qiita.com/knutpb1205/items/cba2610b4ccb5ecd7b92)

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

### よく見るエラーの対応

#### mbstring

``` sh
sudo yum -y install php-mbstring
```

#### dom

``` sh
sudo yum -y install php-xml
```

## go

一応aptもあるが・・・

``` bash
mkdir /tmp/go_install
cd /tmp/go_install

# https://go.dev/dl/
go_install_version=
# 自分の環境を確認
wget https://go.dev/dl/go${go_install_version}.linux-amd64.tar.gz
tar zxvf go${go_install_version}.linux-amd64.tar.gz

sudo cp -r go /usr/local/go_${go_install_version}
sudo ln -s /usr/local/go_${go_install_version} /usr/local/go

# go installコマンドで$GOPATH/bin配下にインストールされる。
sudo chmod go+w /usr/local/go/bin
sudo chmod go+w /usr/local/go/pkg
```

`$HOME/.profile`

``` bash
# go
export GOPATH=/usr/local/go
export PATH=$PATH:$GOPATH/bin
```

``` bash
source $HOME/.profile
```

### go(参考)

- [Qiita:Ubuntuに最新のGolangをインストールする](https://qiita.com/notchi/items/5f76b2f77cff39eca4d8)
  - 最新が欲しい時に使う。

## goofys

S3バケットをEC2のストレージとしてマウントすることができる。

### goofysインストール

S3バケットは作成済み、AWS CLIは設定済みの前提。

go, fuseインストール

``` bash
sudo yum install golang fuse
```

goofysインストール

``` bash
export GOPATH=$HOME/go
go get github.com/kahing/goofys
go install github.com/kahing/goofys
```

S3マウント

``` bash
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
mkdir tmp
cd tmp

# 最新バージョンは下記で確認。
# https://github.com/nvm-sh/nvm/releases
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
reboot
```

```
# インストール可能バージョンの確認
nvm ls-remote | less
nvm install ${インストールしたいバージョン}
```

```
sudo vi /etc/profile
```

```
# Node.js setting
source ~/.nvm/nvm.sh
nvm use v14.16.0
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

## PHPコンテナに特定バージョンのNode.jsをインストールする

``` Dockerfile
FROM node:13.14.0 as node
FROM php:7.4-fpm

COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs \
    && ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

RUN node --version
# 13.14.0

RUN npm install npm@7.6.0 -g
RUN npm --version
# 7.6.0
```

### 参考

- [PHPやRubyとNode.jsを同一コンテナ内に手っ取り早く管理したい人のためのマルチステージビルド:Qiita](https://qiita.com/ProjectEuropa/items/7435976d92793c8e9fe3)

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

## Ruby

### rbenvを使う

#### rbenvインストール

``` bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

cd ~/.rbenv && src/configure && make -C src

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
# お好みで.bashrcにコメントを書く
source ~/.bashrc

# バージョン確認
rbenv --version

rbenv init
# 「~/.bash_profile」に記載しろというコメントとともにコマンドが表示される。
# 表示されたとおりのコマンドを書く。

source ~/.bash_profile
```

#### rbenvでRubyインストール

``` bash
# インストール可能な安定バージョンを確認
rbenv install -l

# バージョン指定してインストール
rbenv install ${RUBY_INSTALL_VERSION}
# そこそこ時間がかかる。インストールログが/tmp配下に出力されるので眺める。

# 指定したバージョンがインストールされていることを確認
rbenv versions

# バージョン切り替え
rbenv global ${RUBY_INSTALL_VERSION}

# 切り替わったことを確認
ruby -v
```

#### psychでエラー

``` txt
*** Following extensions are not compiled:
psych:
	Could not be configured. It will not be installed.
	Check /tmp/ruby-build.20240317155445.53115.EZ0AGq/ruby-3.3.0/ext/psych/mkmf.log for more details.

BUILD FAILED (Ubuntu 22.04 on x86_64 using ruby-build 20240221)
```

``` bash
sudo apt-get install libyaml-dev
```



#### 参考

- [CentOSにrbenv, Rubyをインストールする:Qiita](https://qiita.com/NaokiIshimura/items/ff04b6eaa40b33c4bea8)
- [rbenv:Github](https://github.com/rbenv/rbenv)
- [ruby-build:Github](https://github.com/rbenv/ruby-build)

### ソースからビルドする

``` bash
cd /tmp
# バージョンは公式サイトで確認
export RUBY_INSTALL_VERSION=3.1.2
wget https://cache.ruby-lang.org/pub/ruby/$(echo ${RUBY_INSTALL_VERSION} | cut -c 1-3)/ruby-${RUBY_INSTALL_VERSION}.tar.gz

# 解凍
tar zxvf ruby-${RUBY_INSTALL_VERSION}.tar.gz

# ビルド
cd ruby-${RUBY_INSTALL_VERSION}
./configure
make
sudo make install

# バージョン確認
/usr/local/bin/ruby --version

# ファイル削除
rm /tmp/ruby-${RUBY_INSTALL_VERSION}.tar.gz
rm -r /tmp/ruby-${RUBY_INSTALL_VERSION}
```

``` bash
nano ~/.bashrc
```

``` bash
# Ruby 
alias ruby=/usr/local/bin/ruby
```

``` bash
source ~/.bashrc
```

#### 参考

- [Rubyのインストール](https://www.ruby-lang.org/ja/documentation/installation/#building-from-source)

## sqlite

最新ではない点に注意。

``` bash
sudo apt update && sudo apt upgrade
sudo apt install -y sqlite3
```

### 最新をインストールする

``` bash
cd /tmp
# バージョンは下記で確認する。
# https://www.sqlite.org/download.html
# 下記のURLは確認した時点での最新
export SQLITE_YEAR=2022
export SQLITE_VERSION=3390000
wget https://www.sqlite.org/${SQLITE_YEAR}/sqlite-autoconf-${SQLITE_VERSION}.tar.gz
tar xvfz sqlite-autoconf-${SQLITE_VERSION}.tar.gz

# ビルド
cd sqlite-autoconf-${SQLITE_VERSION}
./configure --prefix=/usr/local
make

# インストール
sudo make install

# インストール結果確認
sudo find /usr/ -name sqlite3

# 不要ファイル/ディレクトリ削除
cd ..
rm sqlite-autoconf-${SQLITE_VERSION}.tar.gz
rm -r sqlite-autoconf-${SQLITE_VERSION}

# バージョン確認
# 新しいはず
/usr/local/bin/sqlite3 --version
# 古いはず
/usr/bin/sqlite3 --version
# 新しいはず
sqlite3 --version

sudo mv /usr/bin/sqlite3 /usr/bin/sqlite3_old
sudo ln -s /usr/local/bin/sqlite3 /usr/bin/sqlite3
ls -all /usr/bin/sqlite3
/usr/bin/sqlite3 --version
```

``` bash
# Pythonで使う場合は下記も実行する。
echo "export LD_LIBRARY_PATH=\"/usr/local/lib\"" >> ~/.bashrc
source ~/.bashrc
python
```

``` python
import sqlite3
sqlite3.sqlite_version
exit()
```

### 外部キー制約を常にONにする

``` bash
touch ~/.sqliterc
echo "PRAGMA foreign_keys = ON;" >> ~/.sqliterc
```

### 参考

- [SQLite Download Page](https://www.sqlite.org/download.html)
- [Django2.2で開発サーバー起動時にSQLite3のエラーが出た場合の対応:Qiita](https://qiita.com/rururu_kenken/items/8202b30b50e3bfa75821)
- [sqlite3で外部キー制約を常に有効にする:NANSYSTEM](https://nansystem.com/sqlite3-enable-foreign-key/)

## Terraform

``` sh
# latest version
# https://www.terraform.io/downloads
export TERRAFORM_INSTALL_VERSION=1.1.3

# download last version
# OSは確認すること。
wget https://releases.hashicorp.com/terraform/${TERRAFORM_INSTALL_VERSION}/terraform_${TERRAFORM_INSTALL_VERSION}_linux_amd64.zip

# unzip in bin folder
sudo unzip ./terraform_${TERRAFORM_INSTALL_VERSION}_linux_amd64.zip -d /usr/local/bin/

# check its working
terraform -v
```

### 参考

- [5分で分かるTerraform（Infrastructure as Code）:LAC WATCH](https://www.lac.co.jp/lacwatch/service/20200903_002270.html)

## gcloud

``` bash
# ${home}がおすすめだが・・・
cd ~

# コマンドは参考から取得
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-477.0.0-linux-x86_64.tar.gz
tar -xf google-cloud-cli-477.0.0-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh

source ~/.bashrc

gcloud init
```

### 参考

- [gcloud install](https://cloud.google.com/sdk/docs/install?hl=ja)

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

sudo ln -s /opt/ZAP_2.10.0/ /opt/owaspzap
sudo ln -s /opt/ZAP_2.10.0/zap-2.10.0.jar /opt/owaspzap/zap.jar

```
エイリアスの設定  
`${HOME}/.bashrc`

``` sh 
# OWASP ZAP
alias owaspzap='java -jar /opt/owaspzap/zap.jar'
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

## shunit2

``` bash
# ファイルパスは下記を確認。
# https://github.com/kward/shunit2/releases/

# shunit_version=2.1.8
cd /tmp
wget https://github.com/kward/shunit2/archive/refs/tags/v${shunit_version}.tar.gz
tar -xvf v${shunit_version}.tar.gz
sudo mv shunit2-${shunit_version} /opt

rm v${shunit_version}.tar.gz

sudo ln -s /opt/shunit2-${shunit_version} /opt/shunit2 

echo '# shunit2 Home' >> ~/.bashrc
echo 'export SHUNIT2_HOME=/opt/shunit2' >> ~/.bashrc

source ~/.bashrc

ls $SHUNIT2_HOME
```

## utPL/SQL, utPL/SQL-cli

### 前提

OracleのDockerコンテナで動かす。

### JDK

OpenJDKを使用する。

``` bash
# URLはhttps://jdk.java.net/で確認。
wget https://download.java.net/java/GA/jdk23.0.1/c28985cbf10d4e648e4004050f8781aa/11/GPL/openjdk-23.0.1_linux-x64_bin.tar.gz
ls openjdk* | xargs tar zxvf 

# コンテナ内から書き込みを行うときに必要になる。
find jdk* -type d | xargs chmod 777
```

### utPL/SQL-cli

[utPL/SQL-cli](https://github.com/utPLSQL/utPLSQL-cli)

``` bash
# バージョンは確認。
wget https://github.com/utPLSQL/utPLSQL-cli/releases/download/3.1.9/utPLSQL-cli.zip
unzip utPLSQL-cli.zip

find utPLSQL-cli -type d | xargs chmod 777
```

### utPL/SQL

[utPL/SQL](https://github.com/utPLSQL/utPLSQL)

``` bash
wget https://github.com/utPLSQL/utPLSQL/releases/download/v3.1.14/utPLSQL.tar.gz
tar zxvf utPLSQL.tar.gz

find utPLSQL -type d | xargs chmod 777
```

### .env

``` bash
export PATH=/home/oracle/jdk-23.0.1/bin:/home/oracle/utPLSQL-cli/bin:$PATH
```

### docker-compose.yml

必要なのは下記。  
`PATH`に`java`と`utplsq`を追加したいが、`environment`に書くと、なぜか`sqlplus`コマンドが使えなくなり、コンテナ起動に失敗する。  
`.env`を持ち込んで、コンテナログイン後に実行する。

``` yml
    environment:
      - ORACLE_PWD=password
      - JAVA_HOME=/home/oracle/jdk-23.0.1
```

``` yml
    volumes:
      - ./jdk-23.0.1:/home/oracle/jdk-23.0.1
      - ./utPLSQL:/home/oracle/utPLSQL:rw
      - ./utPLSQL-cli:/home/oracle/utPLSQL-cli
      - .env:/home/oracle/.env
```

全部版。

``` yml
services:
  oracle-db:
    image: oracle/database:23.5.0-free
    container_name: oracle-db
    environment:
      - ORACLE_PWD=password
      - JAVA_HOME=/home/oracle/jdk-23.0.1
    ports:
      - "1521:1521"
    volumes:
      - ./plsql:/home/oracle/plsql
      - ./shell:/home/oracle/shell
      - ./datas:/home/oracle/datas:rw
      - ./csv_import:/home/oracle/csv_import:rw
      - ./samples:/home/oracle/samples
      - ./test:/home/oracle/test
      - ./jdk-23.0.1:/home/oracle/jdk-23.0.1
      - ./utPLSQL:/home/oracle/utPLSQL:rw
      - ./utPLSQL-cli:/home/oracle/utPLSQL-cli
      - .env:/home/oracle/.env
      - ./entrypoint.sh:/home/oracle/entrypoint.sh
```

### 起動

``` bash
docker compose up -d
docker compose logs -f
```

### コンテナログイン

``` bash
docker exec -it oracle-db bash

# javaとutplsqlへのパスを通す。
source .env
```

### utPL/SQLインストール

``` bash
cd utPLSQL/source

# systemユーザからだとインストールできなかった。(as sysdbaを指定していなかったからかもしれないが・・・)
sqlplus sys/password@//localhost:1521/FREEPDB1 as sysdba @install_headless.sql
```

``` sql
-- UTPLSQLを実行するユーザー（例: SYSTEM）に権限を付与
GRANT INHERIT PRIVILEGES ON USER UT3 TO SYSTEM;

-- UTPLSQLがアクセスする必要のあるユーザー（UT3）に権限を付与
GRANT INHERIT PRIVILEGES ON USER SYSTEM TO UT3;
```

#### インストールに失敗した場合

一度全消しする。  
デフォルトでは最初に`UT3`ユーザが作成される。

``` sql
DROP USER UT3 CASCADE;
```

``` bash
sqlplus sys/password@//localhost:1521/FREEPDB1 as sysdba @uninstall_all.sql
```

### インストール結果確認

``` sql
-- たくさん出てくるはず。
SELECT object_name, object_type
FROM all_objects
WHERE owner = 'UT3';
```

``` bash
utplsql info system/password@//localhost:1521/FREEPDB1
```

