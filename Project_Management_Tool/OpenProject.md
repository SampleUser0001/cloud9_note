# OpenProject

- [OpenProject](#openproject)
  - [参考](#参考)
  - [オールインワンコンテナ（推奨ではない）](#オールインワンコンテナ推奨ではない)
  - [API\_KEYの払い出し](#api_keyの払い出し)
  - [API](#api)
    - [認証](#認証)
    - [タスクの登録](#タスクの登録)
    - [API一覧](#api一覧)

## 参考

- [Docker を使用して OpenProject をインストールする:OpenProject](https://www.openproject.org/docs/installation-and-operations/installation/docker/)

## オールインワンコンテナ（推奨ではない）

- `OPENPROJECT_SECRET_KEY_BASE`は任意の乱数。
- デフォルトのログインIDは下記。
    - admin:admin

``` yml
version: '3'
services:
    openproject:
        image: openproject/community:13
        container_name: openproject
        ports: 
            - "8080:80"
    environment:
        OPENPROJECT_SECRET_KEY_BASE: 'secret'
        OPENPROJECT_HOST__NAME: 'localhost:8080'
        OPENPROJECT_HTTPS: 'false'
        OPENPROJECT_DEFAULT__LANGUAGE: 'ja'
```

## API_KEYの払い出し

ユーザアイコン(右上) -> 個人設定 -> Access Tokens -> API Tokenをクリック。

## API

### 認証

``` bash
curl -u apikey:${OpenProject_API_KEY} ${API}
```

### タスクの登録

``` python
import requests
import json

# APIエンドポイント
url = "http://localhost:8080/api/v3/work_packages"

# ヘッダー情報
headers = {
    "Content-Type": "application/json"
}

# 生成したAPI_KEY
API_KEY='hogehoge'
auth = ('apikey' , API_KEY)

# タスクの詳細
task = {
    "subject": "新しいタスク",
    "description": {
        "raw": "タスクの詳細"
    },
    "_links": {
        "project": {
            "href": "/api/v3/projects/3"
        },
        "type": {
            "href": "/api/v3/types/1"
        }
    }
}

# リクエストの送信
response = requests.post(url, headers=headers, data=json.dumps(task), auth=auth)

# レスポンスの表示
print(response.json())

```

### API一覧

- [API Endpoints : OpenProject](https://www.openproject.org/docs/api/endpoints/)
