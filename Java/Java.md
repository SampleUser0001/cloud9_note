# Java

- [Java](#java)
  - [Stream](#stream)
    - [ファイル -\> Stream](#ファイル---stream)
    - [Stream -\> String](#stream---string)
      - [参考](#参考)
    - [重複排除](#重複排除)
    - [1行目を読み飛ばす](#1行目を読み飛ばす)
    - [String -\> Model](#string---model)
    - [Stream -\> List](#stream---list)
    - [Stream -\> Map](#stream---map)
      - [順番を保持する](#順番を保持する)
    - [合計値算出](#合計値算出)
    - [List -\> Stream](#list---stream)
    - [List\<ModelA\> -\> Map\<ModelA, List\<ModelB\>\>](#listmodela---mapmodela-listmodelb)
      - [List\<ModelA\> -\> LinkedHashMap\<ModelA, List\<ModelB\>\>](#listmodela---linkedhashmapmodela-listmodelb)
    - [配列 -\> Stream](#配列---stream)
    - [Path -\> List](#path---list)
    - [List\<ModelA\>をModelA内のListごとに展開する。](#listmodelaをmodela内のlistごとに展開する)
    - [List\<List\<Model\>\> -\> List\<Model\>](#listlistmodel---listmodel)
    - [Streamの連結](#streamの連結)
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
  - [Tempファイルを作成する / Javaでshを実行する](#tempファイルを作成する--javaでshを実行する)
    - [参考](#参考-1)
  - [Tempディレクトリ作成](#tempディレクトリ作成)
  - [最小の実行環境を提供する(jdeps, jlink)](#最小の実行環境を提供するjdeps-jlink)
    - [前提](#前提)
    - [手順](#手順)
    - [参考](#参考-2)
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
  - [文字コードを取得する](#文字コードを取得する)
    - [nkfを使う](#nkfを使う)

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
System.out.println(String.format("%%ｺｽﾄ"));
```

``` txt
%ｺｽﾄ
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