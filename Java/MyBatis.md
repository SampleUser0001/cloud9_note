# MyBatis

- [MyBatis](#mybatis)
  - [dependency](#dependency)
  - [サンプル](#サンプル)
    - [app/src/main/resources/mybatis-config.xml](#appsrcmainresourcesmybatis-configxml)
    - [app/src/main/resources/database/mapper/SampleMapper.xml](#appsrcmainresourcesdatabasemappersamplemapperxml)
    - [app/src/main/java/ittimfn/usemybatis/mapper/SampleMapper.java](#appsrcmainjavaittimfnusemybatismappersamplemapperjava)
    - [app/src/main/java/ittimfn/usemybatis/service/SampleService.java](#appsrcmainjavaittimfnusemybatisservicesampleservicejava)
    - [app/src/main/java/ittimfn/usemybatis/util/MyBatisUtil.java](#appsrcmainjavaittimfnusemybatisutilmybatisutiljava)
    - [URL](#url)
  - [環境を切り替える](#環境を切り替える)
  - [2種類のバインド](#2種類のバインド)
  - [不等号、シングルクォーテーション](#不等号シングルクォーテーション)

## dependency

``` kotlin
dependencies {
    implementation 'org.mybatis:mybatis:3.5.16'
    // 今回はsqliteを使う。
    implementation 'org.xerial:sqlite-jdbc:3.46.0.0'

    implementation 'org.apache.logging.log4j:log4j-api:2.23.1'
    implementation 'org.apache.logging.log4j:log4j-core:2.23.1'
    // slf4jは外せない。sqlite-jdbcが依存しているため。
    implementation 'org.apache.logging.log4j:log4j-slf4j-impl:2.23.1'

    implementation 'org.projectlombok:lombok:1.18.32'
    annotationProcessor 'org.projectlombok:lombok:1.18.32'

    // Use JUnit Jupiter for testing.
    testImplementation 'org.junit.jupiter:junit-jupiter:5.9.1'

    // This dependency is used by the application.
    implementation 'com.google.guava:guava:31.1-jre'
}

```

## サンプル

### app/src/main/resources/mybatis-config.xml

``` xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "https://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
  <environments default="development">
    <environment id="development">
      <transactionManager type="JDBC"/>
      <dataSource type="UNPOOLED">
        <property name="driver" value="org.sqlite.JDBC"/>
        <property name="url" value="jdbc:sqlite:src/main/resources/database/sample.db"/>
        <property name="username" value="" />
        <property name="password" value="" />
      </dataSource>
    </environment>
  </environments>
  <mappers>
    <mapper resource="./database/mapper/SampleMapper.xml"/>
  </mappers>
</configuration>
```

- environment : 設定を管理する。
- dataSource type : コネクションプールを管理するか設定する。

### app/src/main/resources/database/mapper/SampleMapper.xml

``` xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="ittimfn.usemybatis.mapper.SampleMapper">
    <select id="selectById" parameterType="int" resultType="ittimfn.usemybatis.model.SampleModel">
        SELECT id, value FROM sample_table WHERE id = #{id}
    </select>
    <select id="selectAll" resultType="ittimfn.usemybatis.model.SampleModel">
        SELECT id, value FROM sample_table
    </select>
    <select id="selectInId" parameterType="java.util.List" resultType="ittimfn.usemybatis.model.SampleModel">
        SELECT id, value FROM sample_table WHERE id IN
        <foreach item="id" collection="list" open="(" separator="," close=")">
            #{id}
        </foreach>
    </select>
</mapper>
```

### app/src/main/java/ittimfn/usemybatis/mapper/SampleMapper.java

``` java
package ittimfn.usemybatis.mapper;

import java.util.List;
import ittimfn.usemybatis.model.SampleModel;

public interface SampleMapper {
    public SampleModel selectById(int id);
    public List<SampleModel> selectAll();
    public List<SampleModel> selectInId(List<Integer> idList);
}

```

実装クラスは不要。

### app/src/main/java/ittimfn/usemybatis/service/SampleService.java

SampleMapperのメソッドを呼び出す。  
SqlSessionFactoryを使う。

``` java
package ittimfn.usemybatis.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import ittimfn.usemybatis.App;
import ittimfn.usemybatis.mapper.SampleMapper;
import ittimfn.usemybatis.model.SampleModel;
import ittimfn.usemybatis.util.MyBatisUtil;

public class SampleService {

    private static final Logger logger = LogManager.getLogger(App.class);
    private SqlSessionFactory sqlSessionFactory = MyBatisUtil.getSqlSessionFactory();

    public SampleModel selectById(int id) {
        try(SqlSession session = sqlSessionFactory.openSession()) {
            SampleMapper mapper = session.getMapper(SampleMapper.class);
            return mapper.selectById(id);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return null;
        }
    }
    public List<SampleModel> selectAll() {
        try(SqlSession session = sqlSessionFactory.openSession()) {
            SampleMapper mapper = session.getMapper(SampleMapper.class);
            return mapper.selectAll();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return null;
        }
    }

    public List<SampleModel> selectInId(List<Integer> idList) {
        try(SqlSession session = sqlSessionFactory.openSession()) {
            SampleMapper mapper = session.getMapper(SampleMapper.class);
            return mapper.selectInId(idList);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return null;
        }
    }
}

```

### app/src/main/java/ittimfn/usemybatis/util/MyBatisUtil.java

SqlSessionFactoryを生成する。

``` java
package ittimfn.usemybatis.util;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import java.io.InputStream;

public class MyBatisUtil {
    private static SqlSessionFactory sqlSessionFactory;

    static {
        try {
            String resource = "mybatis-config.xml";
            InputStream inputStream = Resources.getResourceAsStream(resource);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static SqlSessionFactory getSqlSessionFactory() {
        return sqlSessionFactory;
    }
}
```

### URL

- [Use_MyBatis : SampleUser0001](https://github.com/SampleUser0001/Use_MyBatis)

## 環境を切り替える

``` java

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import java.io.InputStream;

public class MyBatisUtil {
    public static SqlSessionFactory getSqlSessionFactory(String environment) throws Exception {
        // 設定ファイルのパス
        String resource = "mybatis-config.xml";
        InputStream inputStream = Resources.getResourceAsStream(resource);
        // 指定された環境でSqlSessionFactoryを構築
        return new SqlSessionFactoryBuilder().build(inputStream, environment);
    }
}

```

## 2種類のバインド

- `#{変数}`
    - 型によって展開のされ方が違う。
    - 一度プレースホルダー（つまり「`?`」）に一度変換してから展開される。
- `${変数}`
    - 変数が持っている文字列がそのまま変換される。

## 不等号、シングルクォーテーション

| 文字 | エンティティ参照 |
| :--- | :--------------- |
| < | `&lt;` |
| > | `&gt;` |
| & | `&amp;` |
| '(シングルクォーテーション) | `&apos;` |
| "(ダブルクォーテーション) | `&quot;` |

## IN句を配列で生成する

``` xml
<where>
    <if test="inValueList != null and inValueList.size() > 0">
        AND カラム名 IN
        <foreach collection="inValueList"
                 item="value"
                 open="("
                 separator=","
                 close=")">
            #{value}
        </foreach>    
    </if>
</where
```
