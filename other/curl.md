# curl

- [curl](#curl)
  - [リクエストヘッダを付与する](#リクエストヘッダを付与する)
  - [ログイン情報を渡す](#ログイン情報を渡す)


## リクエストヘッダを付与する

``` sh
curl -H 'Content-Type:text/xml' ${接続先}
```

## ログイン情報を渡す

``` bash
curl ${user}:${token} ${url}
```
