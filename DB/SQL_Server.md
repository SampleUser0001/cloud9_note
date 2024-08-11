# Microsoft SQL Server

- [Microsoft SQL Server](#microsoft-sql-server)
  - [認証](#認証)
  - [テーブル定義取得](#テーブル定義取得)
    - [参考](#参考)

## 認証

| 項目 | 値 |
| :--- | :--- |
| Server type | Database Engine |
| Server Name | サーバ名/？？？ |
| 認証方法 | SQL Server Authentication |

？？？はインスタンス名 or ポート番号。
下記のどちらか

- インスタンス名
- インスタンス名,ポート番号

## テーブル定義取得

``` sql
DECLARE @TABLENAME NVARCHAR(50)
SET @TABLENAME = 'テーブル名' --テーブル名を指定してください。

SELECT c.column_id AS ID
    ,t.name AS テーブル名
    ,t.type AS タイプ
    ,c.name AS 列名
    ,n.name AS データ型
    ,c.max_length AS 桁数
    ,c.scale AS 小数点桁数
    ,c.is_nullable AS 'NULL可否'
    ,t.create_date AS 作成日
    ,t.modify_date AS 更新日
    FROM sys.objects t
inner join sys.columns c on t.object_id = c.object_id
inner join sys.types n on c.system_type_id = n.system_type_id
where t.type = 'U' AND t.name = @TABLENAME
order by t.name, c.column_id;
```

### 参考

- [SQL serverでのテーブル定義をクエリで調べる:Qiita](https://qiita.com/mikaka360/items/4bc02612942b5a441695)