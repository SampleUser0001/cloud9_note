# jq

- [jq](#jq)
  - [csvに変換する](#csvに変換する)
    - [参考](#参考)

## csvに変換する

こうだったら・・・

``` json
{
  "data":[
    {
      "hoge":"value1",
      "piyo":"value2"
    },
    {
      "hoge":"value01",
      "piyo":"value02"
    }
  ]
}
```

``` sh
cat ${jsonファイル} | jq -r '.data[] | [.hoge, .piyo] | @csv'
```

- ```'```でくくる。
- ```\.data[]```でdataが剥がれる。
- ```[.hoge, .piyo]```で抽出対象の項目のキーを指定。
- ```@csv```でcsv形式に変換。

### 参考

- [Linux Tips: コマンドラインでJSONをCSVに変換する:エクスチュア株式会社ブログ](https://ex-ture.com/blog/2020/04/15/learn-jq-command-with-covid-19-data/)

