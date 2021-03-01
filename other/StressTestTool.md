# 負荷テストツール

## JMetar

Java8以上が必要。

### インストール

1. 下記ページからダウンロード
   - [https://jmeter.apache.org/download_jmeter.cgi](https://jmeter.apache.org/download_jmeter.cgi)
   - Binariesのzipを選ぶ。
2. 解凍
3. 解凍したディレクトリを任意のパスに移動
4. ついでにシンボリックリンクとエイリアス設定

``` sh
# /opt配下にコピーしたと仮定する。
cd /opt
sudo ln -s ./apache-jmeter-5.4.1 ./jmeter
```

${HOME}/.bashrc

``` sh
# JMeter
# shではない方を指定。
alias jmetergui='sh /opt/jmeter/bin/jmeter'
```

### メニュー日本語化

jmeter/bin/jmeterを修正する。

``` sh
# Set language
# Default to en_EN
# : "${JMETER_LANGUAGE:="-Duser.language=en -Duser.region=EN"}"
# Japanese
: "${JMETER_LANGUAGE:="-Duser.language=ja -Duser.region=JP"}"
```

Windows版はjmeter/bin/jmeter.batを修正。

### GUI起動

- Linuxの場合
  - bin配下のjmeter.shを実行
- Windowsの場合
  - bin配下のjmeter.batを実行



### 参考:JMeter

- [Apache JMeter](https://jmeter.apache.org/)
  - 公式
- [Qiita:Jmeter のインストールから負荷テストまで](https://qiita.com/shotets/items/d553d7be0d407a9a9a53)
- [Qiita:Apache JMeterの設定（日本語化、プロキシ設定）](https://qiita.com/gtom7156/items/92aab9185c5b7d5feda9)

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