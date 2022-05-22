# JUnit

- [JUnit](#junit)
  - [基本](#基本)
    - [pom.xml](#pomxml)
    - [テストプログラム](#テストプログラム)
    - [参考](#参考)

## 基本

### pom.xml

``` xml
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.hamcrest</groupId>
      <artifactId>hamcrest</artifactId>
      <version>2.2</version>
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

