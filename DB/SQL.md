# SQL

SQLのテクニック全般

- [SQL](#sql)
  - [case-when-then](#case-when-then)
    - [実行例](#実行例)
  - [not in → not exists](#not-in--not-exists)
    - [not in](#not-in)
    - [not exists](#not-exists)
  - [外部結合](#外部結合)
    - [fromにしかないレコードも抽出する](#fromにしかないレコードも抽出する)
    - [joinにしかないレコードも抽出する](#joinにしかないレコードも抽出する)
    - [どちらでもいいから片方にあるレコードを抽出する](#どちらでもいいから片方にあるレコードを抽出する)
  - [Timestamp型 -> 秒変換する(EXTRACT)](#timestamp型---秒変換するextract)
    - [参考](#参考)
  - [便利に使える環境](#便利に使える環境)

## case-when-then

case-when-thenを使用してif文的なことを行う。  
else と endを忘れないように注意。

```sql
select case pref_name
    when '徳島' then '四国'
    when '香川' then '四国'
    when '愛媛' then '四国'
    when '高知' then '四国'
    when '福岡' then '九州'
    when '佐賀' then '九州'
    when '長崎' then '九州'
    else 'その他' end
  as district,
  SUM(population)
from PopTbl
group by case pref_name
    when '徳島' then '四国'
    when '香川' then '四国'
    when '愛媛' then '四国'
    when '高知' then '四国'
    when '福岡' then '九州'
    when '佐賀' then '九州'
    when '長崎' then '九州'
    else 'その他' end;
```

### 実行例

```SQL
mysql> select * from PopTbl;
+----+-----------+------------+
| id | pref_name | population |
+----+-----------+------------+
|  1 | 徳島      |        100 |
|  2 | 香川      |        200 |
|  3 | 愛媛      |        150 |
|  4 | 高知      |        200 |
|  5 | 佐賀      |        100 |
|  6 | 長崎      |        200 |
|  7 | 東京      |        400 |
|  8 | 群馬      |        100 |
+----+-----------+------------+
8 rows in set (0.00 sec)

mysql> 
mysql> select case pref_name
    ->     when '徳島' then '四国'
    ->     when '香川' then '四国'
    ->     when '愛媛' then '四国'
    ->     when '高知' then '四国'
    ->     when '福岡' then '九州'
    ->     when '佐賀' then '九州'
    ->     when '長崎' then '九州'
    ->     else 'その他' end
    ->   as district,
    ->   SUM(population)
    -> from PopTbl
    -> group by case pref_name
    ->     when '徳島' then '四国'
    ->     when '香川' then '四国'
    ->     when '愛媛' then '四国'
    ->     when '高知' then '四国'
    ->     when '福岡' then '九州'
    ->     when '佐賀' then '九州'
    ->     when '長崎' then '九州'
    ->     else 'その他' end;
+-----------+-----------------+
| district  | SUM(population) |
+-----------+-----------------+
| 四国      |             650 |
| 九州      |             300 |
| その他    |             500 |
+-----------+-----------------+
3 rows in set (0.00 sec)
```

## not in → not exists

### not in

```sql
select id, name
from EMP
where id not in (
  select id
  from EMP_HIST
)
```

### not exists

```sql
select id, name
from EMP e
where id not exists (
  select 'X'
  from EMP_HIST eh
  where e.id = eh.id
)
```

## 外部結合

### fromにしかないレコードも抽出する

```sql
from table1 left outer join table2 on table1.id = table2.id
where table1.value = table2.value
```

### joinにしかないレコードも抽出する

```sql
from table1 right outer join table2 on table1.id = table2.id
where table1.value = table2.value
```

### どちらでもいいから片方にあるレコードを抽出する

```sql
from table1 full outer join table2 on table1.id = table2.id
where table1.value = table2.value
```

## Timestamp型 -> 秒変換する(EXTRACT)

Oracle限定。  
EXTRACT関数を使う。  
EXTRACT関数は```EXTRACT( 要素名 from Timestamp型 )で、その要素の値が取得できる。  
日時分秒を取得して、単位の値をかける。

例)ミリ秒を取得する。

``` SQL
select extract( day from diff )*24*60*60*1000 +
       extract( hour from diff )*60*60*1000 +
       extract( minute from diff )*60*1000 +
       round(extract( second from diff )*1000 ) total_milliseconds
 from (select systimestamp - to_timestamp( '2012-07-23', 'yyyy-mm-dd' ) diff
         from dual);
```

### 参考

- [Oracleの2つのタイムスタンプの差をミリ秒単位で計算する:Code Examples](https://code-examples.net/ja/q/b146aa)

## 外部キー

### 役割

1. 存在しない値を外部キーに設定できなくなる
2. 親テーブルに存在する子テーブルの外部キーで繋がれたデータを削除できなくなる
3. 親テーブルのレコードを削除したときに外部キーで紐づいている子テーブルのレコードも削除する
    - Oracleのみ？
    - SQLiteの場合は、子テーブルの外部キー制約のカラムに一致する値が残っている場合、親テーブルのレコードを削除しようとするとエラーになる。
        - ```Runtime error: FOREIGN KEY constraint failed (19)```

### 設定時の制約

1. 外部キー制約の設定は、親テーブルのキーを網羅する必要がある。
    - SQLiteで確認。

### 参考

- [sqlite3で外部キーを有効にする:プロサバメモ](https://sym.me/page/p/26)
- [外部キーとは？〜概要から変数や処理の書き方を解説〜:SI Object Browser](https://products.sint.co.jp/siob/blog/what-is-foreign-key)

## 便利に使える環境

- [SQLite_Sample:SampleUser0001:Github](https://sampleuser0001.github.io/SQLite_Sample/)