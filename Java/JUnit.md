# JUnit

- [JUnit](#junit)
  - [基本](#基本)
    - [pom.xml](#pomxml)
      - [JUnit4](#junit4)
      - [JUnit5](#junit5)
      - [全部](#全部)
      - [参考](#参考)
    - [テストプログラム](#テストプログラム)
    - [参考](#参考-1)
  - [一部のメソッドをMock化する。](#一部のメソッドをmock化する)
    - [テスト対象](#テスト対象)
    - [テストクラス](#テストクラス)
    - [参考](#参考-2)

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

### 参考

- [HamcrestのMatchersに定義されているメソッドの使い方メモ:Qiita](https://qiita.com/opengl-8080/items/e57dab6e1fa5940850a3)


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