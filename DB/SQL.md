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
from テーブル1 left outer join テーブル2 on 結合条件
where その他の条件
```

### joinにしかないレコードも抽出する

```sql
from テーブル1 right outer join テーブル2 on 結合条件
where その他の条件
```

### どちらでもいいから片方にあるレコードを抽出する

```sql
from テーブル1 full outer join テーブル2 on 結合条件
where その他の条件
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