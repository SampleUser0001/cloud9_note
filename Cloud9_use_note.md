# Cloud9 Use Note

## 概要
Cloud9を使うときに一緒に持っていきたいメモ

## ドキュメントホーム
https://docs.aws.amazon.com/cloud9/index.html

## git

### .gitignoreについて
https://qiita.com/inabe49/items/16ee3d9d1ce68daa9fff

## Maven

### 新規プロジェクト作成
```
mvn -B archetype:generate \
 -DarchetypeGroupId=org.apache.maven.archetypes \
 -DgroupId=jp.tool.linux.organizer.top \
 -DartifactId=organizer_for_top_command
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
https://qiita.com/KevinFQ/items/e8363ad6123713815e68

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
https://qiita.com/hide/items/0c8795054219d04e5e98

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

## ant

### サンプルダウンロード
```
git pull https://github.com/SampleUser0001/ant_Sample.git
```

## Docker

## AWS

### グローバルIP取得
curl http://169.254.169.254/latest/meta-data/public-ipv4
