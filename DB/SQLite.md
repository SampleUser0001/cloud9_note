# SQLite

- [SQLite](#sqlite)
  - [公式サイトへのリンク](#公式サイトへのリンク)
  - [起動](#起動)
  - [テーブル作成](#テーブル作成)
    - [参考](#参考)
  - [insert](#insert)
  - [終了](#終了)
  - [外部ファイルを実行する](#外部ファイルを実行する)

## 公式サイトへのリンク

- [Documentation](https://www.sqlite.org/docs.html)
    - [SQL As Understood By SQLite](https://www.sqlite.org/lang.html)
        - Documentation -> Programing Interface -> SQL Syntax

## 起動

``` bash
sqlite3 ${DBファイルパス}
```

## テーブル作成

``` sql
create table username(id integer primary key autoincrement, name text);
```

### 参考

- [SQLiteコマンドラインツールのテスト:DBOnline](https://www.dbonline.jp/sqlite/install/index2.html)

## insert

``` sql
--autoincrementしている場合、idは不要。
insert into username (id, name) values (1, 'hoge');
```

## 終了

``` sqlite
sqlite> .quit
```

## 外部ファイルを実行する

``` bash
sqlite3 ${ファイルパス} < ${SQLパス}
```