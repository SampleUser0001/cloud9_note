# Cloud9 Use Note
Cloud9を使うときに一緒に持っていきたいメモ

- [Cloud9 Use Note](#cloud9-use-note)
  - [ドキュメントホーム](#ドキュメントホーム)
  - [git](#git)
    - [.gitignoreについて](#gitignoreについて)
    - [親ブランチを取得する](#親ブランチを取得する)
  - [Maven](#maven)
    - [新規プロジェクト作成](#新規プロジェクト作成)
    - [WebApplicationプロジェクト作成](#webapplicationプロジェクト作成)
      - [参考](#参考)
    - [Javaバージョンを指定する](#javaバージョンを指定する)
    - [exec:javaコマンドで実行する](#execjavaコマンドで実行する)
      - [引数でmainメソッドのクラスを指定する](#引数でmainメソッドのクラスを指定する)
      - [起動引数を渡す](#起動引数を渡す)
    - [dependencyタグのjarをまとめてjarにする](#dependencyタグのjarをまとめてjarにする)
      - [参考](#参考-1)
    - [getter,setterを作成しない](#gettersetterを作成しない)
      - [参考](#参考-2)
  - [ディスク使用量チェック](#ディスク使用量チェック)
    - [コマンド](#コマンド)
    - [ディレクトリごとの使用量確認](#ディレクトリごとの使用量確認)
  - [ant](#ant)
    - [サンプルダウンロード](#サンプルダウンロード)
  - [Docker](#docker)
    - [nginxイメージを使用して公開する](#nginxイメージを使用して公開する)
      - [docker-compose.yml](#docker-composeyml)
      - [起動コマンド](#起動コマンド)
    - [shを実行する](#shを実行する)
      - [ディレクトリ構造](#ディレクトリ構造)
      - [Dockerfile](#dockerfile)
      - [docker-compose.yml](#docker-composeyml-1)
      - [start.sh](#startsh)
      - [Dockerコマンド](#dockerコマンド)
  - [Linux](#linux)
    - [scpコマンド](#scpコマンド)
      - [scp 参考](#scp-参考)
    - [ファイル名にDateを使う](#ファイル名にdateを使う)
    - [Shell](#shell)
      - [ディレクトリ配下のファイルでループする](#ディレクトリ配下のファイルでループする)
      - [ファイルを一行ずつ読み込んでループする](#ファイルを一行ずつ読み込んでループする)
      - [起動引数を使う](#起動引数を使う)
      - [部分文字列の取得](#部分文字列の取得)
        - [部分文字列の取得：参考](#部分文字列の取得参考)
  - [sql*plus](#sqlplus)
    - [横幅を調整する](#横幅を調整する)
    - [項目表示時の横幅を調節する](#項目表示時の横幅を調節する)
    - [ヘッダ業の表示タイミングを制御する](#ヘッダ業の表示タイミングを制御する)
  - [AWS](#aws)
    - [グローバルIP取得](#グローバルip取得)
    - [S3](#s3)
      - [例のページ](#例のページ)

## ドキュメントホーム
[https://docs.aws.amazon.com/cloud9/index.html](https://docs.aws.amazon.com/cloud9/index.html)

## git

### .gitignoreについて
[https://qiita.com/inabe49/items/16ee3d9d1ce68daa9fff](https://qiita.com/inabe49/items/16ee3d9d1ce68daa9fff)

### 親ブランチを取得する
```
git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -1 | awk -F'[]~^[]' '{print $2}'
```

## Maven

### 新規プロジェクト作成
```
mvn -B archetype:generate \
 -DarchetypeGroupId=org.apache.maven.archetypes \
 -DgroupId=sample.json \
 -DartifactId=Use_Json_in_Java
```

※変更していいのは3行目と4行目のみ。1行目と2行目は変えてはいけない。

### WebApplicationプロジェクト作成

```
mvn -B archetype:generate \
  -DarchetypeArtifactId=maven-archetype-webapp \
  -DgroupId=com.example.log4j2 \
  -DartifactId=Log4j2_Web_Application_Sample
```

#### 参考
[https://qiita.com/KevinFQ/items/e8363ad6123713815e68](https://qiita.com/KevinFQ/items/e8363ad6123713815e68)

### Javaバージョンを指定する
```
<properties>
  <java.version>1.8</java.version>
  <maven.compiler.target>${java.version}</maven.compiler.target>
  <maven.compiler.source>${java.version}</maven.compiler.source>
  <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  <project.mainClass>com.example.Main</project.mainClass>
</properties>
```

### exec:javaコマンドで実行する
```
<build>
  <plugins>
    <plugin>
      <groupId>org.codehaus.mojo</groupId>
      <artifactId>exec-maven-plugin</artifactId>
      <version>1.2.1</version>
      <configuration>
        <mainClass>com.example.Main</mainClass>
      </configuration>
    </plugin>
  </plugins>
</build>
```

#### 引数でmainメソッドのクラスを指定する

```
exec:java -Dexec.mainClass="<クラス名>"
```

#### 起動引数を渡す

```
mvn exec:java -Dexec.mainClass="<クラス名>" -Dexec.args="'<引数１>' '<引数２>' ..."
```
シングルクオーテーションはなくても動くが、スペースを含む場合は必要。

### dependencyタグのjarをまとめてjarにする
```
<plugin>
  <artifactId>maven-assembly-plugin</artifactId>
  <version>3.2.0</version>
  <executions>
    <execution>
      <id>make-assembly</id>
      <phase>package</phase>
      <goals>
        <goal>single</goal>
      </goals>
    </execution>
  </executions>
  <configuration>
    <descriptorRefs>
      <descriptorRef>jar-with-dependencies</descriptorRef>
    </descriptorRefs>
    <archive>
      <manifest>
        <mainClass>sample.mq.client.MQClientSample</mainClass>
      </manifest>
    </archive>
  </configuration>
</plugin>
```

#### 参考
[https://qiita.com/hide/items/0c8795054219d04e5e98](https://qiita.com/hide/items/0c8795054219d04e5e98)

### getter,setterを作成しない

```
<!-- https://mvnrepository.com/artifact/org.projectlombok/lombok -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.12</version>
    <scope>provided</scope>
</dependency>
```

#### 参考

https://qiita.com/opengl-8080/items/671ffd4bf84fe5e32557  
https://mvnrepository.com/artifact/org.projectlombok/lombok

## ディスク使用量チェック
https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ebs-describing-volumes.html

### コマンド
```
df -hT /dev/xvda1
```

### ディレクトリごとの使用量確認
```
du -ms <対象ディレクトリ>　| sort -nr | less
```

## ant

### サンプルダウンロード
```
git pull https://github.com/SampleUser0001/ant_Sample.git
```

## Docker

### nginxイメージを使用して公開する

#### docker-compose.yml

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

#### 起動コマンド

```
docker-compose up
```

### shを実行する

#### ディレクトリ構造

```
.
├── Dockerfile
├── app
│   └── app.js
├── docker-compose.yml
└── start.sh
```

#### Dockerfile

```
# 任意のイメージを取得
FROM node

WORKDIR /app

COPY app /app
COPY start.sh /start.sh

RUN chmod 755 /start.sh

CMD [ "/start.sh" ]
```

#### docker-compose.yml

サービス名、コンテナ名は任意。  
ポートは外からアクセスするために必要なポートを開ける。
```
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

#### start.sh

```
#!/bin/bash

exec node app.js
```

#### Dockerコマンド

```
chmod 755 start.sh
docker-compose build
docker-compose up -d
```


## Linux

### scpコマンド

```
scp <ローカルパス> <ユーザ名>@<接続先ホスト>:<コピー先パス>
```
#### scp 参考

[Qiita:scpコマンド](https://qiita.com/chihiro/items/142ebe6980a498b5d4a7)

### ファイル名にDateを使う

```
cp -p <ファイル名> <ファイル名>`date "+%Y%m%d_%H%M%S"`.<拡張子>
```

### Shell

#### ディレクトリ配下のファイルでループする

```
for file in $(pwd)/<対象ディレクトリ>/* ; do
    echo ${file}
done 
```

#### ファイルを一行ずつ読み込んでループする

```
while read data ; do
    echo ${data}
done << END
`cat <対象ファイル>`
```

#### 起動引数を使う

シェル
```sh
#!/bin/bash

echo $1
echo $2
```

実行結果
```
ittimfn@DESKTOP-N4JLN1S:~/cloud9_note/tmp$ sh start.sh hoge piyo
hoge
piyo
```

#### 部分文字列の取得
※WSL2だと動かない。
```
${変数名:開始位置:取得文字数}
```
- 変数名に「$」は不要。
- 開始位置は0基底。

シェル
```
#!/bin/bash

HOGE="abcdef"

# オフセット位置から長さ分を取得
echo ${HOGE:0:2}
# -> ab

echo ${HOGE:2:2}
# -> cd

echo ${HOGE:4:2}
# -> ef

# 長さを省略した場合はオフセットから最後まで出力
echo ${HOGE:2}
# -> cdef

# 長さにマイナスを指定した場合は最後からマイナス分引いた位置までの長さになる
echo ${HOGE:0:-2}
# -> abcd

# オフセットの位置にマイナスを指定した場合は文法として別のパラメータ展開になる(デフォルト値の指定)
# 指定した変数が空文字列の場合は右に指定した文字が入る
echo ${HOGE:-2}
# -> abcdef
HOGE=
echo ${HOGE:-2}
# -> 2
```
実行結果
```
ab
cd
ef
cdef
abcd
abcdef
2
```

##### 部分文字列の取得：参考

[Qiita:bashで変数から部分文字列を取得する](https://qiita.com/koara-local/items/04d3efd1031ea62d8db5)

## sql*plus

### 横幅を調整する

```
set linesize <値>
```

### 項目表示時の横幅を調節する

```
column <列名> format a{値} [TRUNCATE]
```

### ヘッダ業の表示タイミングを制御する

```
set pagesize <値>
```

## AWS

### グローバルIP取得

```
curl http://169.254.169.254/latest/meta-data/public-ipv4
```

### S3

#### 例のページ

down
```
aws s3 cp s3://ittimfn-public/index.html .
```

up
```
aws s3 cp ./index.html s3://ittimfn-public/index.html
```

