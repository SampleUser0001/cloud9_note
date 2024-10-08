# PL/SQL

- [PL/SQL](#plsql)
  - [実行](#実行)
  - [PL/SQLファイルをsqlplusの引数として渡す](#plsqlファイルをsqlplusの引数として渡す)
  - [%TYPE](#type)
  - [%ROWTYPE](#rowtype)
  - [定数](#定数)
  - [EXIT WHEN](#exit-when)
  - [FOR LOOP](#for-loop)

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

## %TYPE

既存のテーブルの列の型と同じ定義を使う。

``` sql
hoge table1.row1%TYPE
```

## %ROWTYPE

既存のテーブルの定義を型として使う。

``` sql
hoge table1%ROWTYPE
```

## 定数

``` sql
HOGE CONSTANT VARCHAR2 NOT NULL DEFAULT "HOGE"
PIYO CONSTANT VARCHAR2 NOT NULL := "PIYO"
```

## EXIT WHEN

条件を満たしたらループを抜ける。

``` sql
SET SERVEROUTPUT ON

DECLARE
  c_count NUMBER := 0;
BEGIN
  LOOP
    c_count := c_count + 1;
    DBMS_OUTPUT.PUT_LINE('c_count = ' || c_count);
    EXIT WHEN c_count = 5;
  END LOOP;
END;
/
exit;
```

## FOR LOOP

``` sql
SET SERVEROUTPUT ON
DECLARE
BEGIN
    FOR c_count IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('c_count = ' || c_count);
    END LOOP;
END;
/
exit;
```

``` txt
c_count = 1
c_count = 2
c_count = 3
c_count = 4
c_count = 5
```