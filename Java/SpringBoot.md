# SpringBoot

- [SpringBoot](#springboot)
  - [Spring Initializer](#spring-initializer)
  - [init](#init)
    - [pom.xml](#pomxml)
    - [main](#main)
    - [test](#test)
  - [実行](#実行)

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
