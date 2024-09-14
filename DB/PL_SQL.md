# PL/SQL

- [PL/SQL](#plsql)
  - [実行](#実行)

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

