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

