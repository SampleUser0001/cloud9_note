# SpringBoot

- [SpringBoot](#springboot)
  - [Spring Initializer](#spring-initializer)
  - [init](#init)
    - [pom.xml](#pomxml)
    - [main](#main)
    - [test](#test)
  - [実行](#実行)
  - [Spring Boot CLI](#spring-boot-cli)
    - [プロジェクト作成](#プロジェクト作成)
    - [参考](#参考)
  - [アノテーション](#アノテーション)
  - [SpringBoot + React.js](#springboot--reactjs)
  - [SpringBoot + log4j2](#springboot--log4j2)
    - [概要](#概要)
    - [pom.xml](#pomxml-1)

## Spring Initializer

[Spring Initializer](https://start.spring.io/)

## init

Mavenの場合。

### pom.xml

``` xml
  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>2.6.6</version>
    <relativePath/> <!-- lookup parent from repository -->
  </parent>
  <groupId>sample.springboot</groupId>
```

``` xml
  <properties>
    <java.version>11</java.version>
    <maven.compiler.target>${java.version}</maven.compiler.target>
    <maven.compiler.source>${java.version}</maven.compiler.source>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
```

``` xml
  <dependencies>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
    </dependency>

    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-test</artifactId>
      <scope>test</scope>
    </dependency>
  </dependencies>
```

``` xml
  <build>
    <plugins>
      <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
      </plugin>
    </plugins>
  </build>
```

### main

``` java
package sample.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class App {
    public static void main( String[] args ) { 
        SpringApplication.run(App.class, args);
    }
}

```

### test

``` java
package sample.springboot;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class AppTest {

    @Test
    public void contextLoads() {
    }
}
```

## 実行

``` bash
mvn clean spring-boot:run
```

## Spring Boot CLI

### プロジェクト作成

``` cmd
spring init --dependencies=${依存関係},${依存関係} --group-id=~${グループID} ${プロジェクト名}
```

### 参考

- [Spring Boot CLI](https://spring.pleiades.io/spring-boot/docs/current/reference/html/cli.html)

## アノテーション

| アノテーション | パッケージ | 説明 | リンク |
| :----------- | :------- | :--- | :--- |
| @Bean | org.springframework.context.annotation.Bean | メソッドが Spring コンテナーによって管理される Bean を生成することを示します。 | [SpringBoot:Javadoc](https://spring.pleiades.io/spring-framework/docs/current/javadoc-api/org/springframework/context/annotation/Bean.html) |
| @Entity | javax.persistence.Entity | JPAで使う。エンティティとテーブルのマッピングをする。 | [JPA (Java Persistence API)のアノテーション:SE学院](https://segakuin.com/java/jpa/annotation.html) |

## SpringBoot + React.js

- [SpringBoot_and_React.js](https://github.com/SampleUser0001/SpringBoot_and_React)
    - [React.js と Spring Data REST](https://spring.pleiades.io/guides/tutorials/react-and-spring-data-rest/)の実装。上記のソースの大半を含んでいるため、Privateリポジトリに設定。READMEだけ公開。
        - [README.md](./SpringBoot_and_React/README.md)

## SpringBoot + log4j2

SpringBootは標準でSLF4J + Logbackを使用している。Logbackではなく、log4j2を使いたい場合の設定例。

### 概要

1. `spring-boot-starter-log4j2`を追加する。
2. `spring-boot-starter-logging`がある場合は削除する。
3. SpringBootのライブラリでLogbackを含んでいるものがある場合は、`<exclusion>`を使用して除外する。
    - `mvn dependency:tree`コマンドで確認する。

### pom.xml

設定例。

``` xml

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-jdbc</artifactId>
    <exclusions>
        <exclusion>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-logging</artifactId>
        </exclusion>
    </exclusions>
</dependency>

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
    <exclusions>
        <exclusion>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-logging</artifactId>
        </exclusion>
    </exclusions>
</dependency>


<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-log4j2</artifactId>
</dependency>


```