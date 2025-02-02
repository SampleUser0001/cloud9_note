# PL/SQL

- [PL/SQL](#plsql)
  - [実行](#実行)
  - [PL/SQLファイルをsqlplusの引数として渡す](#plsqlファイルをsqlplusの引数として渡す)
  - [%TYPE](#type)
  - [%ROWTYPE](#rowtype)
  - [定数](#定数)
  - [標準出力](#標準出力)
  - [EXIT WHEN](#exit-when)
  - [LOOP](#loop)
    - [FOR LOOP](#for-loop)
  - [分岐](#分岐)
    - [IF](#if)
    - [CASE](#case)
  - [SELECT INTO](#select-into)
  - [カーソル](#カーソル)
  - [カーソル FOR ループ](#カーソル-for-ループ)
  - [パラメータ付きカーソル](#パラメータ付きカーソル)
  - [FOR UPDATE](#for-update)
  - [WHERE CURRENT OF](#where-current-of)
    - [修正前](#修正前)
    - [修正後](#修正後)
  - [カーソルの種類](#カーソルの種類)
    - [明示カーソル](#明示カーソル)
    - [暗黙カーソル](#暗黙カーソル)
  - [Exception](#exception)
    - [RAISE](#raise)
    - [RAISE\_APPLICATION\_ERROR](#raise_application_error)
    - [others](#others)
    - [PRAGMA](#pragma)
  - [ストアド・サブプログラム](#ストアドサブプログラム)
    - [構文](#構文)
      - [Function](#function)
    - [実行](#実行-1)
    - [Execute権限付与](#execute権限付与)
    - [実装の確認](#実装の確認)
  - [エラーの表示](#エラーの表示)
    - [SHOW ERRORS](#show-errors)
    - [USER ERRORS ビュー](#user-errors-ビュー)
  - [INSERT SELECT](#insert-select)

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

## 標準出力

``` sql
SET SERVEROUTPUT ON

DBMS_OUTPUT.PUTLINE("文字列")
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

## LOOP

``` sql
LOOP
   EXIT WHEN 条件
END LOOP
```

### FOR LOOP

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

## 分岐

### IF

``` sql
IF THEN

ELSIF

ELSE

END IF
```

### CASE

``` sql
CASE value
    WHEN 10 THEN

    ELSE

END CASE
```

## SELECT INTO

`SELECT`の結果は必ず1件でなければならない。

``` sql
SELECT
    カラム名
INTO
    変数名
FROM (通常のSQL)
```

## カーソル

``` sql
DECLARE
    CURSOR a IS (SELECT文)
    b a%ROWTYPE;
BEGIN
    OPEN a;
        LOOP
            FETCH a INTO b
            EXIT WHEN a%NOTFOUND;
                bを使った処理
        END LOOP
    CLOSE a;
END;
/
```

## カーソル FOR ループ

``` sql
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, first_name, last_name
        FROM employees
        WHERE department_id = 10;
BEGIN
    FOR emp_record IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_record.employee_id || ', Name: ' || emp_record.first_name || ' ' || emp_record.last_name);
    END LOOP;
END;
/
```

## パラメータ付きカーソル

``` sql
DECLARE
  CURSOR emp_cur(d_no NUMBER) IS SELECT empno,ename FROM emp
                                         WHERE deptno = d_no;
  d_var  NUMBER;
BEGIN
  -- 標準入力から値を取る。
  d_var := &DEPTNO;
  
  -- 引数を取れるカーソル。
  FOR emp_rec IN emp_cur(d_var) LOOP
    DBMS_OUTPUT.PUT_LINE(emp_rec.empno||' '||emp_rec.ename);
  END LOOP;
END;
/
```

## FOR UPDATE

``` sql
DECLARE
  CURSOR emp_cur IS
    SELECT (略) FOR UPDATE;
  -- 該当行をロックする。通常、Selectはロックされないが、Selectでもロックする。

FOR UPDATE
  OF <列名>
  [NOWAIT | WAIT n]
  -- NOWAIT : ロックされていたら即エラー
  -- WAIT n : ロックされていたらn秒待つ
```

## WHERE CURRENT OF

### 修正前

``` sql
DECLARE
    CURSOR emp_cur IS SELECT sal, empno FROM emp WHERE deptno = 10;
BEGIN
    FOR emp_rec IN emp_cur LOOP
        IF emp_rec.sal < 2500 THEN
            UPDATE emp SET sal = sal + 100 WHERE empno = emp_rec.empno;
        END IF;
    END LOOP;
END
/
```

### 修正後

``` sql
DECLARE
    CURSOR emp_cur IS SELECT sal, empno FROM emp WHERE deptno = 10 FOR UPDATE;
BEGIN
    FOR emp_rec IN emp_cur LOOP
        IF emp_rec.sal < 2500 THEN
            UPDATE emp SET sal = sal + 100 WHERE CURRENT OF emp_cur;
        END IF;
    END LOOP;
END
/
```

## カーソルの種類

- 明示カーソル
    - 明示的にオープン/クローズする
- 暗黙カーソル
    - SQL内部で使用される。

### 明示カーソル

``` sql
DECLARE
    CURSOR emp_cur -- 省略
```

- `emp_cur%NOTFOUND`
    - 直前で取れなかったら、TRUE。
- `emp_cur%FOUND`
    - NOTFOUNDの逆
- `emp_cur%ROWCOUNT`
    - これまでに取り出された件数
- `emp_cur%ISOPEN`
    - OPENだったらTRUE。

### 暗黙カーソル

``` sql
BEGIN
    DELETE ...
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT)
END;
/
```

- `emp_cur%NOTFOUND`
    - 処理される行がない時、TRUE。
- `emp_cur%FOUND`
    - NOTFOUNDの逆
- `emp_cur%ROWCOUNT`
    - これまでに取り出された件数
- `emp_cur%ISOPEN`
    - OPENだったらTRUE。

## Exception

`others`が例外名。  
[例外名一覧](https://www.ibm.com/docs/ja/db2/11.5?topic=plsql-exception-handling)

Exceptionのあり/なしで挙動が異なる。

- Exceptionあり
    - トランザクション継続
- Exceptionなし
    - ロールバックされる

[実装例](https://main.d1er9p57pxkuki.amplifyapp.com/src/PLSQL/Professional_introduction_to_Oracle_PLSQL.html#list05-02sql)

### RAISE

[実装例](https://main.d1er9p57pxkuki.amplifyapp.com/src/PLSQL/Professional_introduction_to_Oracle_PLSQL.html#list05-05sql)

### RAISE_APPLICATION_ERROR

通常のExceptionはメッセージが固定だが、任意のORA-エラーコードを発生できる。
エラーコードは-20000〜-20999の間。  
メッセージは2048バイト以内。

[実装例](https://main.d1er9p57pxkuki.amplifyapp.com/src/PLSQL/Professional_introduction_to_Oracle_PLSQL.html#list05-06sql)

### others

othersは複数の例外を受けられるが、そのままだと何が発生したかわからない。  
コードとメッセージを取得する方法がある。

- `sqlcode`
    - エラー番号
- `sqlerrm`
    - エラーメッセージ

[実装例](https://main.d1er9p57pxkuki.amplifyapp.com/src/PLSQL/Professional_introduction_to_Oracle_PLSQL.html#list05-08sql)

### PRAGMA

無名の内部例外。  
Oracleで定義されていない例外に名前をつけて、個別処理できるようにする。  

実装例ではLOOP中にcommitされることで、cursor_err -> ORA-1002が発生する。

[実装例](https://main.d1er9p57pxkuki.amplifyapp.com/src/PLSQL/Professional_introduction_to_Oracle_PLSQL.html#list05-04sql)

## ストアド・サブプログラム

``` txt
無名ブロックとは異なり、PL/SQLサブプログラム(プロシージャおよびファンクション)は、別々にコンパイルしてOracleデータベースに格納し、起動できます。
```

[Oracle® Database Oracleプリコンパイラのためのプログラマーズ・ガイド 12c リリース1 (12.1) - ストアド・サブプログラム](https://docs.oracle.com/cd/E57425_01/121/ZZPRE/GUID-5840297F-2757-465C-8B1D-8C6DFFBBFA20.htm)

### 構文

``` sql
CREATE {FUNCTION | PROCEDURE | PACKAGE} out_put
IS
BEGIN
    (出力)
END;
/
```

#### Function

SQLの中から呼ぶことができるが、下記の制限がある。

- Selectのみ
- 引数から値を返すような実装はNG。
- SQLがサポートしていない型は使えない

### 実行

``` sql
BEGIN
    out_put
END;
/
```

### Execute権限付与

``` sql
GRANT EXECUTE ON out_put TO user1;
```

### 実装の確認

``` sql
SELECT text FROM user_source WHERE user = 'OUT_PUT';
```

- where
    - name : オブジェクト名
    - type : オブジェクト型
    - line : 行番号
    - text : ソースコード

データディクショナリに登録される。

## エラーの表示

### SHOW ERRORS

``` sql
SHOW ERRORS procedure out_put
```

### USER ERRORS ビュー

``` sql
select line, text 
from user_errors 
where name = 'OUT_PUT';
```

## INSERT SELECT

VALUESは不要。

``` sql
INSERT INTO テーブル名 (
    カラム1, カラム2
) 
SELECT カラム1, カラム2 FROM テーブル名 WHERE 条件
```

