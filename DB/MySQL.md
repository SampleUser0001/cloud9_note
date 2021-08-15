# MySQL

- [MySQL](#mysql)
  - [起動/終了/生存確認](#起動終了生存確認)
    - [起動](#起動)
    - [終了](#終了)
    - [生存確認](#生存確認)
    - [参考](#参考)
  - [データベース作成](#データベース作成)
  - [ファイルから実行する](#ファイルから実行する)
  - [ユーザ一覧表示](#ユーザ一覧表示)
  - [権限のはく奪](#権限のはく奪)
  - [ログイン](#ログイン)
    - [.mylogin.cnfを使用する](#mylogincnfを使用する)
      - [ファイル作成](#ファイル作成)
      - [ログイン](#ログイン-1)
      - [ファイル参照](#ファイル参照)
      - [参考](#参考-1)

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

## データベース作成

``` sql
CREATE DATABASE <DB名>
```

## ファイルから実行する

下記のいずれか

1. shell> mysql [DB名] < [ファイル名]
  - ```-N```オプションでカラム名非表示にできる。
2. mysql> source [ファイル名]
3. mysql> ./[ファイル名]

## ユーザ一覧表示

mysqlユーザでuserテーブルを参照する。

``` sql
use mysql
select user, host from user;
```

## 権限のはく奪

``` sql
REVOKE 権限
    ON データベース名.テーブル名
  FROM 'ユーザ'@'ホスト'
```

## ログイン

1. ```mysql -u ${ユーザ名}```
2. ```mysql -u ${ユーザ名} -p```
   - ログイン時にパスワードを聞かれる
3. ```mysql -u ${ユーザ名} -p${パスワード}```
   - pオプションの後ろにスペースを入れてはいけない
4. ```mysql -h ${接続先ホスト} -u ${ユーザ名}```

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
