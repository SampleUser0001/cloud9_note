# Java

実装の話ではなくて、環境の話。

- [Java](#java)
  - [最小の実行環境を提供する(jdeps, jlink)](#最小の実行環境を提供するjdeps-jlink)
    - [前提](#前提)
    - [手順](#手順)
    - [参考](#参考)

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
