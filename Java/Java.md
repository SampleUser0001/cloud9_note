# Java

- [Java](#java)
  - [record](#record)
  - [Stream](#stream)
    - [ファイル -\> Stream](#ファイル---stream)
    - [Stream -\> String](#stream---string)
      - [参考](#参考)
    - [重複排除](#重複排除)
    - [1行目を読み飛ばす](#1行目を読み飛ばす)
    - [String -\> Model](#string---model)
    - [Stream -\> List](#stream---list)
      - [Collectors.toList()とStream.toList()の違い](#collectorstolistとstreamtolistの違い)
    - [Stream -\> Map](#stream---map)
      - [順番を保持する](#順番を保持する)
    - [合計値算出](#合計値算出)
    - [List -\> Stream](#list---stream)
    - [List\<ModelA\> -\> Map\<ModelA, List\<ModelB\>\>](#listmodela---mapmodela-listmodelb)
      - [List\<ModelA\> -\> LinkedHashMap\<ModelA, List\<ModelB\>\>](#listmodela---linkedhashmapmodela-listmodelb)
    - [List\<Model\> -\> Map\<Key, List\<Model\>\>](#listmodel---mapkey-listmodel)
      - [実行例](#実行例)
    - [配列 -\> Stream](#配列---stream)
    - [Path -\> List](#path---list)
    - [List\<ModelA\>をModelA内のListごとに展開する。](#listmodelaをmodela内のlistごとに展開する)
    - [List\<List\<Model\>\> -\> List\<Model\>](#listlistmodel---listmodel)
    - [Streamの連結](#streamの連結)
    - [groupByする(List -\> List\<List\>)](#groupbyするlist---listlist)
  - [配列 -\> List](#配列---list)
  - [List -\> 配列](#list---配列)
    - [参考](#参考-1)
  - [重複排除(Set)](#重複排除set)
    - [配列 -\> Set](#配列---set)
    - [Set同士を連結する](#set同士を連結する)
  - [recode](#recode)
  - [Allowlist/Denylist(ホワイトリスト/ブラックリスト)](#allowlistdenylistホワイトリストブラックリスト)
  - [Enumから特定の項目を抽出したListを作る](#enumから特定の項目を抽出したlistを作る)
  - [propertiesファイルの読み込み](#propertiesファイルの読み込み)
    - [PropertiesEnum](#propertiesenum)
  - [実行可能jarファイルの実行](#実行可能jarファイルの実行)
    - [外部のライブラリを使用する](#外部のライブラリを使用する)
  - [jarファイルの中身を見る](#jarファイルの中身を見る)
  - [新規ファイルの書き込み](#新規ファイルの書き込み)
    - [ファイルの書き込み：参考](#ファイルの書き込み参考)
  - [Mapのループ](#mapのループ)
  - [Mapをほかの型のMapに変換する](#mapをほかの型のmapに変換する)
  - [ディレクトリを再帰的にたどる](#ディレクトリを再帰的にたどる)
  - [Listの結合](#listの結合)
  - [指定した文字列で結合する](#指定した文字列で結合する)
    - [Streamを結合する](#streamを結合する)
  - [Tempファイルを作成する / Javaでshを実行する](#tempファイルを作成する--javaでshを実行する)
    - [参考](#参考-2)
  - [Tempディレクトリ作成](#tempディレクトリ作成)
  - [最小の実行環境を提供する(jdeps, jlink)](#最小の実行環境を提供するjdeps-jlink)
    - [前提](#前提)
    - [手順](#手順)
    - [参考](#参考-3)
  - [jarの展開/圧縮](#jarの展開圧縮)
    - [展開](#展開)
    - [圧縮](#圧縮)
    - [jarコマンド:参考](#jarコマンド参考)
  - [StringBuilderとStringBufferの違い](#stringbuilderとstringbufferの違い)
  - [SimpleDateFormat](#simpledateformat)
    - [String -\> Date](#string---date)
    - [Date -\> String](#date---string)
  - [Optionalクラスを使ってnullチェックを行う](#optionalクラスを使ってnullチェックを行う)
  - [Mapのキーをあとから変更する](#mapのキーをあとから変更する)
  - [String.formatで「%」を出力する](#stringformatでを出力する)
  - [double -\> BigDecimalの誤差](#double---bigdecimalの誤差)
  - [Timestamp \<-\> OffsetDateTime](#timestamp---offsetdatetime)
    - [OffsetDateTime -\> Timestamp](#offsetdatetime---timestamp)
    - [Timestamp -\> OffsetDateTime](#timestamp---offsetdatetime-1)
      - [任意のタイムゾーンで](#任意のタイムゾーンで)
      - [特定のオフセットで](#特定のオフセットで)
  - [文字コードを取得する](#文字コードを取得する)
    - [nkfを使う](#nkfを使う)
  - [DBにSelectを投げた結果、メモリに保持しきれない量が抽出される場合(JDBC)](#dbにselectを投げた結果メモリに保持しきれない量が抽出される場合jdbc)
    - [Chat-GPT(3.5)に聞いてみた結果](#chat-gpt35に聞いてみた結果)
  - [JGit](#jgit)
  - [Windows + git bashとLinuxのファイルパス問題](#windows--git-bashとlinuxのファイルパス問題)
  - [Java8以降の日付の扱い(LocalDate, LocalDateTime)](#java8以降の日付の扱いlocaldate-localdatetime)
    - [インスタンス生成](#インスタンス生成)
    - [文字列 -\> インスタンス](#文字列---インスタンス)
    - [差分取得](#差分取得)
    - [Claude 3.7 Sonnetの回答](#claude-37-sonnetの回答)
      - [主なクラス](#主なクラス)
      - [新APIの主な特徴](#新apiの主な特徴)
      - [旧APIとの比較](#旧apiとの比較)
  - [コマンドラインでcheckstyleを実行する](#コマンドラインでcheckstyleを実行する)
    - [参考](#参考-4)
  - [縦と横を入れ替える](#縦と横を入れ替える)
  - [CRLF以外の改行コードを無視する](#crlf以外の改行コードを無視する)
  - [文字コードと改行コードの変換を行う](#文字コードと改行コードの変換を行う)
  - [SQLの実行結果をExcelに出力する](#sqlの実行結果をexcelに出力する)
  - [異なるバージョンのJavaでアプリを動かす](#異なるバージョンのjavaでアプリを動かす)
  - [Java 8 -\> 17の間に発生した主なアップデート内容](#java-8---17の間に発生した主なアップデート内容)
    - [Java 9 (2017年9月)](#java-9-2017年9月)
    - [Java 10 (2018年3月)](#java-10-2018年3月)
    - [Java 11 (2018年9月)](#java-11-2018年9月)
    - [Java 12 (2019年3月)](#java-12-2019年3月)
    - [Java 13 (2019年9月)](#java-13-2019年9月)
    - [Java 14 (2020年3月)](#java-14-2020年3月)
    - [Java 15 (2020年9月)](#java-15-2020年9月)
    - [Java 16 (2021年3月)](#java-16-2021年3月)
    - [Java 17 (2021年9月)](#java-17-2021年9月)
  - [XSS(クロスサイトスクリプティング)対応の例](#xssクロスサイトスクリプティング対応の例)
    - [Java](#java-1)
      - [修正前](#修正前)
      - [修正後](#修正後)
    - [JSP/Thymeleaf](#jspthymeleaf)
      - [修正前](#修正前-1)
      - [修正後](#修正後-1)
  - [用語](#用語)
    - [JavaSE(Java Platform Standard Edition)](#javasejava-platform-standard-edition)
      - [実装例](#実装例)
    - [JakartaEE(旧JavaEE) (Enterprise Edition)](#jakartaee旧javaee-enterprise-edition)
      - [実装例](#実装例-1)
    - [Spring](#spring)

## record

Java14からプレビュー版で登場。  
Java16から正式実装。

- メンバ変数が`private final`になる。
- `toString`, `equals`, `hashCode`が生成される。
- 継承できない。

``` java
public record Model(
    int id,
    String name,
    int age
) {}
```

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

#### Collectors.toList()とStream.toList()の違い

- Stream.toList()
    - Java16以降。
    - 順序は保証される。
    - Listの変更はできない。
    - Listの型、シリアライズ性は保証されない。
- Collectors.toList()
    - 新しいListに入れる。
    - Listの型、可変性、シリアライズ性、スレッドの安全性は保証されない、とされているが、実装はArrayListらしい。

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

### List\<ModelA\> -> Map<ModelA, List\<ModelB\>>

``` java
import java.util.stream.Collectors;

list.stream()
    .collect(Collectors.groupingBy(
                 m -> m,
                 Collectors.mapping(modelA -> new ModelB(modelA), Collectors.toList())));
```

#### List\<ModelA\> -> LinkedHashMap<ModelA, List\<ModelB\>>

``` java
import java.util.stream.Collectors;

list.stream()
    .collect(Collectors.groupingBy(
                 m -> m,
                 LinkedHashMap::new,
                 Collectors.mapping(modelA -> new ModelB(modelA), Collectors.toList())));
```

### List\<Model\> -> Map\<Key, List\<Model\>>

groupingByを使う。

``` java
// Modelのメンバ変数がKeyクラス。
Map<Key, List<Model>> map = list.stream().collect(Collectors.groupingBy(m -> m.key));
```

#### 実行例

``` java
import java.util.*;
import java.util.stream.*;

public class App {

    public void exec(String[] args) {
        Random random = new Random();

        List<Model> list = new ArrayList<Model>();
        for(int i=10 ; i>0 ; i--) {
            Model model = new Model(random.nextInt(3), i);
            System.out.println(model);
            list.add(model);
        }
        
        Map<Key, List<Model>> map = list.stream().collect(Collectors.groupingBy(m -> m.key));
        
        System.out.println(map.size());
        for(Map.Entry<Key, List<Model>> entry : map.entrySet()){
            System.out.println("key:" + entry.getKey().key);
            entry.getValue().stream().forEach(System.out::println);
        }

    }

    public static void main(String[] args) {
        new App().exec(args);
    }
    
    private class Key {
        Key(int key) {
            this.key = key;
        }
        int key;

        @Override
        public int hashCode() {
            return this.key;
        }

        @Override
        public boolean equals(Object obj) {
            if (obj == null) {
                return false;
            }
            if (obj == this) {
                return true;
            }
            if (obj.getClass() != this.getClass()) {
                return false;
            }
            Key other = (Key)obj;
            return this.key == other.key;
        }
    }
    
    private class Model {
        Model(int key, int value) {
            this.key = new Key(key);
            this.value = value;
        }
        Key key;
        int value;
        
        @Override
        public String toString() {
            return "key:" + this.key.key + ", value:" + this.value;
        }
    }
    
}
```

``` txt
key:1, value:10
key:2, value:9
key:1, value:8
key:0, value:7
key:2, value:6
key:2, value:5
key:0, value:4
key:1, value:3
key:2, value:2
key:1, value:1
3
key:0
key:0, value:7
key:0, value:4
key:1
key:1, value:10
key:1, value:8
key:1, value:3
key:1, value:1
key:2
key:2, value:9
key:2, value:6
key:2, value:5
key:2, value:2
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

### List\<ModelA\>をModelA内のListごとに展開する。

``` java
topLayerList.stream()
            .flatMap(ma -> ma.list.stream())
            .forEach(mb -> System.out.println(String.format("a : %s, b : %s", mb.a, mb.b)));
```

### List\<List\<Model\>\> -> List\<Model\>

``` java
import java.util.stream.Collectors;

list.stream()
    .flatMap(lst -> lst.stream())
    .collect(Collectors.toList());
```

### Streamの連結

``` java
Stream<String> stream1 = Stream.of("hoge", "piyo");
Stream<String> stream2 = Stream.of("foo", "vaa");

Stream.of(stream1, stream2)
      .flatMap(s -> s)
      .forEach(System.out::println);

```

### groupByする(List<Model> -> List<List<Model>>)

``` java
List<List<Model>> modelsLists = models.stream()
        .collect(Collectors.groupingBy(Model::getGroup))
        .values()
        .stream()
        .collect(Collectors.toList());
```

## 配列 -> List

``` java
// 確か特定の型でしか使えなかった気が・・・
Arrays.asList(releaseEnvironment.split("\\|"));
```

## List -> 配列

``` java
String[] array = arrayList.toArray(new String[arrayList.size()]);s
```

### 参考

- [【Java】 ArrayListを配列に変換する:Qiita](https://qiita.com/j-work/items/d114bd9fcf7e5e88e659)

## 重複排除(Set)

``` java
// 使い方はListと同じ。
Set<String> strSet = new HashSet<String>();

// 自動でソートするTreeSetクラス
SortedSet<String> sortedStrSet = new TreeSet<String>();
```

### 配列 -> Set

``` java
import java.util.Collections;
import java.util.Set;
import java.util.HashSet;

String[] strs = {"hoge", "piyo", "fuga"};
Set<String> set = new HashSet<>();
Collections.addAll(set, strs);
```

### Set同士を連結する

``` java
import java.util.Set;
import java.util.HashSet;

Set<String> set = new HashSet<>();
Set<String> set2 = new HashSet<>();

// データ作成(省略)

set.addAll(set2);
```

## recode

Java16から正式対応。  
Modelの代わりに使用できる。  
getter, equals, hashCode, toStringは生成されるが、setterは生成されない。  
また、継承できない。

``` java
public recode Model(int id, String value) {}
```

## Allowlist/Denylist(ホワイトリスト/ブラックリスト)

``` java
import java.util.List;
import java.util.stream.Stream;

List<String> allowList = List.of("hoge", "piyo");

Stream.of("aaa", "bbb", "hogehoge", "pibbbyo", "piyopiyo", "ccc")
        .filter(word -> allowList.stream().anyMatch(word::contains))
        .forEach(System.out::println);
```

## Enumから特定の項目を抽出したListを作る

``` java
public static List<String> wordList() {
    return Arrays.stream(TrimLineWordEnum.values())
                    .map(TrimLineWordEnum::getWord)
                    .toList();
}   
```

## propertiesファイルの読み込み

[ReadExternalProperties_Maven : SampleUser0001 : Github](https://github.com/SampleUser0001/ReadExternalProperties_Maven)

### PropertiesEnum

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

### 外部のライブラリを使用する

``` sh
# 実行可能jar配下で実行する
mkdir libs
cp ${使用するjarファイルパス} libs/

# -cpは-classpathの略。
# LinuxとWindowsで区切り文字が違う。Linuxは「:」。Windowsは「;」。
java -cp ${実行可能jarファイル}.jar:libs/* ${mainメソッドを持っているクラス}
```

## jarファイルの中身を見る

``` bash
jar tf ${jarファイルパス}
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
String joined = stream.forEachOrdered(Collectors(joining(",")));

// String head = "head";
// String tail = "tail";
// stream.forEachOrdered(Collectors(joining(",", head, tail));

```

## Tempファイルを作成する / Javaでshを実行する

``` java
import java.io.*;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.stream.Collectors;
 
public class TempFileClass {

    public void exec(String[] args) throws IOException, InterruptedException {
        String bashFile = this.getBashFile();
        try {
            ProcessBuilder pb = new ProcessBuilder("bash", bashFile);
            Process process = pb.start();
            try (BufferedReader buffer = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
                System.out.println(buffer.lines().collect(Collectors.joining("\n")));
            }
            process.waitFor();
        } finally {
            Files.delete(Paths.get(bashFile));
        }
    }

    private String getBashFile() throws IOException {
        // 一時ファイルが作成されるディレクトリを表示
        String tmpDir = System.getProperty("java.io.tmpdir");
        System.out.println("一時ディレクトリ： " + tmpDir);
 
        try {
            // 上記で示すディレクトリに一時ファイルを生成  
            File tempFile = File.createTempFile("prefix", ".sh");

            String tmpFilePath = tempFile.getPath();
            System.out.println("一時ファイルパス： " + tmpFilePath);
            try(BufferedWriter writer = Files.newBufferedWriter(Paths.get(tempFile.getPath()), Charset.forName("UTF-8"), StandardOpenOption.APPEND)) {
                writer.write("#!/bin/bash\n");
                writer.write("ls");
            }
 
            return tmpFilePath;
        } catch(IOException e) {
            System.err.println(e.getMessage());
            throw e;
        }
    }

    public static void main(String[] args) throws IOException, InterruptedException {
        new TempFileClass().exec(args);
    }
}

```

``` bash
$ ls
TempFileClass.class  TempFileClass.java
```

``` bash
$ java TempFileClass 
一時ディレクトリ： /tmp
一時ファイルパス： /tmp/prefix8243343864671051988.sh
TempFileClass.class
TempFileClass.java
```

### 参考

- [一時ファイルを作成するサンプルコード:偏差値40プログラマー](https://hensa40.cutegirl.jp/archives/787)
- [BashスクリプトをJavaで実行してみよう:Qiita](https://qiita.com/haniokasai/items/d345206d57dcc1a9373a)

## Tempディレクトリ作成

``` java
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class App {
    public static void main(String[] args) throws IOException {
        System.out.println(System.getProperty("java.io.tmpdir"));

        Path tempDirectory = Files.createTempDirectory(null);
        System.out.println(tempDirectory.toString());
        tempDirectory.toFile().deleteOnExit();
    }
}
```

``` bash
$ java App
/tmp
/tmp/6812748981744988023
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

## SimpleDateFormat

### String -> Date

``` java
import java.text.ParseException;

try {
    SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
    Date date = format.parse("20221014");
} catch (ParseException e) {
    e.printStackTrace();
}
```

### Date -> String

``` java
SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
format.format(new Date());
```

## Optionalクラスを使ってnullチェックを行う

- [Use_Optional_Java:SampleUser0001:Github](https://github.com/SampleUser0001/Use_Optional_Java)

## Mapのキーをあとから変更する

取得できなくなるのでやってはいけない。

- [Map_UpdateKey_Java:SampleUser0001:Github](https://github.com/SampleUser0001/Map_UpdateKey_Java)

## String.formatで「%」を出力する

``` java
System.out.println(String.format("%%コスト"));
```

``` txt
%コスト
```

## double -> BigDecimalの誤差

double -> BigDecimalを直接変換すると誤差が発生する。（実際にはdoubleの時点で誤差があるが、顕在化する。）  
double -> String -> BigDecimal変換する。

``` java
import java.math.BigDecimal;
import java.math.RoundingMode;

public class App {
    public static void main(String[] args) {
        double a = 2.15d;
        double b = 1.00d;

        App.wrong(a, b);
        App.correct(a, b);

        System.out.println(new BigDecimal(a));
    }

    public static void wrong(double a, double b) {
        BigDecimal aBigDecimal = new BigDecimal(a);
        BigDecimal bBigDecimal = new BigDecimal(b);

        System.out.println(aBigDecimal.divide(bBigDecimal, 1, RoundingMode.HALF_UP));
    }

    public static void correct(double a, double b) {
        BigDecimal aBigDecimal = new BigDecimal(Double.toString(a));
        BigDecimal bBigDecimal = new BigDecimal(Double.toString(b));

        System.out.println(aBigDecimal.divide(bBigDecimal, 1, RoundingMode.HALF_UP));

    }
}
```

``` bash
$ java App
2.1
2.2
2.149999999999999911182158029987476766109466552734375
```

## Timestamp <-> OffsetDateTime

### OffsetDateTime -> Timestamp

``` java
OffsetDateTime offsetDateTime = new OffsetDateTime();

Timestamp.from(offsetDateTime.toInstant());
```

### Timestamp -> OffsetDateTime

``` java
Timestamp ts = Timestamp.valueOf("2025-01-01 12:34:56");
OffsetDateTime odt = ts.toInstant().atOffset(ZoneOffset.systemDefault().getRules().getOffset(ts.toInstant()));
```

#### 任意のタイムゾーンで

``` java
Timestamp ts = Timestamp.valueOf("2025-01-01 12:34:56");

ZoneId zone = ZoneId.of("Asia/Tokyo");
OffsetDateTime odt = ts.toInstant().atZone(zone).toOffsetDateTime();
```

#### 特定のオフセットで

``` java
Timestamp ts = Timestamp.valueOf("2025-01-01 12:34:56");

OffsetDateTime odt = ts.toInstant().atOffset(ZoneOffset.ofHours(9));

```

## 文字コードを取得する

juniversalchardetを使う。

- [Use_juniversalchardet_Java:SampleUser0001:Github](https://sampleuser0001.github.io/Use_juniversalchardet_Java/)

### nkfを使う

nkfコマンドを実行して、標準出力をInputStreamで取得する。  
**エラーになる可能性がある。**[外部プロセス起動:ひしだま's 技術メモページ](https://www.ne.jp/asahi/hishidama/home/tech/java/process.html#Runtime)を参照。

``` java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

public class App {

    public void exec(String[] args) throws IOException, InterruptedException {
        this.printCharsetNames(getCharset(args[0]));
    }

    public void printCharsetNames(Charset charset) {
        charset.aliases().forEach(System.out::println);
    }

    private Charset getCharset(String filePath) throws IOException, InterruptedException {
        ProcessBuilder pb = new ProcessBuilder("nkf", "-g", filePath);
        Process process = pb.start();
        process.waitFor();
        return Charset.forName(convertToList(process.getInputStream()).get(0));
    }

    private List<String> convertToList(InputStream is) throws IOException {
        List<String> returnList = new ArrayList<>();
		try (BufferedReader br = new BufferedReader(new InputStreamReader(is))) {
			for (;;) {
				String line = br.readLine();
				if (line == null) {
                    break;
                } else {
                    returnList.add(line);
                }
			}
		}
        return returnList;
	}
    
    public static void main(String[] args) throws IOException, InterruptedException {
        new App().exec(args);
    }
    
}
```

## DBにSelectを投げた結果、メモリに保持しきれない量が抽出される場合(JDBC)

### Chat-GPT(3.5)に聞いてみた結果

Javaで大量のデータをDBから取得する際に、メモリに保持しきれない場合には、以下の方法を検討することができます。COBOLのカーソルと同様の機能を提供するJavaのクラスとしては、JDBCのResultSetやJPAのEntityManagerを使用することが一般的です。

1. **ResultSetを使用する**:
   JDBCを使ってデータベースからデータを取得する場合、`ResultSet`を使用してデータを一行ずつ取得することができます。これにより、メモリにすべてのデータを一度に読み込む必要がありません。以下は簡単な例です：

   ```java
   Connection connection = DriverManager.getConnection("jdbc:your_db_connection_string");
   Statement statement = connection.createStatement();
   ResultSet resultSet = statement.executeQuery("SELECT * FROM your_table");

   while (resultSet.next()) {
       // データを処理する
       String column1 = resultSet.getString("column1");
       int column2 = resultSet.getInt("column2");
       // 他のカラムも取得可能
   }

   resultSet.close();
   statement.close();
   connection.close();
   ```

   この方法では、データを一度にメモリに読み込むことなく、効率的に処理できます。

2. **ページングを実装する**:
   大量のデータを一度に取得せず、ページ単位で取得することを検討します。SQLクエリに`LIMIT`や`OFFSET`を使用して、データの一部を取得するクエリを発行します。これにより、データベースから必要なデータを取得し、メモリ使用量を制御できます。

   ```java
   // 例: 10件ずつデータを取得する場合
   String sql = "SELECT * FROM your_table LIMIT 10 OFFSET 0";
   // 2ページ目を取得する場合: "SELECT * FROM your_table LIMIT 10 OFFSET 10"
   // 3ページ目を取得する場合: "SELECT * FROM your_table LIMIT 10 OFFSET 20"
   // 以降同様
   ```

   ただし、ページングを実装する際に、データの一貫性やパフォーマンスに注意する必要があります。

3. **JPAやHibernateを使用する**:
   もしJava Persistence API (JPA) やHibernateなどのORM（Object-Relational Mapping）フレームワークを使用している場合、これらのフレームワークはデータベースからデータを効率的に取得し、メモリ管理を裏で行います。これにより、大規模なデータセットを処理する際にも容易に対応できます。

   JPAやHibernateを使用する場合、クエリを設計し、適切なページングを設定してデータを取得できます。

これらの方法を使用することで、大量のデータを効率的に取得し、メモリ使用量を最適化することができます。選択肢の中から、プロジェクトの要件に最適な方法を選んで実装してください。

## JGit

結論を書くと、ProcessBuilderを使ってgitコマンドを叩いたほうが楽。  
`git clone`だけはJGitを使ったほうが楽なような気がするが、おそらく好みの問題。

[Practice_JGit_AzureDevOps:SampleUser0001](https://github.com/SampleUser0001/Practice_JGit_AzureDevOps)

## Windows + git bashとLinuxのファイルパス問題

WindowsとLinuxの間で同じプログラムが使えるが、ファイルパスを引数でもらう場合、表現が異なるため、（見た目が同じでも）そのままでは使用できない。ファイルパスの形式を変換する必要がある。

[git bashのファイルパス <-> Linuxファイルパス変換](../Git_cli/git.md)

## Java8以降の日付の扱い(LocalDate, LocalDateTime)

DateやCalenderクラスを使用しない方法。

### インスタンス生成

``` java
import java.time.LocalDate;
import java.time.LocalDateTime;

LocalDate date1 = LocalDate.of(2023, 4, 1);
LocalDateTime dateTime1 = LocalDateTime.of(2023, 4, 1, 9, 0);
```

### 文字列 -> インスタンス

``` java
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

// Strictモード。存在しない日付が指定されたときにDateTimeParseExceptionをthrowするようになる。
DateTimeFormatter formatter 
    = DateTimeFormatter.ofPattern("uuuuMMdd")
                       .withResolverStyle(ResolverStyle.STRICT);
LocalDate date = LocalDate.parse("20230431", formatter);
```

### 差分取得

ChronoUnitクラスを使用する。

``` java
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class DateDiffTest {
    public static void main(String[] args) {

        //日付の差を求める
        LocalDate date1 = LocalDate.of(2023, 4, 1);
        LocalDate date2 = LocalDate.of(2023, 4, 8);

        long daysBetween = ChronoUnit.DAYS.between(date1, date2);
        System.out.println("日数は... " + daysBetween + "日");
        
        //時間の差を求める
        LocalDateTime dateTime1 = LocalDateTime.of(2023, 4, 1, 9, 0);
        LocalDateTime dateTime2 = LocalDateTime.of(2023, 4, 2, 10, 59);

        long hoursBetween = ChronoUnit.HOURS.between(dateTime1, dateTime2);
        System.out.println("時間は..." + hoursBetween + "時間");
    }
}
```

### Claude 3.7 Sonnetの回答

Java 8で大幅な日付・時間APIの刷新がありました。これは「Date-Time API」または「JSR-310」と呼ばれるもので、以前の`java.util.Date`や`java.util.Calendar`クラスの問題点を解決した新しいAPIです。

#### 主なクラス

1. **LocalDate**: 日付のみを表す（年、月、日）
   ```java
   LocalDate today = LocalDate.now();
   LocalDate specificDate = LocalDate.of(2023, Month.APRIL, 1);
   ```

2. **LocalTime**: 時間のみを表す（時、分、秒、ナノ秒）
   ```java
   LocalTime now = LocalTime.now();
   LocalTime specificTime = LocalTime.of(13, 30, 0);
   ```

3. **LocalDateTime**: 日付と時間の両方を表す（タイムゾーン情報なし）
   ```java
   LocalDateTime dateTime = LocalDateTime.now();
   ```

4. **ZonedDateTime**: タイムゾーン情報を含む日付と時間
   ```java
   ZonedDateTime tokyo = ZonedDateTime.now(ZoneId.of("Asia/Tokyo"));
   ```

5. **Instant**: UTC（協定世界時）からのナノ秒単位のタイムスタンプ
   ```java
   Instant timestamp = Instant.now();
   ```

6. **Duration**: 二つの時間間の経過時間
   ```java
   Duration duration = Duration.between(startTime, endTime);
   ```

7. **Period**: 二つの日付間の期間
   ```java
   Period period = Period.between(startDate, endDate);
   ```

#### 新APIの主な特徴

1. **不変（Immutable）**: スレッドセーフで、一度作成すると内部状態が変わらない
2. **流暢なAPI**: メソッドチェーンによる読みやすいコード
   ```java
   LocalDate nextWeek = LocalDate.now().plusWeeks(1);
   ```
3. **タイムゾーンサポート**: タイムゾーンを明示的に扱える
4. **ISO-8601準拠**: 国際標準に準拠した日付・時間表現
5. **DateTimeFormatter**: 柔軟な日付・時間のフォーマット
   ```java
   DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
   String formattedDate = LocalDate.now().format(formatter);
   ```

#### 旧APIとの比較

- **旧API（java.util.Date, Calendar）の問題点**:
  - ミュータブル（変更可能）で不安全
  - 月が0始まり（1月=0）で混乱しやすい
  - 日付計算が複雑
  - タイムゾーン処理が不十分
  - フォーマットが柔軟でない
  - スレッドセーフでない

- **新API（java.time）の利点**:
  - イミュータブル（不変）で安全
  - 直感的なAPI（月は1始まり）
  - 日付計算が簡単
  - タイムゾーンを適切に処理
  - 柔軟なフォーマット
  - スレッドセーフ

このJava 8での日付・時間APIの刷新は、ThreeTen（JSR-310）プロジェクトに基づいており、Joda-Timeライブラリから着想を得ています。Java 9以降のバージョンでも、この新しいAPIの基本構造は維持されています。

## コマンドラインでcheckstyleを実行する

1. `checkstyle.jar`を入手する。
    - [公式](https://github.com/checkstyle/checkstyle/releases)
2. 設定ファイルを用意する。
    - [google_checks.xml](https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/google_checks.xml)等
3. 下記実行。

    ``` bash
    config=${設定ファイルパス}
    # xml、sarif、plain。
    format=${出力フォーマット}
    output_path=${出力パス}
    src_path=${ソースファイルパス}
    java -jar checkstyle.jar -c ${config} -f ${format} -o ${output_path} ${src_path}
    ```

### 参考

- [checkstyleをコマンドラインから実行し、循環的複雑度のレポートをXML形式で作成する : Qiita](https://qiita.com/neko_the_shadow/items/90f3e73dbd7b190a1c67)

## 縦と横を入れ替える

``` java
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.ArrayList;

public class App {
    public static void main(String[] args) throws Exception {
        List<List<String>> list
            = Files.lines(Paths.get("Sample.tsv"))
                   .map(line -> List.of(line.split("\t")))
                   .toList();
        
        // 行数
        int rowCount = list.size();
        // 列数の最大値
        int maxRowLength = list.stream()
                               .mapToInt(List::size)
                               .max()
                               .orElse(0);
        
        List<List<String>> transposed = new ArrayList<>();
        for (int i = 0; i < maxRowLength; i++) {
            List<String> column = new ArrayList<>();
            for (int j = 0; j < rowCount; j++) {
                if (i < list.get(j).size()) {
                    column.add(list.get(j).get(i));
                } else {
                    column.add(""); // 空のセルを追加
                }
            }
            transposed.add(column);
        }

        // 結果を表示
        for (List<String> row : transposed) {
            System.out.println(String.join("\t", row));
        }
    }
}
```

Sample.tsv
``` tsv : Sample.tsv
hoge1		hoge3	
	piyo2	piyo3	piyo4
fuga1	fuga2		
```

実行結果
``` tsv
hoge1		fuga1
	piyo2	fuga2
hoge3	piyo3	
	piyo4	
```

## CRLF以外の改行コードを無視する

`BufferedReader.readLine()`はCRもLFもCRLFも改行として処理される。  
ファイルをバイナリとして読み込んで改行判断する。

``` java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;

public class CRLFBufferedReader extends BufferedReader {
    public CRLFBufferedReader(Reader in) {
        super(in);
    }

    @Override
    public String readLine() throws IOException {
        StringBuilder sb = new StringBuilder();
        int ch;
        while ((ch = read()) != -1) {
            if (ch == '\r') {
                int nextCh = read();
                if (nextCh == '\n') {
                    break; // CRLFを改行として認識
                } else if (nextCh != -1) {
                    sb.append((char) ch).append((char) nextCh);
                } else {
                    sb.append((char) ch);
                }
            } else {
                sb.append((char) ch);
            }
        }
        return sb.length() > 0 ? sb.toString() : null;
    }
}

```

``` java
import java.io.FileReader;

public class Main {
    public static void main(String[] args) throws Exception {
        String filePath = args[0];
        try (CRLFBufferedReader reader = new CRLFBufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line.replace("\n","").replace("\"",""));
            }
        }
    }
}

```

## 文字コードと改行コードの変換を行う

``` java
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.nio.charset.Charset;

public class NkfLike {

    public static void main(String[] args) {
        if (args.length < 6) {
            System.out.println("Usage: java Nkf <encoding>");
            return;
        }

        int argsIndex = 0;
        String inputFilepath = args[argsIndex++];
        Charset inputCharset = Charset.forName(args[argsIndex++]);
        LineSeparator inputLineSeparator = LineSeparator.valueOf(args[argsIndex++]);

        String outputFilepath = args[argsIndex++];
        Charset outputCharset = Charset.forName(args[argsIndex++]);
        LineSeparator outputLineSeparator = LineSeparator.valueOf(args[argsIndex++]);

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(
                new FileInputStream(inputFilepath), inputCharset))) {

            BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(outputFilepath), outputCharset));

            String line;

            while ((line = reader.readLine()) != null) {
                writer.write(line);
                writer.write(outputLineSeparator.getLineSeparator());
            }

            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private enum LineSeparator {
        CR("\r"),
        CRLF("\r\n"),
        LF("\n");

        private final String lineSeparator;

        private LineSeparator(String lineSeparator) {
            this.lineSeparator = lineSeparator;
        }

        public String getLineSeparator() {
            return lineSeparator;
        }

    }
}
```

## SQLの実行結果をExcelに出力する

Chat-GPTに聞いた。動作確認していない。

``` xml
<dependencies>
    <!-- Apache POI for Excel -->
    <dependency>
        <groupId>org.apache.poi</groupId>
        <artifactId>poi-ooxml</artifactId>
        <version>5.2.2</version>
    </dependency>
    <!-- Oracle JDBC Driver -->
    <dependency>
        <groupId>com.oracle.database.jdbc</groupId>
        <artifactId>ojdbc8</artifactId>
        <version>19.8.0.0</version>
    </dependency>
</dependencies>

```

``` java
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class SQLToExcelExporter {
    public static void main(String[] args) {
        // Oracleデータベースへの接続情報
        String jdbcUrl = "jdbc:oracle:thin:@hostname:1521:dbname";
        String username = "your_username";
        String password = "your_password";

        List<String> sqlFiles = List.of("query1.sql", "query2.sql", "query3.sql");  // SQLファイルのリスト
        String excelFilePath = "output.xlsx";  // 出力するExcelファイルのパス

        try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password)) {
            Workbook workbook = new XSSFWorkbook();
            
            for (String sqlFile : sqlFiles) {
                // SQLファイルを読み込む
                String query = readSQLFromFile(sqlFile);
                // クエリを実行
                try (Statement stmt = connection.createStatement();
                     ResultSet rs = stmt.executeQuery(query)) {
                    // 結果をExcelのシートに書き込む
                    String sheetName = sqlFile.replace(".sql", "");
                    writeResultSetToSheet(rs, workbook, sheetName);
                }
            }
            
            // Excelファイルに保存
            try (FileOutputStream fileOut = new FileOutputStream(excelFilePath)) {
                workbook.write(fileOut);
            }
            workbook.close();
            System.out.println("Excelファイルに出力完了: " + excelFilePath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // SQLファイルを読み込むメソッド
    private static String readSQLFromFile(String filePath) throws IOException {
        StringBuilder query = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                query.append(line).append("\n");
            }
        }
        return query.toString();
    }

    // ResultSetをExcelシートに書き込むメソッド
    private static void writeResultSetToSheet(ResultSet rs, Workbook workbook, String sheetName) throws SQLException {
        Sheet sheet = workbook.createSheet(sheetName);
        Row headerRow = sheet.createRow(0);
        ResultSetMetaData rsmd = rs.getMetaData();
        int columnCount = rsmd.getColumnCount();

        // ヘッダー行を作成
        for (int i = 1; i <= columnCount; i++) {
            Cell cell = headerRow.createCell(i - 1);
            cell.setCellValue(rsmd.getColumnName(i));
        }

        // データ行を作成
        int rowIndex = 1;
        while (rs.next()) {
            Row row = sheet.createRow(rowIndex++);
            for (int i = 1; i <= columnCount; i++) {
                Cell cell = row.createCell(i - 1);
                cell.setCellValue(rs.getString(i));
            }
        }
    }
}

```

## 異なるバージョンのJavaでアプリを動かす

- [https://github.com/SampleUser0001/for_java_17](https://github.com/SampleUser0001/for_java_17)

## Java 8 -> 17の間に発生した主なアップデート内容

Claude 3.7 Sonnetに質問。

``` txt
Java8 -> 17の間にあった主なアップデートをリストアップしてください。
```

Java 8から17までに導入された主な変更点を紹介します：

### Java 9 (2017年9月)

- モジュールシステム (Project Jigsaw)
- JShell（対話型JavaREPL）
- 改良されたプロセスAPI
- 不変コレクションファクトリメソッド
- Stream APIの強化（takeWhile、dropWhile、ofNullable）
- Optional強化（ifPresentOrElse、or、stream）
- PrivateインターフェースメソッドとPrivate staticインターフェースメソッド
- マルチリリースJARファイル

### Java 10 (2018年3月)

- ローカル変数型推論（var）
- G1GCの並列フルGC
- アプリケーションクラスデータ共有
- 非推奨APIの整理

### Java 11 (2018年9月)

- 長期サポート(LTS)リリース
- 標準HTTPクライアント（java.net.http）
- エフェメラルTLS 1.3サポート
- ラムダパラメータでのローカル変数構文
- Stringの新メソッド（isBlank、lines、strip、repeat）
- JavaFXがJava SEから分離

### Java 12 (2019年3月)

- Switchの拡張（プレビュー）
- G1GCの改善
- 新しいマイクロベンチマークスイート
- JVMコンスタントAPIの強化

### Java 13 (2019年9月)

- Textブロック（プレビュー）
- 再実装されたSocket API
- 動的CDS（クラスデータ共有）アーカイブ
- ZGC: アンロード未使用クラス

### Java 14 (2020年3月)

- Switch式（正式機能）
- レコード（プレビュー）
- パターンマッチングfor instanceof（プレビュー）
- NullPointerExceptionの改善
- 便利なNullPointerExceptionメッセージ
- PackagingTool（jpackage）

### Java 15 (2020年9月)

- Sealed Classes（プレビュー）
- 隠しクラス
- TextブロックとMultilineStrings（正式機能）
- ZGCとShenandoahGCの正式機能化
- 外部メモリアクセスAPI

### Java 16 (2021年3月)

- レコード（正式機能）
- パターンマッチングfor instanceof（正式機能）
- Unix-Domainソケットチャネル
- 外部リンカーAPI
- Vector API（インキュベータ）

### Java 17 (2021年9月)

- 長期サポート(LTS)リリース
- Sealed Classes（正式機能）
- 強化された疑似乱数ジェネレータ
- 新しいMacOSレンダリングパイプライン
- 廃止：Applet API
- パターンマッチングfor switch（プレビュー）
- 外部関数とメモリAPI（インキュベータ）

これらの更新により、Javaは近代的な言語機能を取り入れつつ、パフォーマンスと安定性も向上しています。

## XSS(クロスサイトスクリプティング)対応の例

### Java

#### 修正前

``` java
// XSS脆弱性を含むServletの例
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/vulnerable")
public class VulnerableServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // リクエストからユーザー入力を取得
        String userInput = request.getParameter("name");
        
        // コンテンツタイプの設定
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        // レスポンスの作成
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head><title>XSS脆弱性のデモ</title></head>");
        out.println("<body>");
        
        // 危険: ユーザー入力を直接出力 (XSS脆弱性)
        out.println("<h1>こんにちは、" + userInput + "さん！</h1>");
        
        out.println("</body></html>");
    }
}
```

#### 修正後

``` java
// XSS脆弱性を修正したServletの例
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.text.StringEscapeUtils;

@WebServlet("/secure")
public class SecureServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // リクエストからユーザー入力を取得
        String userInput = request.getParameter("name");
        
        // 重要: ユーザー入力をHTMLエスケープ
        String safeUserInput = StringEscapeUtils.escapeHtml4(userInput);
        
        // コンテンツタイプの設定
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        // レスポンスの作成
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head><title>XSS対策済みデモ</title></head>");
        out.println("<body>");
        
        // 安全: エスケープされたユーザー入力を出力
        out.println("<h1>こんにちは、" + safeUserInput + "さん！</h1>");
        
        out.println("</body></html>");
    }
}
```

### JSP/Thymeleaf

#### 修正前

``` html
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSTLを使用したXSS対策</title>
</head>
<body>
    <!-- JSTLのc:outタグを使用してエスケープ処理 -->
    <h1>こんにちは、<c:out value="${param.name}" />さん！</h1>
    
    <!-- 不適切な例: JSP式を直接使用（XSS脆弱性あり） -->
    <!-- <h1>こんにちは、${param.name}さん！</h1> -->
</body>
</html>
```

#### 修正後

``` html
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Thymeleafを使用したXSS対策</title>
</head>
<body>
    <!-- Thymeleafのth:text属性は自動的にHTMLエスケープを行う -->
    <h1>こんにちは、<span th:text="${name}">Guest</span>さん！</h1>
    
    <!-- 不適切な例: th:utext属性はエスケープを行わない -->
    <!-- <h1>こんにちは、<span th:utext="${name}">Guest</span>さん！</h1> -->
</body>
</html>
```

## 用語

### JavaSE(Java Platform Standard Edition)

Javaの最も基本的な仕様。

#### 実装例

- OracleJDK
- OpenJDK
    - Amazon Corretto
    - Microsoft Build of OpenJDK

### JakartaEE(旧JavaEE) (Enterprise Edition)

JavaSEに、大規模なサーバサイドアプリケーション開発機能を追加した、エンタープライズ向けの仕様。

#### 実装例

- WebLogic
- WebSphere
- Wildfly

### Spring

J2EEと異なるWebフレームワーク。  
J2EEのアンチテーゼとして作成されたが、J2EE自体を否定せず、完全ではないが、一部機能はJ2EEに準拠している。