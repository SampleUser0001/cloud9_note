# Cloud9 Use Note

## 概要
Cloud9を使うときに一緒に持っていきたいメモ

## ドキュメントホーム
https://docs.aws.amazon.com/cloud9/index.html

## Maven

### 新規プロジェクト作成
```
mvn -B archetype:generate \
 -DarchetypeGroupId=org.apache.maven.archetypes \
 -DgroupId=sample.getPowerMock \
 -DartifactId=GetPowerMock
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
