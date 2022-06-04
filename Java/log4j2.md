# log4j2

- [log4j2](#log4j2)
  - [設定例](#設定例)
    - [pom.xml](#pomxml)
    - [log4j2.xml](#log4j2xml)
    - [java](#java)
  - [参考](#参考)

## 設定例

### pom.xml

``` xml

  <dependencies>
    <dependency>
      <groupId>org.apache.logging.log4j</groupId>
      <artifactId>log4j-api</artifactId>
      <version>${log4j2.version}</version>
    </dependency>
    <dependency>
      <groupId>org.apache.logging.log4j</groupId>
      <artifactId>log4j-core</artifactId>
      <version>${log4j2.version}</version>
    </dependency>
    <!-- webアプリを作成する場合はこれも設定。
    <dependency>
      <groupId>org.apache.logging.log4j</groupId>
      <artifactId>log4j-web</artifactId>
      <version>${log4j2.version}</version>
    </dependency>
    -->
  </dependencies>

```

### log4j2.xml

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE project> 
<!-- statusでlog4j2自体のログを出力する。通常はoff --> 
<Configuration status="off">

    <!-- Propertiesは、nameの値を変数として使える -->
    <Properties>
        <!-- ログのフォーマット 
           %dは日時。{}に日時の形式を指定
           %tはスレッド名
           %-6pはログレベル名称を左詰めで6文字分出力する。「debug」であれば後ろに空白１文字が追加される。
               但し、%-3pとしても名称は削られず「debug」として出力される。%6と-をとると右づめになる。
           %c{x}は,例えばロガー名がorg.apache.commons.Fooのとき%c{2}の場合、commons.Fooが出力される
           %mはログメッセージ
           %nは改行
        -->
        <Property name="format1">%d{yyyy/MM/dd HH:mm:ss.SSS} [%t] %-6p %c{10} %m%n</Property>
        <Property name="logfile">./logs/testlog.log</Property>
        <Property name="logfile-archive">./logs/testlog_%d{yyyy-MM-dd-HH-mm}.tar.gz</Property>
    </Properties>
    
    <Appenders>
        <!-- コンソールに出力する設定 -->
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout>
                <pattern>${format1}</pattern>
            </PatternLayout>
        </Console>

        <!-- ファイルに出力する設定 -->
        <!-- どこかのタイミングでローテートする。filePatternとTimeBasedTriggeringPoliciyに依存。-->
        <RollingFile name="logfile001" append="true" fileName="${logfile}"
            filePattern="${logfile-archive}">
            <PatternLayout>
                <pattern>${format1}</pattern>
            </PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1" modulate="true" />
            </Policies>
        </RollingFile>
    </Appenders>
    
    <Loggers>
        <!-- trace以上のログを出力する -->
        <Root level="trace">
            <AppenderRef ref="Console" />
            <AppenderRef ref="logfile001" />
        </Root>
        <!-- LoggerでRootとは別にpackageごとに指定できる。
        <Logger name="sample.log4j2" level="debug" additivity="false">
            <AppenderRef ref="Test" />
        </Logger>
        -->
    </Loggers>
</Configuration>
```


### java

``` java
package sample.log4j2;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class App {

    //getLoggerの引数はロガー名を指定する。
    //log4j2では、ロガー名の指定が省略可能になった。
    private Logger logger = LogManager.getLogger();

    public static void main( String[] args ) {
        App a = new App();
        a.runSample();
    }

    public void runSample() {

        logger.trace("Start"); 

        int a = 1;
        int b = 2;
        String c = null;

        logger.debug("debug"); 
        logger.info("info={}",a); 
        logger.warn("warn={},={}" ,a,b); 
        logger.error("error={}",c); 
        
        logger.trace("End"); 
    }
}
```

## 参考

- [log4j2_Sample_Maven](https://github.com/SampleUser0001/log4j2_Sample_Maven)
- [Log4j2_Web_Application_Sample](https://github.com/SampleUser0001/Log4j2_Web_Application_Sample)
- [log4j_hourly_rotate](https://github.com/SampleUser0001/log4j_hourly_rotate)