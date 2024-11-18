# IBM Box API

- [IBM Box API](#ibm-box-api)
  - [Tokenの取得](#tokenの取得)
  - [フォルダ情報](#フォルダ情報)
  - [ファイルアップロード](#ファイルアップロード)

## Tokenの取得

1. Boxにログイン
2. [Box Console](https://app.box.com/developers/console)に遷移
3. カスタムアプリをクリック
4. 必要な項目を入力
    - アプリ名
    - 目的
5. 認証方法を選択して、「アプリの作成」をクリック
    - ここでは「ユーザ認証（OAuth 2.0）」を選択。
6. 開発者トークンを参照

※本番用は別途確認。

## フォルダ情報

``` bash
curl -X GET "https://api.box.com/2.0/folders/$folder_id/items" -H "Authorization: Bearer $token"
```

## ファイルアップロード

事前にアプリの設定をしておく

``` bash
curl -i -X POST "https://upload.box.com/api/2.0/files/content" \
    -H "authorization: Bearer $token" \
    -H "content-type: multipart/form-data" \
    -F "attributes={\"name\":\"$(basename "$file")\", \"parent\":{\"id\":\"$folder_id\"}}" \
    -F "file=@$file"
```