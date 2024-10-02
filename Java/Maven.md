# Maven

- [Maven](#maven)
  - [公式](#公式)
  - [新規プロジェクト作成](#新規プロジェクト作成)
    - [旧](#旧)
    - [新](#新)
  - [WebApplicationプロジェクト作成](#webapplicationプロジェクト作成)
    - [参考](#参考)
  - [Javaバージョンを指定する](#javaバージョンを指定する)
  - [SpringBootの場合](#springbootの場合)
  - [src/main/resources配下のファイルパスを取得する](#srcmainresources配下のファイルパスを取得する)
    - [Mavenのresources配下のpropertiesを読み込む](#mavenのresources配下のpropertiesを読み込む)
  - [exec:javaコマンドで実行する](#execjavaコマンドで実行する)
    - [引数でmainメソッドのクラスを指定する](#引数でmainメソッドのクラスを指定する)
    - [起動引数を渡す](#起動引数を渡す)
  - [package, javaコマンドで実行する](#package-javaコマンドで実行する)
  - [dependencyタグのjarをまとめてjarにする](#dependencyタグのjarをまとめてjarにする)
    - [参考](#参考-1)
  - [package,install時にテストをスキップする](#packageinstall時にテストをスキップする)
  - [getter,setterを作成しない](#gettersetterを作成しない)
    - [参考](#参考-2)
  - [依存ライブラリを取り込む](#依存ライブラリを取り込む)
  - [jarをローカルリポジトリに登録する](#jarをローカルリポジトリに登録する)
  - [依存するライブラリを除去する](#依存するライブラリを除去する)

## 公式

[Maven Getting Started Guide](https://maven.apache.org/guides/getting-started/index.html#How_do_I_make_my_first_Maven_project)

## 新規プロジェクト作成

### 旧

``` sh
mvn -B archetype:generate \
 -DarchetypeGroupId=org.apache.maven.archetypes \
 -DgroupId=ittimfn.sample \
 -DartifactId=sample
```
※変更していいのは3行目と4行目のみ。1行目と2行目は変えてはいけない。

### 新

``` sh
mvn -B archetype:generate \
 -DgroupId=ittimfn.sample
 -DartifactId=SampleApp
 -DarchetypeArtifactId=maven-archetype-quickstart
 -DarchetypeVersion=1.4
```


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

### Mavenのresources配下のpropertiesを読み込む

- [ReadExternalProperties_Maven:SampleUser0001:Github](https://github.com/SampleUser0001/ReadExternalProperties_Maven)

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

## package, javaコマンドで実行する

``` bash
# clean compile package
mvn clean compile package

# 実行
java -classpath target/${jarファイルパス} ${mainメソッドクラスフルパス} ${引数}
```

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

## package,install時にテストをスキップする

``` bash
# 実行のみスキップ
mvn install -DskipTests=true

# コンパイルをスキップ
mvn install -Dmaven.test.skip=true
```

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

## jarをローカルリポジトリに登録する

``` bash
jar_path=
groupId=
artifactId=
version=
mvn install:install-file \
    -Dfile=${jar_path} \
    -DgroupId=${groupId} \
    -DartifactId=${artifactId} \
    -Dversion=${version} \
    -Dpackaging=jar \
    -DgeneratePom=true
```

## 依存するライブラリを除去する

含まれているライブラリのバージョンが合わないので除去したいときに使う。

``` xml
        <dependency>
            <groupId>com.codeborne</groupId>
            <artifactId>selenide</artifactId>
            <scope>test</scope>
            <exclusions>
                <exclusion>
                    <groupId>org.seleniumhq.selenium</groupId>
                    <artifactId>selenium-chrome-driver</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
```
