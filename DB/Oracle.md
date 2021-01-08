# Oracle

- [Oracle](#oracle)
  - [SQL*plus](#sqlplus)
    - [ログイン](#ログイン)
    - [横幅を調整する](#横幅を調整する)
    - [項目表示時の横幅を調節する](#項目表示時の横幅を調節する)
    - [ヘッダ業の表示タイミングを制御する](#ヘッダ業の表示タイミングを制御する)
  - [ユーザアカウントロック解除](#ユーザアカウントロック解除)
    - [ユーザアカウントステータス確認](#ユーザアカウントステータス確認)
    - [参考](#参考)
  - [ユーザ・テーブルごと権限確認](#ユーザテーブルごと権限確認)
  - [実行計画取得](#実行計画取得)
    - [対象テーブル一覧取得](#対象テーブル一覧取得)
    - [統計情報更新](#統計情報更新)
    - [実行計画取得](#実行計画取得-1)
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

### 横幅を調整する

```
set linesize <値>
```

### 項目表示時の横幅を調節する

```
column <列名> format a{値} [TRUNCATE]
```

### ヘッダ業の表示タイミングを制御する

```
set pagesize <値>
```

## ユーザアカウントロック解除

```
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

## CSVデータ登録

sql*lorder を使う。

### ctlファイル

```
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
