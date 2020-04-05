# Cloud9 init note

## 概要
Cloud9を起動したときに行うことの備忘録。

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
```
cd 
vi .bashrc
```

```
    # git config --global core.editor /usr/bin/nano
    git config --global core.editor /usr/bin/vim
```

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

