# JUnit

- [JUnit](#junit)
  - [基本](#基本)
    - [pom.xml](#pomxml)
    - [テストプログラム](#テストプログラム)
    - [参考](#参考)
  - [一部のメソッドをMock化する。](#一部のメソッドをmock化する)
    - [テスト対象](#テスト対象)
    - [テストクラス](#テストクラス)
    - [参考](#参考-1)

## 基本

### pom.xml

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