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
  - [本体とテストのプロジェクトを分ける](#本体とテストのプロジェクトを分ける)
    - [Warning](#warning)
      - [代替案](#代替案)
    - [前提](#前提)
    - [本体](#本体)
    - [テストプロジェクト](#テストプロジェクト)
      - [jar生成](#jar生成)
      - [pom.xml](#pomxml)
  - [getter,setterを作成しない](#gettersetterを作成しない)
    - [参考](#参考-2)
  - [依存ライブラリを取り込む](#依存ライブラリを取り込む)
  - [同じバージョンでinstallを再実行する](#同じバージョンでinstallを再実行する)
  - [jarをローカルリポジトリに登録する](#jarをローカルリポジトリに登録する)
  - [外部jarを取り込む](#外部jarを取り込む)
    - [exec:java時に含める](#execjava時に含める)
  - [依存するライブラリを除去する](#依存するライブラリを除去する)
  - [異なるバージョンのJavaでアプリを動かす](#異なるバージョンのjavaでアプリを動かす)

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

## dependencyタグのjarをまとめてjarにする(SpringBootではない)

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

## dependencyタグのjarをまとめてjarにする(SpringBoot)

``` xml
<build>
  <plugins>
    <plugin>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-maven-plugin</artifactId>
      <configuration>
        <mainClass>com.example.mailapp.MailSendSampleApplication</mainClass>
        <excludes>
          <exclude>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
          </exclude>
        </excludes>
      </configuration>
    </plugin>
  </plugins>
</build>
```


## package,install時にテストをスキップする

``` bash
# 実行のみスキップ
mvn install -DskipTests=true

# コンパイルをスキップ
mvn install -Dmaven.test.skip=true
```

## 本体とテストのプロジェクトを分ける

### Warning

一応調べたが、SpringBoot部分が厄介。  
**やめておいたほうが良い。**

#### 代替案

接続先のDBを触りたくない場合は、`pom.xml`に下記を書いておくと、こちらを優先してくれる。

``` xml
    <!-- H2 Database for testing -->
    <dependency>
      <groupId>com.h2database</groupId>
      <artifactId>h2</artifactId>
      <version>2.2.220</version>
      <scope>test</scope>
    </dependency>
```

テスト部分全文

``` xml
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>
    <!-- H2 Database for testing -->
    <dependency>
      <groupId>com.h2database</groupId>
      <artifactId>h2</artifactId>
      <version>2.2.220</version>
      <scope>test</scope>
    </dependency>
    <!-- JUnit 5 -->
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-api</artifactId>
      <version>5.13.4</version>
      <scope>test</scope>
    </dependency>
    <!--<dependency>-->
    <!--  <groupId>org.junit.jupiter</groupId>-->
    <!--  <artifactId>junit-jupiter-engine</artifactId>-->
    <!--  <version>5.13.4</version>-->
    <!--  <scope>test</scope>-->
    <!--</dependency>-->
    <dependency>
      <groupId>org.hamcrest</groupId>
      <artifactId>hamcrest</artifactId>
      <version>2.2</version>
      <scope>test</scope>
    </dependency>


```


### 前提

- Maven + SpringBoot
- `mvn clean compile package`でテストが行われずにjarファイルが生成される。

### 本体

SpringBoot + すべて含む + Mavenでテストしない設定。

`pom.xml`  

``` xml
<build>
  <plugins>

    <plugin>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-maven-plugin</artifactId>
    </plugin>

    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-surefire-plugin</artifactId>
      <version>3.0.0-M7</version>
      <configuration>
        <skipTests>${skipTests}</skipTests>
      </configuration>
    </plugin>

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
  </plugins>
</build>
```

### テストプロジェクト

そのままだとjarファイルの中身が通常と違うので、クラスパスが通らない。  
テスト対象のクラスファイルを抽出したjarを生成する。

#### jar生成

もしかして、全部含むじゃないjarを生成すればいいのか？

``` bash
mkdir lib

# 作成済みのjarをlib配下にコピー
cd lib
original_jar=sample.jar
picked_jar=sample-plain.jar

jar -xf $original_jar BOOT-INF/classes/ 
jar -cf $picked_jar -C BOOT-INF/classes/ .
```

#### pom.xml

``` xml
    <dependency>
      <groupId>ittimfn.sample</groupId>
      <artifactId>sample</artifactId>
      <version>1.0-SNAPSHOT</version>
      <scope>system</scope>
      <systemPath>${project.basedir}/lib/sample-plain.jar</systemPath>
    </dependency>

<!-- 省略 -->

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-surefire-plugin</artifactId>
        <version>3.1.2</version>
        <configuration>
          <additionalClasspathElements>
            <additionalClasspathElement>${project.basedir}/lib/sample.jar</additionalClasspathElement>
          </additionalClasspathElements>
          <useManifestOnlyJar>false</useManifestOnlyJar>
          <useSystemClassLoader>true</useSystemClassLoader>
        </configuration>
      </plugin>
    </plugins>
  </build>


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

## 同じバージョンでinstallを再実行する

``` bash
mvn install:install-file
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

## 外部jarを取り込む

``` bash
# 対象のjarのパス
$ ls lib/sample.jar 
lib/sample.jar
```

``` xml
<dependency>
    <groupId>ittimfn.sample</groupId>
    <artifactId>sample</artifactId>
    <version>1.0-SNAPSHOT</version>
    <scope>system</scope>
    <systemPath>${project.basedir}/lib/sample.jar</systemPath>
</dependency>
```

### exec:java時に含める

``` xml
  <build>
    <plugins>
      <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>exec-maven-plugin</artifactId>
        <version>3.6.0</version>
        <configuration>
          <mainClass>ittimfn.sample.App</mainClass>
          <additionalClasspathElements>
            <additionalClasspathElement>${project.basedir}/lib/sample.jar</additionalClasspathElement>
          </additionalClasspathElements>
        </configuration>
      </plugin>
    </plugins>
  </build>

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

## 異なるバージョンのJavaでアプリを動かす

- [https://github.com/SampleUser0001/for_java_17](https://github.com/SampleUser0001/for_java_17)
