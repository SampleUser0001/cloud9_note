# Tomcat

- [Tomcat](#tomcat)
  - [ディレクトリ構成](#ディレクトリ構成)
    - [conf配下](#conf配下)
    - [webapps配下](#webapps配下)
  - [環境変数](#環境変数)
  - [Dockerコンテナとして起動する](#dockerコンテナとして起動する)
    - [設定ファイルの取得](#設定ファイルの取得)
    - [tomcat/webapps/${APPLICATION_NAME}/WEB-INF/web.xml](#tomcatwebappsapplication_nameweb-infwebxml)
    - [tomcat/webapps/${APPLICATION_NAME}/index.html](#tomcatwebappsapplication_nameindexhtml)
    - [docker-compose.yml](#docker-composeyml)

## ディレクトリ構成

```
bin/
conf/
lib/
logs/
temp/
webapps/
work/
```

### conf配下

- catalina.policy（Tomcat で利用するセキュリティマネージャのセキュリティポリシーファイル）
- catalina.properties（Tomcat 実行時に利用するシステムプロパティ設定ファイル）
- context.xml（すべてのContext で共通的に利用するContext ディスクリプタ）
- logging.properties（ロギング設定ファイル）
- server.xml（Tomcat 設定ファイル）
- tomcat-users.xml（ユーザ情報定義ファイル）
- web.xml（すべてのWeb アプリケーションで利用するWeb アプリケーションディスクリプタ）

### webapps配下

``` bash
./${TOMCAT_APPLICATION_NAME}/WEB-INF/web.xml
./${TOMCAT_APPLICATION_NAME}/WEB-INF/*.html
./${TOMCAT_APPLICATION_NAME}/WEB-INF/classes/**/*.class
./${TOMCAT_APPLICATION_NAME}/WEB-INF/lib/**/*.jar
```

## 環境変数

| 環境変数名 | 概要 | デフォルト |
| :--------- | :--- | :--------- |
| CATALINA_BASE | ロギング、作業ディレクトリ、confディレクトリ、webappディレクトリ等のベースディレクトリ | Tomcatインストールディレクトリ |
| CATALINA_HOME | lib、スクリプトなどの静的なものが格納されているディレクトリ | Tomcatインストールディレクトリ |

## Dockerコンテナとして起動する

### 設定ファイルの取得

``` bash
export TOMCAT_DOCKER_IMAGE=9.0
export TOMCAT_APPLICATION_NAME=sampleapp
docker run -d --rm --name tmp_tomcat tomcat:${TOMCAT_DOCKER_IMAGE}
mkdir -p tomcat/logs
mkdir -p tomcat/webapps/${TOMCAT_APPLICATION_NAME}/WEB-INF
mkdir -p tomcat/webapps/${TOMCAT_APPLICATION_NAME}/WEB-INF/classes
mkdir -p tomcat/webapps/${TOMCAT_APPLICATION_NAME}/WEB-INF/lib

touch tomcat/webapps/${TOMCAT_APPLICATION_NAME}/WEB-INF/web.xml

docker cp tmp_tomcat:/usr/local/tomcat/conf tomcat/

# いらないだろうが・・・
docker cp tmp_tomcat:/usr/local/tomcat/webapps.dist tomcat/

docker stop tmp_tomcat
```

### tomcat/webapps/${APPLICATION_NAME}/WEB-INF/web.xml

```tomcat/webapps.dist/examples/WEB-INF/web.xml```を参照。

``` xml
<web-app xmlns="https://jakarta.ee/xml/ns/jakartaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee
                      https://jakarta.ee/xml/ns/jakartaee/web-app_5_0.xsd"
  version="5.0"
  metadata-complete="true">

  <display-name>Sample Application</display-name>
  <description>
     Tomcat sample application.
  </description>
  <request-character-encoding>UTF-8</request-character-encoding>
  
  <welcome-file-list>
    <welcome-file>index.html</welcome-file>
    <welcome-file>index.xhtml</welcome-file>
    <welcome-file>index.htm</welcome-file>
    <welcome-file>index.jsp</welcome-file>
  </welcome-file-list>

</web-app>
```

### tomcat/webapps/${APPLICATION_NAME}/index.html

``` html
Hello Tomcat!
```

``` bash
echo 'Hello Tomcat!' > tomcat/webapps/${APPLICATION_NAME}/index.html
```

### docker-compose.yml

``` yml
version: '3'
services:
  tomcat:
    image: tomcat:${任意のバージョン}
    container_name: tomcat
    ports: 
      - "8080:8080"
    volumes:
      - ./tomcat/webapps:/usr/local/tomcat/webapps
      - ./tomcat/webapps.dist:/usr/local/tomcat/webapps.dist
      - ./tomcat/logs:/usr/local/tomcat/logs
      - ./tomcat/conf:/usr/local/tomcat/conf
```

