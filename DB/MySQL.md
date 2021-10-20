# MySQL

- [MySQL](#mysql)
  - [起動/終了/生存確認](#起動終了生存確認)
    - [起動](#起動)
    - [終了](#終了)
    - [生存確認](#生存確認)
    - [参考](#参考)
  - [ログイン](#ログイン)
    - [ページャーの設定](#ページャーの設定)
      - [参考](#参考-1)
    - [.mylogin.cnfを使用する](#mylogincnfを使用する)
      - [ファイル作成](#ファイル作成)
      - [ログイン](#ログイン-1)
      - [ファイル参照](#ファイル参照)
      - [参考](#参考-2)
  - [データベース作成](#データベース作成)
  - [ユーザ一覧表示](#ユーザ一覧表示)
  - [ユーザ作成](#ユーザ作成)
    - [例](#例)
    - [参考](#参考-3)
  - [権限の付与](#権限の付与)
    - [例](#例-1)
    - [参考](#参考-4)
  - [付与されている権限の確認](#付与されている権限の確認)
  - [権限のはく奪](#権限のはく奪)
  - [ファイルから実行する](#ファイルから実行する)
  - [CSVインポート](#csvインポート)
    - [設定修正](#設定修正)
    - [CSV作成](#csv作成)
    - [登録用SQL](#登録用sql)
    - [SQL実行](#sql実行)
    - [参考](#参考-5)

## 起動/終了/生存確認

### 起動

1. mysqld --user=mysql &
2. mysqld_safe
3. mysql.server

### 終了

```
mysqladmin -u root -p shutdown &
```

### 生存確認

```
mysqladmin -u root ping
```

### 参考

- [MySQL:4.3 MySQL サーバーとサーバー起動プログラム](https://dev.mysql.com/doc/refman/5.6/ja/windows-start-command-line.html)

## ログイン

1. ```mysql -u ${ユーザ名}```
2. ```mysql -u ${ユーザ名} -p```
   - ログイン時にパスワードを聞かれる
3. ```mysql -u ${ユーザ名} -p${パスワード}```
   - pオプションの後ろにスペースを入れてはいけない
4. ```mysql -h ${接続先ホスト} -u ${ユーザ名}```

### ページャーの設定

実行結果をlessに渡したい時などに使う。  
オプションは任意。

``` sh
${ログインコマンド} --pager="less -S -n -i -F -X"
```

#### 参考

- [mysqlコンソールをpagerで便利に:Qiita](https://qiita.com/nao58/items/f651d9f2d0f420f87a50)

### .mylogin.cnfを使用する

#### ファイル作成

1. 下記実行。
    ``` sh
    mysql_config_editor set --host=${ホスト名} --login-path=${グループ名} --user=${MySQLユーザ} --password
    ```
2. パスワードを聞かれるので、パスワード入力
3. ```~/.mylogin.cnf```ファイルが作成される。

#### ログイン

``` sh
mysql --login-path=${グループ名}
```

#### ファイル参照

``` sh
mysql_config_editor print --all
```

#### 参考

- [4.6.7 mysql_config_editor — MySQL 構成ユーティリティー:MySQL 8.0 リファレンスマニュアル](https://dev.mysql.com/doc/refman/8.0/ja/mysql-config-editor.html)
- [How to use .mylogin.cnf:ゆるふわキャンパー](https://blog.lorentzca.me/how-to-use-mylogin-cnf/)

## データベース作成

``` sql
CREATE DATABASE <DB名>
```

## ユーザ一覧表示

mysqlユーザでuserテーブルを参照する。

``` sql
use mysql
select user, host from user;
```

## ユーザ作成

### 例

``` sql
CREATE USER 'comment_user'@'localhost' IDENTIFIED BY 'userpassword';
```

### 参考

[MySQLユーザ作成について:Qiita](https://qiita.com/gatapon/items/92b942fa7081cfe17482)

## 権限の付与

``` sql
GRANT ${付与する権限} ON ${対象のDB}.${対象のテーブル} TO ${対象ユーザ}@${クライアントホスト};
```

### 例

comment_user@localhostに、comment_managerデータベースの全テーブルに対する権限として、SELECT, INSERT, UPDATE, DELETEを付与する。

``` sql
GRANT SELECT, INSERT, UPDATE, DELETE ON comment_manager.* TO comment_user@localhost;
```

### 参考

[[MySQL]権限の確認と付与:Qiita](https://qiita.com/shuntaro_tamura/items/2fb114b8c5d1384648aa)

## 付与されている権限の確認

``` sql
show grants for '${ユーザ名}'@'${ホスト名}'
```

## 権限のはく奪

``` sql
REVOKE 権限
    ON データベース名.テーブル名
  FROM 'ユーザ'@'ホスト'
```

## ファイルから実行する

下記のいずれか

1. shell> mysql [DB名] < [ファイル名]
  - ```-N```オプションでカラム名非表示にできる。
2. mysql> source [ファイル名]
3. mysql> ./[ファイル名]

## CSVインポート

### 設定修正

MySQLにrootユーザでログイン。

``` mysql
set persist local_infile=1;
```

### CSV作成

``` csv
1,"hoge"
```

### 登録用SQL

``` sql
load data local
  infile "${csvファイルのパス}"
into table
  ${DB名}.${登録対象テーブル名}
fields
  terminated by ','
  optionally enclosed by '"';
```

### SQL実行

```--local-infile=1```が必要。

``` sh
mysql --local-infile=1 -h ${DBサービスホスト} -u ${DBログインユーザ} -p${DBログインパスワード} ${DB名} < ${登録用SQLパス}
```

### 参考

[【MySQL】csvファイルをDBにインポートする方法:Qiita](https://qiita.com/oden141/items/239a7ce3cfe3197a3ba7)
