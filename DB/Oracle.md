# Oracle

## 実行計画取得

Oracleの統計情報更新と実行計画取得方法について記載。  
（※誤字はチェックしていない。）

### 統計情報更新

```analyze.sql
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

```
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
