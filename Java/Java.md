# Java

- [Java](#java)
  - [Stream](#stream)
    - [ファイル -> Stream](#ファイル---stream)
    - [Stream -> String](#stream---string)
      - [参考](#参考)
    - [重複排除](#重複排除)
    - [1行目を読み飛ばす](#1行目を読み飛ばす)
    - [String -> Model](#string---model)
    - [Stream -> List](#stream---list)
    - [Stream -> Map](#stream---map)
      - [順番を保持する](#順番を保持する)
    - [合計値算出](#合計値算出)
    - [List -> Stream](#list---stream)
    - [List\<Model\> -> Map<T, List\<Model\>>](#listmodel---mapt-listmodel)
    - [配列 -> Stream](#配列---stream)
    - [Path -> List](#path---list)
  - [PropertiesEnum](#propertiesenum)
  - [実行可能jarファイルの実行](#実行可能jarファイルの実行)
  - [新規ファイルの書き込み](#新規ファイルの書き込み)
    - [ファイルの書き込み：参考](#ファイルの書き込み参考)
  - [propertiesファイルの読み込み](#propertiesファイルの読み込み)
  - [Mapのループ](#mapのループ)
  - [Mapをほかの型のMapに変換する](#mapをほかの型のmapに変換する)
  - [ディレクトリを再帰的にたどる](#ディレクトリを再帰的にたどる)
  - [Listの結合](#listの結合)
  - [指定した文字列で結合する](#指定した文字列で結合する)
    - [Streamを結合する](#streamを結合する)
  - [最小の実行環境を提供する(jdeps, jlink)](#最小の実行環境を提供するjdeps-jlink)
    - [前提](#前提)
    - [手順](#手順)
    - [参考](#参考-1)
  - [jarの展開/圧縮](#jarの展開圧縮)
    - [展開](#展開)
    - [圧縮](#圧縮)
    - [jarコマンド:参考](#jarコマンド参考)
  - [StringBuilderとStringBufferの違い](#stringbuilderとstringbufferの違い)

## Stream

### ファイル -> Stream

``` java
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

Path inputPath = Paths.get(filePath);
Stream stream = Files.lines(inputPath);
```

### Stream -> String

``` java
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

Path inputPath = Paths.get(filePath);
String str = Files.lines(inputPath)
                  .map(Object::toString)
                  .collect(Collectors.joining());
```

#### 参考

- [Collectors:javadoc:Java8](https://docs.oracle.com/javase/jp/8/docs/api/java/util/stream/Collectors.html)

### 重複排除

``` java
.distinct()
```

### 1行目を読み飛ばす

``` java
.skip(1)
```

### String -> Model

``` java
.map(line -> new Model(line))
```

### Stream -> List

``` java
import java.util.stream.Collectors;

.collect(Collectors.toList())
```

### Stream -> Map

``` java
collect(Collectors.toMap(Model::getId, Bean::getValue))
```

#### 順番を保持する

``` java
collect(Collectors.toMap(Model::getId, Bean::getValue, (x, y) -> y, LinkedHashMap::new))
```

### 合計値算出

``` java
.mapToInt(model -> model.getInt())
.sum();
```

### List -> Stream

``` java
list.stream()
```

### List\<Model\> -> Map<T, List\<Model\>>

``` java
list.stream()
    .collect(Collectors.groupingBy(Model::getId,
             Collectors.mapping(Model::clone, Collectors.toList())));
```

### 配列 -> Stream

``` java
Stream.of(配列)
```

### Path -> List

``` java
import java.util.List;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

Path filepath = Paths.get("読み込み対象のファイルパス");
List<String> lines = Files.readAllLines(filepath, Charset.forName("UTF-8"));
```

## PropertiesEnum

``` java
package hogehoge.enums;

import java.util.Properties;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.charset.StandardCharsets;
import java.io.IOException;

public enum PropertiesEnum {
    HOGE("hoge"),
    PIYO("piyo");

    private static Properties properties;
    
    private final String key;

    private PropertiesEnum(String key) {
        this.key = key;
    }
    
    public static void load(Path propertiesPath) throws IOException {
        properties = new Properties();
        properties.load(
            Files.newBufferedReader(propertiesPath, StandardCharsets.UTF_8)
        );
    }
    
    public String getPropertiesValue() {
        return properties.getProperty(this.key);
    }
    
    
}
```

## 実行可能jarファイルの実行

``` sh
java -cp ${実行可能jarファイル}.jar ${mainメソッドを持っているクラス}
```

## 新規ファイルの書き込み

``` java
import java.io.BufferedWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.charset.Charset;
import java.nio.file.StandardOpenOption;

try(BufferedWriter writer = Files.newBufferedWriter(Paths.get("書き込みファイルパス"), Charset.forName("UTF-8"), StandardOpenOption.CREATE)) {

}
```

### ファイルの書き込み：参考

[https://docs.oracle.com/javase/jp/8/docs/api/java/nio/file/Files.html#newBufferedWriter-java.nio.file.Path-java.nio.charset.Charset-java.nio.file.OpenOption...-](https://docs.oracle.com/javase/jp/8/docs/api/java/nio/file/Files.html#newBufferedWriter-java.nio.file.Path-java.nio.charset.Charset-java.nio.file.OpenOption...-)

## propertiesファイルの読み込み

``` java
import java.util.Properties;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.charset.StandardCharsets;
import java.io.IOException;

// (省略)

  try {
    Properties prop = new Properties();
    String propFilePath = "propertiesファイルのパス";

    prop.load(
      Files.newBufferedReader(
        Paths.get(propFilePath),
        StandardCharsets.UTF_8
      )
    );
    String value = prop.getProperty("propertiesのキー");
  } catch(IOException e){
    e.printStackTrace();
  }

```

## Mapのループ

``` java
for(Map.Entry<String, String> entry : map.entrySet()){
  entry.getKey();
  entry.getValue();
}

```

## Mapをほかの型のMapに変換する

``` java
import java.util.stream.Collectors;

Map<String, DataB> dataBMap
    = dataAMap.entrySet()
              .stream()
              .collect(Collectors.toMap(Map.Entry::getKey,
                                        entry -> new DataB(entry));
```

## ディレクトリを再帰的にたどる

``` java
import java.util.stream.Stream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.io.IOException;

try (Stream<Path> stream = Files.walk(Paths.get("."))) {
    stream.forEach(System.out::println);
} catch(IOException e) {
    e.printStackTrace();
}
```

## Listの結合

``` java
import java.util.stream.Stream;
import java.util.stream.Collectors;

Stream.concat(list.stream(), list2.stream())
      .collect(Collectors.toList());
```

``` java
import java.util.List;
import java.util.stream.Collectors;

List<List<String>> listInList;
// listInListのインスタンス生成。省略。

List<String> list
  = listInList.stream()
              .flatMap(l -> l.stream())
              .collect(Collectors.toList());

```

## 指定した文字列で結合する

``` java
import java.util.StringJoiner;

StringJoiner joiner = new StringJoiner(",");
joiner.add("hoge");
joiner.add("piyo");
System.out.println(joiner.toString());
```

### Streamを結合する

``` java
import java.util.stream.Collectors;

Stream<String> stream = // 任意の値
String joined = stream.forEachOrdered(Collectors(joining(","));

// String head = "head";
// String tail = "tail";
// stream.forEachOrdered(Collectors(joining(",", head, tail));

```

## 最小の実行環境を提供する(jdeps, jlink)

### 前提

1. Java9以上
2. jar作成済み
3. 提供予定環境と同じ環境のJDKが有る

### 手順

コマンドはWindows基準。

jar実行のために必要な依存モジュールを確認する。

``` cmd
jdeps --list-deps %提供予定のjar%
```

依存モジュールをかき集める。(javaコマンドと、実行可能なライブラリが揃えられる。)

``` cmd
jlink --compress=2 --module-path=%JAVA_HOME%/jmods --add-modules %jdepsの結果すべて% --output %出力先ディレクトリ%
```

実行用の実行時にパスを通す。

``` cmd
PATH=%2の出力先ディレクトリ%\bin;%PATH%
java -cp %jarファイル% %mainクラス%
```

### 参考

- [Tech Blog:アプリケーション配布用に小さなJREを作る](https://blogs.osdn.jp/2018/03/26/jre-minimize.html)

## jarの展開/圧縮

### 展開

```sh
jar -xvf {対象ファイル}.jar
```

### 圧縮

``` sh
jar -cf ${jarファイル}.jar ${ディレクトリ}
```

### jarコマンド:参考

- [jarコマンド:Oracle](https://docs.oracle.com/javase/jp/13/docs/specs/man/jar.html#:~:text=jar%20%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AF%E3%80%81ZIP%E3%81%8A%E3%82%88%E3%81%B3,%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%A7%E3%81%8D%E3%81%BE%E3%81%99%E3%80%82)
- [jarコマンド入門:Qiita](https://qiita.com/maple_syrup/items/a2f21fe356fa5f06bf44)

## StringBuilderとStringBufferの違い

- StringBuilder
  - スレッドセーフではない。
  - 早い
- StringBuffer
  - スレッドセーフ。
  - 早くない。