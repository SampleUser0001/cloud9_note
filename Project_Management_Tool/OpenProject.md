# OpenProject

- [OpenProject](#openproject)
  - [参考](#参考)
  - [オールインワンコンテナ（推奨ではない）](#オールインワンコンテナ推奨ではない)
  - [API\_KEYの払い出し](#api_keyの払い出し)
  - [API](#api)
    - [認証](#認証)

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
