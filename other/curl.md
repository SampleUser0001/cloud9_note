# curl

- [curl](#curl)
  - [リクエストヘッダを付与する](#リクエストヘッダを付与する)
  - [ログイン情報を渡す](#ログイン情報を渡す)
  - [進捗を非表示にする](#進捗を非表示にする)
  - [POST](#post)


## リクエストヘッダを付与する

``` sh
curl -H 'Content-Type:text/xml' ${接続先}
```

## ログイン情報を渡す

``` bash
curl ${user}:${token} ${url}
```

## 進捗を非表示にする

``` bash
curl -s ${url}
```

## POST

``` bash
curl -X POST -H "Content-Type: application/json" -d '{"key":"Person", "level":1}' http://localhost:8080/person/greet 
```