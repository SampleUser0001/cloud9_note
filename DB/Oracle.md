# Oracle

- [Oracle](#oracle)
  - [SQL\*plus](#sqlplus)
    - [インストール](#インストール)
      - [参考](#参考)
    - [ログイン](#ログイン)
    - [横幅を調整する](#横幅を調整する)
    - [項目表示時の横幅を調節する](#項目表示時の横幅を調節する)
    - [ヘッダ行の表示タイミングを制御する](#ヘッダ行の表示タイミングを制御する)
    - [「レコードが選択されませんでした」を出力しない](#レコードが選択されませんでしたを出力しない)
  - [tnsnames.ora](#tnsnamesora)
    - [SID確認](#sid確認)
    - [サービス名確認](#サービス名確認)
  - [ユーザ一覧](#ユーザ一覧)
  - [ユーザアカウントロック解除](#ユーザアカウントロック解除)
    - [ユーザアカウントステータス確認](#ユーザアカウントステータス確認)
    - [参考](#参考-1)
  - [ユーザ・テーブルごと権限確認](#ユーザテーブルごと権限確認)
  - [実行計画取得](#実行計画取得)
    - [対象テーブル一覧取得](#対象テーブル一覧取得)
    - [統計情報更新](#統計情報更新)
    - [実行計画取得](#実行計画取得-1)
  - [オブジェクト一覧](#オブジェクト一覧)
  - [テーブル一覧確認](#テーブル一覧確認)
    - [参考](#参考-2)
  - [テーブル定義取得](#テーブル定義取得)
    - [参考](#参考-3)
  - [CSVデータ取得](#csvデータ取得)
    - [方法1](#方法1)
    - [方法2](#方法2)
    - [カラム名の出力について](#カラム名の出力について)
    - [参考](#参考-4)
  - [CSVデータ登録](#csvデータ登録)
    - [ctlファイル](#ctlファイル)
      - [説明](#説明)
      - [登録方法](#登録方法)
        - [参考：登録方法](#参考登録方法)
      - [trailing nullcols](#trailing-nullcols)
      - [参考](#参考-5)
    - [実行](#実行)
  - [Timestamp型 -\> 秒変換する(EXTRACT)](#timestamp型---秒変換するextract)
    - [参考](#参考-6)
  - [ユーザオブジェクトの削除](#ユーザオブジェクトの削除)
    - [参考](#参考-7)
  - [Dockerで環境構築する](#dockerで環境構築する)
    - [docker-compose.yml](#docker-composeyml)
    - [コンテナ外からの接続](#コンテナ外からの接続)
    - [注意点](#注意点)
    - [参考](#参考-8)
  - [権限を確認する](#権限を確認する)
  - [expdp/impdp(エクスポート/インポート)](#expdpimpdpエクスポートインポート)
    - [expdp](#expdp)
    - [impdp](#impdp)
      - [parファイル](#parファイル)
  - [Oracle Database アーキテクチャ](#oracle-database-アーキテクチャ)
    - [参考](#参考-9)
  - [ライセンス](#ライセンス)
    - [OTN](#otn)
  - [用語](#用語)
    - [グローバル・データベース名](#グローバルデータベース名)
    - [SID](#sid)

## SQL*plus

### インストール

Windowsにインストールする方法を記載。

1. [ここ](https://www.oracle.com/database/technologies/instant-client/winx64-64-downloads.html)からファイルダウンロード。
  - Basic Package
  - SQL*Plus Package
2. ```mkdir c:\oracle```
3. 取得したファイルを展開し、```c:\oracle```に配置。
4. ```c:\oracle\tnsnames.ora```を作成
5. 環境変数追加
  ``` cmd
  set ORACLE_HOME=c:\oracle
  set PATH=%PATH%;%ORACLE_HOME%
  set TNS_ADMIN=%ORACLE_HOME%
  set NLS_LANG = JAPANESE_JAPAN.JA16SJISTILDE
  ```

#### 参考

- [【最新】Oracleクライアントのインストール手順:おじさんネットワークエンジニアの気まぐれ日記](https://yutoko.com/oracle%E3%82%AF%E3%83%A9%E3%82%A4%E3%82%A2%E3%83%B3%E3%83%88%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%89%8B%E9%A0%86/)

### ログイン

```
sqlplus /nolog
conn sys/oracle as sysdba
```

``` cmd
set ORACLE_LOGIN_USER=
set ORACLE_LOGIN_PASSWORD=
set ORACLE_SERVER_HOST=
set ORACLE_SERVER_PORT=
set ORACLE_CONNECT_WORD=
set EXECUTE_SQL_PATH=

sqlplus %ORACLE_LOGIN_USER%/%ORACLE_LOGIN_PASSWORD%@%ORACLE_SERVER_HOST%:%ORACLE_SERVER_PORT%/%ORACLE_CONNECT_WORD% @%EXECUTE_SQL_PATH%

rem tnsnames.oraでネットサービス名が指定されている場合
set ORACLE_NET_SERVICE_NAME=
sqlplus %ORACLE_LOGIN_USER%/%ORACLE_LOGIN_PASSWORD%@%ORACLE_NET_SERVICE_NAME%
```

``` bash
export ORACLE_LOGIN_USER=
export ORACLE_LOGIN_PASSWORD=
export ORACLE_SERVER_HOST=
export ORACLE_SERVER_PORT=
export ORACLE_CONNECT_WORD=
export EXECUTE_SQL_PATH=
sqlplus ${ORACLE_LOGIN_USER}/${ORACLE_LOGIN_PASSWORD}@//${ORACLE_SERVER_HOST}:${ORACLE_SERVER_PORT}/${ORACLE_CONNECT_WORD} @${EXECUTE_SQL_PATH%}

# tnsnames.oraでネットサービス名が指定されている場合
export ORACLE_NET_SERVICE_NAME=
sqlplus ${ORACLE_LOGIN_USER}/${ORACLE_LOGIN_PASSWORD}@${ORACLE_NET_SERVICE_NAME}
```

- Welcomeメッセージを削除したい場合は、-sオプションを指定する。
- 接続文字列 = ネットサービス名

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

### 「レコードが選択されませんでした」を出力しない

``` sql
set FEEDBACK off
```

## tnsnames.ora

``` ora
ネットサービス名= 
    (DESCRIPTION =
        (ADDRESS =
            (PROTOCOL = TCP)
            (HOST = ホスト名)
            (PORT = 1521)
        )
        (CONNECT_DATA = 
            (SERVICE_NAME = サービス名)
        )
    )
```

- SID
    - データベースの識別子。
    - マシン内でデータベースを識別するときに使う。
    - ローカル接続するときにこれを指定する。
- SERVICE_NAME
    - 同一機能を提供するインスタンスの集合体の名前

### SID確認

``` sql
SELECT DBID,NAME,DB_UNIQUE_NAME,CURRENT_SCN,LOG_MODE FROM V$DATABASE
```

### サービス名確認

``` sql
show parameter service_name
```

## ユーザ一覧

``` sql
set linesize 200
column USERNAME format a30 TRUNCATE

SELECT * FROM ALL_USERS;
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

``` sql
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

## オブジェクト一覧

``` sql
select * 
from USER_OBJECTS 
where object_type = '${任意のタイプ}' 
;
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

select <カラム1> || ',' ||
       <カラム2> || ',' ||
       ... || ',' ||
       <カラムn>
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
infile '<ファイルパス>'
<登録方法> into table <対象テーブル>
fields terminated by ',' 
optionally enclosed by '"'
trailing nullcols(
  EMPNO DECIMAL EXTERNAL,
  ENAME CHAR,
  JOB CHAR,
  MGR DECIMAL EXTERNAL,
  HIREDATE DATE "YYYYMMDD",
  SAL DECIMAL EXTERNAL,
  COMM DECIMAL EXTERNAL,
  DEPTNO DECIMAL EXTERNAL
)

```

#### 説明

- options(skip = 1)
    - 1行目を読み飛ばす
- fields terminated by ',' 
    - カンマ区切り
- optionally enclosed by '"'
    - 項目をダブルクォーテーションで囲む（かもしれない）。
- trailing nullcols
    - 読み込んだとき、CSVの対象項目が空文字だった場合、NULLで埋める。

#### 登録方法

- APPEND
    - テーブルが空のときに登録
- REPLACE
    - Delete - Insertする。失敗したときはRollbackする。
- TRUNCATE
    - Delete - Insertする。失敗してもRollbackしない。

##### 参考：登録方法

[忘れっぽいエンジニアのオラクルSQLリファレンス:４種類のロードタイプ（INSERT/APPEND/REPLACE/TRUNCATE）](http://oracle.se-free.com/utl/C2_type.html)

#### trailing nullcols

- ここに項目が書かれていると、CSVが空文字のときにNullを指定する。
- 型を指定できる。

| 指定 | 型 |
| :-- | :-- |
| DECIMAL EXTERNAL | 数値（文字列として扱われていても、数値に変換して登録する。） |
| CHAR | 文字列 |
| DATE "YYYYMMDD" | 日付とフォーマット |

型は指定したいがNULLにしたくない場合は、デフォルト値を書く。

``` txt
HIREDATE DATE "DD-MM-YYYY" DEFAULTIF HIREDATE = BLANKS "01-01-1900",
```

#### 参考

テーブル定義
``` sql
CREATE TABLE EMP (
 EMPNO               NUMBER(4) not null,
 ENAME               varchar2(10),
 JOB                 varchar2(9),
 MGR                 NUMBER(4),
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) );

```

emp.ctl

``` ctl
options(skip = 1)
load data
infile './emp.csv'
replace
into table emp
fields terminated by ','
optionally enclosed by '"'
trailing nullcols(
  EMPNO DECIMAL EXTERNAL,
  ENAME CHAR,
  JOB CHAR,
  MGR DECIMAL EXTERNAL,
  HIREDATE DATE "YYYYMMDD",
  SAL DECIMAL EXTERNAL,
  COMM DECIMAL EXTERNAL,
  DEPTNO DECIMAL EXTERNAL
)
```

emp.csv

``` csv
EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO
7369,SMITH,CLERK,7902.0,19801217,800,,20
7499,ALLEN,SALESMAN,7698.0,19810220,1600,300.0,30
```

### 実行

``` bash
sqlldr <接続情報> <ctlファイルパス>
```

※接続情報はsql*plusと同じ。

## Timestamp型 -> 秒変換する(EXTRACT)

[SQL.md](https://sampleuser0001.github.io/cloud9_note/DB/SQL.html#timestamp%E5%9E%8B---%E7%A7%92%E5%A4%89%E6%8F%9B%E3%81%99%E3%82%8Bextract)参照。

### 参考

- [DockerでOracle動かしたついでに、公式サンプルデータを突っ込んでから、ER図を自動生成してみようぜ:Zenn](https://zenn.dev/angelica/articles/9e2411db5fc1b7)

## ユーザオブジェクトの削除

Table, View, Index, Sequence... 等を削除する。

``` sql
-- 重複が発生する。事前に通常のSelectを実行して確認する。
SELECT 'DROP ' || OBJECT_TYPE ||' '|| OBJECT_NAME || ';'
FROM USER_OBJECTS;
```

### 参考

- [オラクルのオブジェクトを全部削除したいけど、一つずつ書くのが面倒くさい。って場合。:zero0nine](https://zero0nine.com/archives/414)

## Dockerで環境構築する

``` bash
git clone https://github.com/oracle/docker-images.git
cd docker-images/OracleDatabase/SingleInstance/dockerfiles/
# 任意のバージョンを選択する。lsして確認。
ORACLE_VERSION=23.5.0
./buildContainerImage.sh -v $ORACLE_VERSION -f

# コンテナ起動
docker run --name oracle-db -e ORACLE_PWD=password oracle/database:$ORACLE_VERSION-free

# コンテナログイン
docker exec -it oracle-db bash

# sqlplus起動
sqlplus system/password@//localhost:1521/FREEPDB1
```

### docker-compose.yml

``` yml
version: '3'
services:
  oracle-db:
    image: oracle/database:23.5.0-free
    container_name: oracle-db
    port:
      - 1521:1521
    environment:
      - ORACLE_PWD=password
    volumes:
      - ./plsql:/home/oracle/plsql
```

### コンテナ外からの接続

接続できるようになるまで、少し時間がかかる。

| 項目名 | 値 |
| :----- | :-- |
| 認証タイプ | デフォルト |
| ロール | デフォルト |
| ユーザ名 | system |
| パスワード | 環境変数:ORACLE_PWDの値 |
| ホスト名 | localhost |
| ポート | 1521 |
| タイプ | サービス名 |
| サービス名 | FREEPDB1 |

### 注意点

Oracleに限らないが、コンテナ内でディレクトリに対してファイル作成を行う場合は、ホスト側のディレクトリに書き込み権限をつけること。

``` bash
chmod 777 ${dir_path}
```

### 参考

- [DockerでOracle Databaseを構築してみる:Qiita](https://qiita.com/h-i-ist/items/a67acbce0e7c6bdebd69)

## 権限を確認する

``` sql
SELECT * FROM SYS.DBA_SYS_PRIVS;
```

## expdp/impdp(エクスポート/インポート)

### expdp

``` bash
sqlplus system/password@//localhost:1521/FREEPDB1
```

``` sql
create or replace directory BACKUP_DIR as '/home/oracle/datas';
commit;
exit
```

``` bash
expdp system/password@//localhost:1521/FREEPDB1 directory=backup_dir dumpfile=test.dmp;
```

### impdp

``` bash
impdp system/password@//localhost:1521/FREEPDB1 directory=backup_dir dumpfile=test.dmp;
```

#### parファイル

インポート設定ファイル。引数として渡してもインポートできるが、設定ファイルとして外に出しておくのが望ましい。

作成例

``` par
directory=DATA_PUMP_DIR
dumpfile=mydumpfile.dmp
logfile=import.log
schemas=MY_SCHEMA
tables=MY_SCHEMA.EMPLOYEES, MY_SCHEMA.DEPARTMENTS
table_exists_action=REPLACE
```

- table_exists_action
    - SKIP
        - 既存のテーブルがあれば、そのテーブルをスキップしてインポートしません（デフォルト）。
    - APPEND
        - 既存のテーブルに新しいデータを追加（追記）します。
        - エラーになるテーブル、レコードがあった場合、エラーにならない範囲で登録される。
    - TRUNCATE
        - 既存のテーブルのデータを削除（TRUNCATE）してから、データをインポートします。
    - REPLACE
        - 既存のテーブルをドロップしてから、新しくテーブルを作成し、データをインポートします。

## Oracle Database アーキテクチャ

Oracleデータベースサーバは1つのデータベースと、1つ以上のデータベース・インスタンスで構成される。

- データベース
  - ディスク上に配置された、ユーザ・データを格納する一覧のファイル。データベース・インスタンスとは別に存在できる。
  - Oracle Database 20cから下記をさすようになった。
    - マルチテナント・コンテナ・データベース(CDB)
    - プラガブル・データベース(PDB)
    - アプリケーション・コンテナのデータファイル
- データベース・インスタンス
  - データベース・ファイルを管理する一連の名前付きメモリー構造
  - システムグローバル領域(SGA)と呼ばれる共通領域と、一連のバックグラウンド・プロセスで構成される。
  - データベース・ファイルとは別に存在できる。

### 参考

- [Oracle Databaseアーキテクチャ:Oracle Databaseの概要](https://docs.oracle.com/cd/F32587_01/cncpt/introduction-to-oracle-database.html#GUID-CF765A7D-9429-4901-BF33-36E0B0220293)

## ライセンス

### OTN

自社内または個人的なアプリケーション開発、テスト、プロトタイプ作成、デモンストレーション目的であれば無償で使用できる。

## 用語

### グローバル・データベース名

リモート接続において、接続先のデータベースを識別するために使用される。

### SID

マシン内でデータベースを識別する際に使われる。  
ローカル接続で使用される。

