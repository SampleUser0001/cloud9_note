# SQL

SQLのテクニック全般

- [SQL](#sql)
  - [case-when-then](#case-when-then)
    - [実行例](#実行例)

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