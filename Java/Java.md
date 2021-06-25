# Java

- [Java](#java)
  - [Stream](#stream)
    - [重複排除](#重複排除)
    - [1行目を読み飛ばす](#1行目を読み飛ばす)
    - [String -> Model](#string---model)
    - [Stream -> List](#stream---list)
    - [Stream -> Map](#stream---map)
    - [合計値算出](#合計値算出)
    - [List -> Stream](#list---stream)
    - [配列 -> Stream](#配列---stream)
    - [ファイル -> Stream](#ファイル---stream)
  - [実行可能jarファイルの実行](#実行可能jarファイルの実行)
  - [新規ファイルの書き込み](#新規ファイルの書き込み)
    - [ファイルの書き込み：参考](#ファイルの書き込み参考)
  - [最小の実行環境を提供する(jdeps, jlink)](#最小の実行環境を提供するjdeps-jlink)
    - [前提](#前提)
    - [手順](#手順)
    - [参考](#参考)

## Stream

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

### 合計値算出

``` java
.mapToInt(model -> model.getInt())
.sum();
```

### List -> Stream

``` java
list.stream()
```

### 配列 -> Stream

``` java
Stream.of(配列)
```

### ファイル -> Stream

``` java
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

Path inputPath = Paths.get(filePath);
Stream stream = Files.lines(inputPath);
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

try(BufferedWriter writer = Files.newBufferedWriter(Paths.get("書き込みファイルパス"), Charset.forName("UTF-8"), StandardOpenOption.CREATE))) {

}
```

### ファイルの書き込み：参考

[https://docs.oracle.com/javase/jp/8/docs/api/java/nio/file/Files.html#newBufferedWriter-java.nio.file.Path-java.nio.charset.Charset-java.nio.file.OpenOption...-](https://docs.oracle.com/javase/jp/8/docs/api/java/nio/file/Files.html#newBufferedWriter-java.nio.file.Path-java.nio.charset.Charset-java.nio.file.OpenOption...-)

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
