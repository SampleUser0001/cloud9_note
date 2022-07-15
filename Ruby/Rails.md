# Ruby on Rails

- [Ruby on Rails](#ruby-on-rails)
  - [install](#install)
  - [init](#init)
    - [sqliteでエラーになった場合](#sqliteでエラーになった場合)
  - [起動](#起動)
    - [任意のIPアドレスから接続する](#任意のipアドレスから接続する)

## install

``` bash
gem install rails
```

## init

``` bash
# .gitファイルが作成されるので、リモートリポジトリの生成は後でやる。
rails new ${プロジェクト名}
```

### sqliteでエラーになった場合

エラーメッセージに出ているが・・・

``` bash
sudo apt-get install libsqlite3-dev
```

## 起動

``` bash
rails s
```

### 任意のIPアドレスから接続する

``` bash
rails s -b 0.0.0.0
```