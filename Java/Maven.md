# Maven

- [Maven](#maven)
  - [新規プロジェクト作成](#新規プロジェクト作成)
  - [WebApplicationプロジェクト作成](#webapplicationプロジェクト作成)
    - [参考](#参考)
  - [Javaバージョンを指定する](#javaバージョンを指定する)
  - [SpringBootの場合](#springbootの場合)
  - [src/main/resources配下のファイルパスを取得する](#srcmainresources配下のファイルパスを取得する)
  - [exec:javaコマンドで実行する](#execjavaコマンドで実行する)
    - [引数でmainメソッドのクラスを指定する](#引数でmainメソッドのクラスを指定する)
    - [起動引数を渡す](#起動引数を渡す)
  - [dependencyタグのjarをまとめてjarにする](#dependencyタグのjarをまとめてjarにする)
    - [参考](#参考-1)
  - [getter,setterを作成しない](#gettersetterを作成しない)
    - [参考](#参考-2)
  - [依存ライブラリを取り込む](#依存ライブラリを取り込む)

## 新規プロジェクト作成
``` sh
mvn -B archetype:generate \
 -DarchetypeGroupId=org.apache.maven.archetypes \
 -DgroupId=sample.json \
 -DartifactId=Use_Json_in_Java
```

※変更していいのは3行目と4行目のみ。1行目と2行目は変えてはいけない。

## WebApplicationプロジェクト作成

``` sh
mvn -B archetype:generate \
  -DarchetypeArtifactId=maven-archetype-webapp \
  -DgroupId=com.example.log4j2 \
  -DartifactId=Log4j2_Web_Application_Sample
```

### 参考

[https://qiita.com/KevinFQ/items/e8363ad6123713815e68](https://qiita.com/KevinFQ/items/e8363ad6123713815e68)

## Javaバージョンを指定する

``` xml
<properties>
  <java.version>1.8</java.version>
  <maven.compiler.target>${java.version}</maven.compiler.target>
  <maven.compiler.source>${java.version}</maven.compiler.source>
  <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  <project.mainClass>com.example.Main</project.mainClass>
</properties>
```

## SpringBootの場合

- [./SpringBoot.md#init](./SpringBoot.md#init)

## src/main/resources配下のファイルパスを取得する

``` java
import java.nio.file.Paths;

Path path = 
    Paths.get(
        Thread.currentThread()
              .getContextClassLoader()
              .getResource("app.properties") // resources下のファイルパスを指定する。
              .getPath()
    );
```

## exec:javaコマンドで実行する

``` xml
<build>
  <plugins>
    <plugin>
      <groupId>org.codehaus.mojo</groupId>
      <artifactId>exec-maven-plugin</artifactId>
      <version>1.2.1</version>
      <configuration>
        <mainClass>${project.mainClass}</mainClass>
      </configuration>
    </plugin>
  </plugins>
</build>
```

### 引数でmainメソッドのクラスを指定する

```
exec:java -Dexec.mainClass="<クラス名>"
```

### 起動引数を渡す

```
mvn exec:java -Dexec.mainClass="<クラス名>" -Dexec.args="'<引数１>' '<引数２>' ..."
```
シングルクオーテーションはなくても動くが、スペースを含む場合は必要。

## dependencyタグのjarをまとめてjarにする

``` xml
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
        <mainClass>${project.mainClass}</mainClass>
      </manifest>
    </archive>
  </configuration>
</plugin>
```

### 参考

[https://qiita.com/hide/items/0c8795054219d04e5e98](https://qiita.com/hide/items/0c8795054219d04e5e98)

## getter,setterを作成しない

``` xml
<!-- https://mvnrepository.com/artifact/org.projectlombok/lombok -->
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.12</version>
    <scope>provided</scope>
</dependency>
```

### 参考

[https://qiita.com/opengl-8080/items/671ffd4bf84fe5e32557](https://qiita.com/opengl-8080/items/671ffd4bf84fe5e32557)  
[https://mvnrepository.com/artifact/org.projectlombok/lombok](https://mvnrepository.com/artifact/org.projectlombok/lombok)

## 依存ライブラリを取り込む

``` sh
mvn dependency:copy-dependencies
```
