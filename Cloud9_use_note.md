# Cloud9 Use Note
Cloud9を使うときに一緒に持っていきたいメモ

- [Cloud9 Use Note](#cloud9-use-note)
  - [ドキュメントホーム](#ドキュメントホーム)
  - [git](#git)
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
  - [AWS](#aws)
    - [グローバルIP取得](#グローバルip取得)
    - [S3](#s3)
      - [例のページ](#例のページ)
  - [WSL2](#wsl2)
    - [使用可能なメモリを増やす](#使用可能なメモリを増やす)
      - [参考](#参考-3)
  - [その他](#その他)

## ドキュメントホーム
[https://docs.aws.amazon.com/cloud9/index.html](https://docs.aws.amazon.com/cloud9/index.html)

## git

[git.md](./Git_cli/git.md)

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

[Docker.md](./Docker/Docker.md)

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

## WSL2

### 使用可能なメモリを増やす

Windows側から設定する。

1. ```%UserProfile%\.wslconfig```を開く。
2. memoryの値を修正する。
3. PowerShellで下記を実行する。
   - ```wsl --shutdown```


#### 参考

- [Qiita:WSL2のメモリ割り当て量を変えたい](https://qiita.com/Ischca/items/121d91eb3b1a0a1cd8a8)

## その他

- [Githubの認証方法をプライベートトークンに変更する](./other/Github_authentication_token.md)
