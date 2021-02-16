# Oracle

- [Oracle](#oracle)
  - [SQL*plus](#sqlplus)
    - [ログイン](#ログイン)
    - [横幅を調整する](#横幅を調整する)
    - [項目表示時の横幅を調節する](#項目表示時の横幅を調節する)
    - [ヘッダ行の表示タイミングを制御する](#ヘッダ行の表示タイミングを制御する)
  - [ユーザアカウントロック解除](#ユーザアカウントロック解除)
    - [ユーザアカウントステータス確認](#ユーザアカウントステータス確認)
    - [参考](#参考)
  - [ユーザ・テーブルごと権限確認](#ユーザテーブルごと権限確認)
  - [実行計画取得](#実行計画取得)
    - [対象テーブル一覧取得](#対象テーブル一覧取得)
    - [統計情報更新](#統計情報更新)
    - [実行計画取得](#実行計画取得-1)
  - [テーブル一覧確認](#テーブル一覧確認)
    - [参考](#参考-1)
  - [テーブル定義取得](#テーブル定義取得)
    - [参考](#参考-2)
  - [CSVデータ取得](#csvデータ取得)
    - [方法1](#方法1)
    - [方法2](#方法2)
    - [カラム名の出力について](#カラム名の出力について)
    - [参考](#参考-3)
  - [CSVデータ登録](#csvデータ登録)
    - [ctlファイル](#ctlファイル)
      - [参考：登録方法](#参考登録方法)
    - [実行](#実行)

## SQL*plus

### ログイン

```
sqlplus /nolog
conn sys/oracle as sysdba
```

```
sqlplus <ユーザ名（スキーマ名）>/<パスワード>@<接続先ホスト>:<ポート番号>/<接続文字列> @<実行したいSQLのパス>
```

### 横幅を調整する

``` sql
set linesize <値>
```

### 項目表示時の横幅を調節する

``` sql
column <列名> format a{値} [TRUNCATE]
```

### ヘッダ行の表示タイミングを制御する

``` sql
set pagesize <値>
```

## ユーザアカウントロック解除

``` sql
ALTER USER <ユーザ名> ACCOUNT UNLOCK;
```
### ユーザアカウントステータス確認

```sql
column username format a25 TRUNCATE
column profile format a25 TRUNCATE

select username, account_status, profile from dba_users where username = 'TEST';
```

### 参考

- [Qiita:急にoracleに繋がらなくなった！？～ORA-28001:パスワードが期限切れです～](https://qiita.com/maruyama42/items/cb3177f8701f1679669a)
- [Oracle使いのネタ帳。:ORA-28000：Oracleユーザのアカウントロックを解除する](https://www.sql-dbtips.com/architecture/account-lock/)

## ユーザ・テーブルごと権限確認

```sql
select 
  grantee,
  table_name,
  privilege
from
  user_tab_privu
;
```

## 実行計画取得

Oracleの統計情報更新と実行計画取得方法について記載。  
（※誤字はチェックしていない。）

### 対象テーブル一覧取得

```sql
SELECT TABLE_NAME FROM USER_TABLES
ORDER BY TABLE_NAME
```

### 統計情報更新

```sql
set pagesize 400
set linsize 200
set echo on
set triming on

spool '<ログ出力パス>'

column tname Format a25 truncate;
select substr(table_name, 1, 25) as tname, to_char( last_analyzed, 'YYYY-MM-DD HH24:MI:SS') as last_analyzed, num_rows from user_tables;

-- 対象テーブルはuser_tablesで取得できるテーブルを全部並べたほうが良い。
analyze table <対象テーブル> compute statistics;

select substr(table_name, 1, 25) as tname, to_char( last_analyzed, 'YYYY-MM-DD HH24:MI:SS') as last_analyzed, num_rows from user_tables;

column iname Format a10 truncate;
select substr(table_name, 1, 25) as tname, substr(index_name, 1, 10) as iname, to_char( last_analyzed, 'YYYY-MM-DD HH24:MI:SS') as last_analyzed, from user_indexes order by tname, iname;

spool off

```

### 実行計画取得

※事前に評価対象のSQLを用意する。

```sql
set pagesize 400
set linsize 200
set echo on
set triming on

spool '<ログ出力パス>'

explain plan SET STATEMENT_ID = '<任意のID>' FOR
<評価対象のSQL>

select * from table(dbms_xplan.display('PLAN_TABLE','<任意のID>','TYPICAL'));

spool off

exit
```

## テーブル一覧確認

準備
``` sql
set pagesize 40
set linesize 250
column TABLE_NAME format a30 TRUNCATE
```


ログインユーザのテーブル一覧を取得する。
``` sql
SELECT *
FROM USER_TABLES
ORDER BY TABLE_NAME
```

ログインユーザがアクセスできるテーブル一覧を取得する。
``` sql
SELECT *
FROM   ALL_TABLES
ORDER BY OWNER,TABLE_NAME
```

データベース内のすべてのテーブルを取得する。
``` sql
SELECT *
FROM   DBA_TABLES
ORDER BY OWNER,TABLE_NAME
```

指定した表領域にあるテーブル一覧を取得する。
``` sql
SELECT TABLE_NAME
FROM   *
WHERE  TABLESPACE_NAME = ‘＜表領域名＞’
ORDER BY TABLE_NAME
```

### 参考

[PROJECT GROUP:テーブルの一覧を取得する（USER_TABLES / ALL_TABLES）](https://www.projectgroup.info/tips/Oracle/SQL/SQL000019.html)

## テーブル定義取得

BLOB出力なので、set longとset pages(set pagesizeの省略形)が必要。

``` sql
set long 10000
set pages 0

set linesize 250
set dbms_metadata.get_ddl('オブジェクトの種類','オブジェクト名','スキーマ名') format a250

select dbms_metadata.get_ddl('オブジェクトの種類','オブジェクト名','スキーマ名') from dual;
```

- オブジェクトの種類
  - TABLESPACE
  - TABLE
  - INDEX
  - VIEW
  - SYNONYM
  - PACKAGE
  - PROCEDURE
  - etc...
- スキーマ名
  - 省略可能。省略した場合は現在のスキーマ。

### 参考

- [Oracle使いのネタ帳:Oracle DDL取得(DBMS_METADATA.GET_DDL)](https://www.sql-dbtips.com/backup-recovery/get-ddl/)
- [SQL*Plus®ユーザーズ・ガイドおよびリファレンス:リリース1 (12.1):SET LONG {80 \| n}](https://docs.oracle.com/cd/E57425_01/121/SQPUG/GUID-61E0AB01-A2C4-4AAE-97C7-C5D8BE5DE1BF.htm)
  - set longについて

## CSVデータ取得

### 方法1

SQL書くのが楽だが、値に半角スペースが含まれるのでトリムしなければならない。
``` sql
-- 検索結果をCSVへ出力する

-- コンソールメッセージを非表示にする
SET ECHO OFF

-- 1行に出力するバイト数
-- 少ないと見切れるので最大に設定する
SET LINESIZE 32767

-- 1ページの行数
-- 少ないとヘッダーが多くて見づらいので無制限に設定する
SET PAGESIZE 0

-- 「○○行が選択されました」メッセージを非表示にする
SET FEEDBACK OFF

-- 区切り文字をカンマに指定する
SET COLSEP ','

-- 各行の右端にあるスペースを削除する
SET TRIMSPOOL ON

-- 出力パスは適宜変更する
SPOOL <任意の出力パスに設定する>

-- 検索文は適宜変更する
SELECT *
  FROM {テーブル名}
;

-- ④出力終了
SPOOL OFF
```

### 方法2

カラム一覧とヘッダ行は別途確認しておく必要がある。
``` sql
SET ECHO OFF
SET LINESIZE 32767
SET PAGESIZE 0
SET FEEDBACK OFF
SET TRIMSPOOL ON
SPOOL <任意の出力パスに設定する>

select <カラム1> || ','
       <カラム2> || ','
from テーブル名;

SPOOL OFF
```

### カラム名の出力について

```SET PAGESIZE 0```するとヘッダ行が表示されないので、別途生成する必要がある。
（```select cound(*) from テーブル名;```で行数を確認してから指定してもいいが...）

``` sql 
SELECT
  column_name
  , data_type
  , data_length
FROM
  all_tab_columns 
WHERE
  owner = 'HOGE'
  AND table_name = 'FUGA'
ORDER BY
  column_id; 
```

### 参考

- [Qiita:SELECT文の検索結果をCSVへ出力するSQL(Oracle)](https://qiita.com/uhooi/items/7d5e9b5deb5968dbbe8c)
- [Qiita:【Oracle】テーブルのカラム情報をSQLで取得する方法](https://qiita.com/riekure/items/b54c8a21d77e5fe1776d)

## CSVデータ登録

sql*lorder を使う。

### ctlファイル

``` ctl
options(skip = 1)
load data
infile '<csvパス>'
<登録方法>
into table <テーブル名>
fields terminated by ','
optionally enclosed by '"'
trailing nullcols(
  <カラム名>, <カラム名> ...
)
```
登録方法はとりあえずtruncateでいいんじゃないかな…

#### 参考：登録方法

[忘れっぽいエンジニアのオラクルSQLリファレンス:４種類のロードタイプ（INSERT/APPEND/REPLACE/TRUNCATE）](http://oracle.se-free.com/utl/C2_type.html)

### 実行

```
sqlldr <接続情報> <ctlファイルパス>
```
※接続情報はsql*plusと同じ。
