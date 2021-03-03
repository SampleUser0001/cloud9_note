# 負荷テストツール

- [負荷テストツール](#負荷テストツール)
  - [JMetar](#jmetar)
    - [インストール](#インストール)
      - [(Linux)シンボリックリンクとエイリアス設定](#linuxシンボリックリンクとエイリアス設定)
      - [(Windows)ショートカット作成](#windowsショートカット作成)
    - [メニュー日本語化](#メニュー日本語化)
    - [GUI起動](#gui起動)
    - [(GUI)テスト計画を作成する](#guiテスト計画を作成する)
      - [テスト計画概要](#テスト計画概要)
      - [jmx出力](#jmx出力)
    - [負荷テスト実行](#負荷テスト実行)
      - [Linux](#linux)
      - [Windows](#windows)
    - [出力結果確認](#出力結果確認)
    - [参考:JMeter](#参考jmeter)
  - [Vegeta](#vegeta)
    - [インストール](#インストール-1)
    - [参考:Vegeta](#参考vegeta)

## JMetar

[JMeter.md](./JMeter/JMeter.md)

Java8以上が必要。  

### インストール

1. 下記ページからダウンロード
   - [https://jmeter.apache.org/download_jmeter.cgi](https://jmeter.apache.org/download_jmeter.cgi)
   - Binariesのzipを選ぶ。
2. 解凍
3. 解凍したディレクトリを任意のパスに移動

#### (Linux)シンボリックリンクとエイリアス設定

``` sh
# /opt配下にコピーしたと仮定する。
cd /opt
sudo ln -s ./apache-jmeter-5.4.1 ./jmeter
```

${HOME}/.bashrc

``` sh
# JMeter
# shではない方を指定。
alias jmeter='sh /opt/jmeter/bin/jmeter'
```

#### (Windows)ショートカット作成

下記のbatファイルのショートカットを任意の場所に作成する。
- bin\\jmeter.bat
  - GUIメニュー
- bin\\jmeter-n.cmd
  - 負荷テスト起動cmd

### メニュー日本語化

(Linux)jmeter/bin/jmeterを修正する。  
(Windows)jmeter/bin/jmeter.batを修正する。

``` sh
# Set language
# Default to en_EN
# : "${JMETER_LANGUAGE:="-Duser.language=en -Duser.region=EN"}"
# Japanese
: "${JMETER_LANGUAGE:="-Duser.language=ja -Duser.region=JP"}"
```

### GUI起動

- Linuxの場合
  - bin配下のjmeterを実行
- Windowsの場合
  - bin配下のjmeter.batを実行

### (GUI)テスト計画を作成する

GUI画面から設定する。
最終的にjmxファイルに出力する。
**GUIから実行してはいけない。**

#### テスト計画概要

- テスト計画
  - JMeterテストの最上位要素。
  - テストの全体。
- スレッドグループ
  - ユーザを表す。
  - スレッド数、Ramp-up、ループ回数を指定できる。
    - スレッド数
      - 実行するテストのスレッド数。
    - Ramp-up
      - ループ1回の実行時間
    - ループ回数
      - ループの回数
- サンプラー
  - スレッドグループの子要素。
  - スレッドグループ(ユーザ)で実行する操作。

#### jmx出力

ctrl + sを押下して、ファイル保存。

### 負荷テスト実行

#### Linux

ヘルプが```jmeter --help```で見られる。  
ここには全部載せていないので、適宜確認。

``` sh
jmeter -n -t <jmxファイル> [-l <実行結果CSV>] [-j <実行ログファイル>] -e -o [<アウトプットパス>]
```

#### Windows

jmxファイルをjmeter-n.cmdにドロップする。

### 出力結果確認

<テストファイル名>.jtlファイルが作成される。(中身はCSV。)

### 参考:JMeter

- [Apache JMeter](https://jmeter.apache.org/)
  - 公式
- [Qiita:Jmeter のインストールから負荷テストまで](https://qiita.com/shotets/items/d553d7be0d407a9a9a53)
- [Qiita:Apache JMeterの設定（日本語化、プロキシ設定）](https://qiita.com/gtom7156/items/92aab9185c5b7d5feda9)
- [Qiita:WSL2におけるVcXsrvの設定](https://qiita.com/ryoi084/items/0dff11134592d0bb895c)
  - WSL2でGUI起動しようとすると下記エラーで起動できない。
    - ```No X11 DISPLAY variable was set, but this program performed an operation which requires it.```
  - その回避方法。
  - そのうちやる。
- [Check!Site:Linuxコマンドラインで JMeter を実行する方法](https://www.checksite.jp/jmeter-on-linux/)

## Vegeta

コマンドラインで使用できる。  
goが必要。

### インストール

``` sh
go get -u github.com/tsenart/vegeta
```

### 参考:Vegeta

- [Github:vegeta](https://github.com/tsenart/vegeta)
  - 公式
- [M:HTTP/HTTPSリクエスト向け負荷テストツールのVegetaがとても良かった](https://mmiyauchi.com/?p=1711)