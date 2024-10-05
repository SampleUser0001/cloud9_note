# PL/SQL

- [PL/SQL](#plsql)
  - [実行](#実行)
  - [PL/SQLファイルをsqlplusの引数として渡す](#plsqlファイルをsqlplusの引数として渡す)

## 実行

``` sql
-- ファイル名:hello_world.sql
-- 宣言部
DECLARE
  message VARCHAR2(50);
-- 処理部
BEGIN
  message := 'Hello, world!';
  DBMS_OUTPUT.PUT_LINE(message);
END;
/
```

sqlplusで下記実行。

``` sql
SET SERVEROUTPUT ON
@hello_world.sql
```

## PL/SQLファイルをsqlplusの引数として渡す

形としては、普通にsqlplusでSQLを実行するのと同じ。  

- `DBMS_OUTPUT.PUT_LINE`関数で標準出力するのであれば、ファイルの頭の方に`SET SERVEROUTPUT ON`を記載しておく。
- sqlファイルの末尾に`exit`が必要。ない場合、sqlplusから抜けられない。

``` bash
sqlplus ${認証情報} @${file_path}
```

