# IBM Box API

- [IBM Box API](#ibm-box-api)
  - [Tokenの取得](#tokenの取得)
  - [本番の認証](#本番の認証)
    - [OAuth2 認証](#oauth2-認証)
      - [新しいアクセストークンの取得](#新しいアクセストークンの取得)
      - [Tokenが生きているか確認する](#tokenが生きているか確認する)
    - [参考](#参考)
  - [フォルダ情報](#フォルダ情報)
    - [ファイルのハッシュを取得する](#ファイルのハッシュを取得する)
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

## 本番の認証

### OAuth2 認証

プログラムを使わない。ブラウザとcurlを使う。  
アプリ作成時に、OAuth2認証を選択していること。

1. リダイレクトURLに`http://localhost`を追加する。
    - 手順は下記。
        1. アプリ -> 構成タブ -> OAuth 2.0リダイレクトURI
        2. URL入力
        3. 追加ボタンクリック
        4. 変更を保存をクリック。
    - `http://localhost`でなくても良いが、`https://app.box.com`はNG。
        - リダイレクトURLはアクセスできなくてもOK。
2. codeを取得
    1. 下記URLをブラウザで開く。
        - `https://account.box.com/api/oauth2/authorize?response_type=code&client_id=$client_id&redirect_uri=$redirect_uri`
            - client_id : 構成タブ -> OAuth 2.0資格情報 -> クライアントID
            - redirect_uri : 前の手順で登録したもの。
    2. 認証画面に遷移する。認証ボタンをクリック。
    3. `$redirect_uri`に遷移する。パラメータで`code=?????`がURL入力欄に出力されるので、これをcodeとして取得する。
        - codeの有効期限は60秒。
3. 下記実行。
    ``` bash
    # auth_code=取得したcode
    # redirect_url=設定したリダイレクトURI
    # client_id=code取得時に使用したID
    # secret_code=Box APIコンソールに記載されている。クライアントIDの下の欄。

    curl -X POST https://api.box.com/oauth2/token \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "grant_type=authorization_code" \
        -d "code=$auth_code" \
        -d "client_id=$client_id" \
        -d "client_secret=$secret_code" \
        -d "redirect_uri=$redirect_url" > access_token.json
    ```
4. アクセストークンとリフレッシュトークンの取得
    - `access_token.json`を確認。`expires_in`が有効期限（秒）。
        - 通常、アクセストークンの有効期限は3600秒。
        - リフレッシュトークンにも有効期限があるが、時間不明。
5. アクセストークンを使用して任意のAPIを実行する

#### 新しいアクセストークンの取得

``` bash
# client_id=初回取得時と同じもの
# secret_code=初回取得時と同じもの
# refresh_token=前回取得時のもの

curl -X POST https://api.box.com/oauth2/token \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "grant_type=refresh_token" \
     -d "client_id=$client_id" \
     -d "client_secret=$secret_code" \
     -d "refresh_token=$refresh_token" > access_token.json
```

#### Tokenが生きているか確認する

``` bash
# token=
curl -X GET https://api.box.com/2.0/users/me \
     -H "Authorization: Bearer $token"
```

### 参考

OAuth 2.0資格情報の認証

- [SDKを使用したOAuth 2.0:Box](https://ja.developer.box.com/guides/authentication/oauth2/with-sdk/)
    - APIを使う
- [SDKを使用しないOAuth 2.0:Box](https://ja.developer.box.com/guides/authentication/oauth2/without-sdk/)
    - プログラム言語を使う

## フォルダ情報

``` bash
curl -X GET "https://api.box.com/2.0/folders/$folder_id/items" -H "Authorization: Bearer $token"
```

### ファイルのハッシュを取得する

ファイルに対してAPIを投げれば取れるが、こちらのほうが必要な気がする。

``` bash
curl -s -X  GET "https://api.box.com/2.0/folders/$folder_id/items" -H "Authorization: Bearer $token" | jq -r '.entries[] | [.name , .sha1] | @tsv'
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