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
    - [どちらかにしかないレコードをorder byで使う](#どちらかにしかないレコードをorder-byで使う)
  - [Timestamp型 -\> 秒変換する(EXTRACT)](#timestamp型---秒変換するextract)
    - [参考](#参考)
  - [外部キー](#外部キー)
    - [役割](#役割)
    - [設定時の制約](#設定時の制約)
    - [参考](#参考-1)
  - [OVER](#over)
    - [例](#例)
    - [PARTITION BY](#partition-by)
    - [ORDER BY](#order-by)
      - [例1](#例1)
      - [例2](#例2)
    - [参考](#参考-2)
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

### どちらかにしかないレコードをorder byで使う

- [left_outer_join_order_by](https://github.com/SampleUser0001/left_outer_join_order_by)

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

## OVER

`COUNT()`などの集合関数の結果を他の行に展開する。

``` sql
sqlite> select * from test_orders;
1001|Apple|4|2018-1-10
1005|Banana|8|2018-1-20
1010|Banana|2|2018-2-1
1021|Apple|10|2018-2-15
1025|Apple|6|2018-2-22
1026|Apple|5|2018-2-23

```

### 例

``` sql
sqlite> SELECT order_id, item, COUNT(*) OVER () FROM test_orders;
1001|Apple|6
1005|Banana|6
1010|Banana|6
1021|Apple|6
1025|Apple|6
1026|Apple|6

```

### PARTITION BY

区切り位置を変える。  
count(*)の単位が全体の行数ではなく、itemの行数になる。

``` sql
sqlite> SELECT order_id, item, COUNT(*) OVER (PARTITION BY item) FROM test_orders ORDER BY order_id;
1001|Apple|4
1005|Banana|2
1010|Banana|2
1021|Apple|4
1025|Apple|4
1026|Apple|4

```

### ORDER BY

行番号を振り直す。

#### 例1

``` sql
sqlite> select order_id, item, count(*) over (order by order_id) from test_orders;
1001|Apple|1
1005|Banana|2
1010|Banana|3
1021|Apple|4
1025|Apple|5
1026|Apple|6
```

#### 例2

``` sql
sqlite> select order_id, item, qty, sum(qty) over (order by order_id) from test_orders;
1001|Apple|4|4
1005|Banana|8|12
1010|Banana|2|14
1021|Apple|10|24
1025|Apple|6|30
1026|Apple|5|35
```

### 参考

[分析関数（ウインドウ関数）をわかりやすく説明してみた:Qiita](https://qiita.com/tlokweng/items/fc13dc30cc1aa28231c5)

## 便利に使える環境

- [SQLite_Sample:SampleUser0001:Github](https://sampleuser0001.github.io/SQLite_Sample/)