# Redmine

- [Redmine](#redmine)
  - [プロジェクトの作成](#プロジェクトの作成)
    - [参考](#参考)
  - [ユーザの作成](#ユーザの作成)
    - [参考](#参考-1)
  - [ロールの作成](#ロールの作成)
  - [API](#api)
    - [前提](#前提)
    - [基本形](#基本形)
    - [プロジェクト取得](#プロジェクト取得)
    - [参考](#参考-2)

## プロジェクトの作成

トラッキングの設定が必要。

1. 管理者でログイン
2. 管理 → プロジェクト → 対象のプロジェクト → チケットトラッキングタブ
3. トラッカーにチェックを入れる
4. 保存

### 参考

- [Redmine.jp:新しいチケットが作成できない](https://redmine.jp/faq/issue/cannot-create-new-issue/)

## ユーザの作成

1. 管理者でログイン
2. 管理 → ユーザー → 新しいユーザー
3. 必須項目と任意の値を入力
4. 作成 or 連続作成

### 参考

- [Redmine.jp:ユーザーの追加](https://redmine.jp/tech_note/first-step/admin/create-user/)

## ロールの作成

プロジェクトにユーザを追加する際に、ロールとセットで登録する必要がある。

1. 管理者でログイン
2. 管理 -> ロールと権限
3. 新しいロール(右上)
4. 名称と必要な権限を設定
5. 作成ボタン押下

## API

### 前提

Redmine自体がAPIの実行を許可していること。

1. 管理者でログイン
2. 管理 -> 設定
3. APIタブ
4. 「RESTによるWebサービスを有効にする」がチェックされていること。

### 基本形

``` curl
${url}/${function}.${戻り値拡張子}?key=${api_key}
```

### プロジェクト取得

``` json
# project.jsonはkeyを設定しなくても一応取れる。
$ curl http://localhost:8081/projects.json?key=${redmine_api_key} | jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   254  100   254    0     0  37441      0 --:--:-- --:--:-- --:--:-- 42333
{
  "projects": [
    {
      "id": 1,
      "name": "SampleProject",
      "identifier": "sampleproject",
      "description": "",
      "status": 1,
      "is_public": true,
      "inherit_members": false,
      "created_on": "2024-07-16T13:37:31Z",
      "updated_on": "2024-07-16T13:37:31Z"
    }
  ],
  "total_count": 1,
  "offset": 0,
  "limit": 25
}
```

### 参考

- [Rest_api : Redmine](https://www.redmine.org/projects/redmine/wiki/Rest_api)