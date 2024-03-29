# JUnit

- [JUnit](#junit)
  - [基本](#基本)
    - [pom.xml](#pomxml)
      - [JUnit4](#junit4)
      - [JUnit5](#junit5)
      - [全部](#全部)
      - [参考](#参考)
    - [テストプログラム](#テストプログラム)
      - [Ver.4](#ver4)
      - [参考](#参考-1)
      - [Ver.5](#ver5)
  - [BeforeEach, BeforeAllが動かない](#beforeeach-beforeallが動かない)
    - [参考](#参考-2)
  - [リフレクション](#リフレクション)
    - [Method](#method)
  - [配列のテスト](#配列のテスト)
  - [一部のメソッドをMock化する。](#一部のメソッドをmock化する)
    - [テスト対象](#テスト対象)
    - [テストクラス](#テストクラス)
    - [参考](#参考-3)
  - [メソッドが呼ばれた回数を確認する](#メソッドが呼ばれた回数を確認する)

## 基本

### pom.xml

#### JUnit4

``` xml
    <junit.version>4.13.2</junit.version>
    <hamcrest.version>2.2</hamcrest.version>

    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>${junit.version}</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.hamcrest</groupId>
      <artifactId>hamcrest</artifactId>
      <version>${hamcrest.version}</version>
      <scope>test</scope>
    </dependency>

```

#### JUnit5

``` xml
    <junit.version>5.4.0</junit.version>
    <hamcrest.version>2.2</hamcrest.version>

    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-api</artifactId>
      <version>${junit.version}</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-engine</artifactId>
      <version>${junit.version}</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.hamcrest</groupId>
      <artifactId>hamcrest</artifactId>
      <version>2.2</version>
      <scope>test</scope>
    </dependency>

  <build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.8.0</version>
            <configuration>
                <source>${java.version}</source>
                <target>${java.version}</target>
            </configuration>
        </plugin>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>2.22.1</version>
        </plugin>
    </plugins>
  </build>


```

#### 全部

``` xml
    <junit.version>5.4.0</junit.version>
    <hamcrest.version>2.2</hamcrest.version>
    <mockito.version>4.9.0</mockito.version>
    <powermock.version>2.0.9</powermock.version>

    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-engine</artifactId>
      <version>${junit.version}</version>
      <scope>test</scope>
    </dependency>
    
    <dependency>
      <groupId>org.hamcrest</groupId>
      <artifactId>hamcrest</artifactId>
      <version>${hamcrest.version}</version>
      <scope>test</scope>
    </dependency>

    <dependency>
      <groupId>org.mockito</groupId>
      <artifactId>mockito-core</artifactId>
      <version>${mockito.version}</version>
      <scope>test</scope>
    </dependency>    

    <dependency>
      <groupId>org.powermock</groupId>
      <artifactId>powermock-api-mockito2</artifactId>
      <version>${powermock.version}</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.powermock</groupId>
      <artifactId>powermock-module-junit4</artifactId>
      <version>${powermock.version}</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.powermock</groupId>
      <artifactId>powermock-module-junit4-rule-agent</artifactId>
      <version>${powermock.version}</version>
      <scope>test</scope>
    </dependency>

```

#### 参考

- [Using JUnit 5 Platform : Apache Maven Project](https://maven.apache.org/surefire/maven-surefire-plugin/examples/junit-platform.html)

### テストプログラム

#### Ver.4

``` java
import org.junit.Test;
import org.junit.Before;

import static org.hamcrest.MatcherAssert.*;
import static org.hamcrest.Matchers.*;

public class AppTest {
    
    private App app;
    
    @Before
    public void setup() {
        app = new App();
    }
    
    @Test
    public void test() {
        String actual = app.execute();
        assertThat(actual, is(equalTo("expected")));
    }
}

```

#### 参考

- [HamcrestのMatchersに定義されているメソッドの使い方メモ:Qiita](https://qiita.com/opengl-8080/items/e57dab6e1fa5940850a3)

#### Ver.5

```java
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * Unit test for simple App.
 */
public class AppTest {

    @BeforeEach
    public void setUp() {
        
    }

    @Test
    public void seleniumTest() {
        
    }
}
```

## BeforeEach, BeforeAllが動かない

下記を追加する。

``` xml
<build>
    <plugins>
        <plugin>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>2.19.1</version>
            <dependencies>
                <dependency>
                    <groupId>org.junit.platform</groupId>
                    <artifactId>junit-platform-surefire-provider</artifactId>
                    <version>1.1.0</version>
                </dependency>
            </dependencies>
        </plugin>
    </plugins>
</build>

```

### 参考

- [JUnit5の@BeforeEachと@AfterEachが実行されない:Qiita](https://qiita.com/k17trpsynth/items/c988105dbb12a25e6a7e)
- [JUnit 5 does not execute method annotated with BeforeEach:stackoverflow](https://stackoverflow.com/questions/49441049/junit-5-does-not-execute-method-annotated-with-beforeeach)

## リフレクション

### Method

``` java

Method method = App.class.getDeclaredMethod("methodName", Object.class);
method.setAccessible(true);

Object args = new Object();
App app = new App();
String returnValue = method.invoke(app, args);
```

## 配列のテスト

``` java
assertArrayEquals(
    new int[]{0,1},
    actual
);
```

## 一部のメソッドをMock化する。

### テスト対象

``` java
package sample.controller;

import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * テストで使う
 */
@NoArgsConstructor
public class SampleController {
    private int forExecute = 1;

    @Setter
    private int value;

    public int execute(){
        this.setUp();
        return this.square();
    }

    void setUp() {
        this.forExecute = value;
    }

    private int square() {
        return this.forExecute * this.forExecute;
    }

}
```

### テストクラス

``` java
package sample.controller;

import static org.hamcrest.MatcherAssert.*;
import static org.hamcrest.Matchers.*;

import java.lang.reflect.Method;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.modules.junit4.PowerMockRunner;

@RunWith(PowerMockRunner.class)
public class SampleControllerTest {
    
    /**
     * setUpをMock化しない
     */
    @Test
    public void notMockedMethod() {
        SampleController controller = new SampleController();

        controller.setValue(10);
        assertThat(controller.execute(), is(equalTo(100)));
    }

    /**
     * setUpをMock化する。
     * @throws Exception
     */
    @Test
    public void setUpIsMocked() throws Exception {
        SampleController mock = PowerMockito.spy(new SampleController());

        // setUpメソッドをMock化する。
        PowerMockito.doNothing().when(mock,"setUp");
        // 引数がある場合は、whenに3つめの引数を指定する。

        // TODO setUpメソッドをprivateにしたいが、Mock化の方法が不明。

        // notMockedMethodと同じ値を与えても、結果が異なる。
        mock.setValue(10);
        assertThat(mock.execute(), is(equalTo(1)));
    }
}

```

### 参考

- [GetPowerMock:SampleUser0001:Github](https://github.com/SampleUser0001/GetPowerMock)

## メソッドが呼ばれた回数を確認する

`Mockito.spy`を使用して、インスタンスを生成する。  
生成したインスタンスを使ってメソッドを実行することで、回数がカウントできるようになる。

- [ControllerTest.java:JUnit_Verify:SampleUser0001](https://github.com/SampleUser0001/JUnit_Verify/blob/main/src/test/java/ittimfn/sample/junit/controller/ControllerTest.java)