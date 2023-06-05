# JMeter

- [JMeter](#jmeter)
  - [Basic認証以外のログイン](#basic認証以外のログイン)
    - [作成手順](#作成手順)
    - [参考ファイル](#参考ファイル)
    - [参考サイト](#参考サイト)

## Basic認証以外のログイン

Redmineにログインする。

### 作成手順

Thread groupが作成済みの前提。

1. HTTPクッキーマネージャを作成
2. ユーザ定義変数を作成
   - user : ログインユーザ
   - password : ログインパスワード
3. 一度だけ実行されるコントローラを作成
   1. HTTPリクエストでログイン画面をGETする。
      1. 正規表現抽出を作成する。
         - 参照名：authenticity_token
         - 正規表現：```<input type="hidden" name="authenticity_token" value="(.*)" />```
         - テンプレート：```$1$```
   2. HTTPリクエストで認証情報をPOSTする。
      1. 下記の値を設定。

        | 名前 | 値 | URL_Encode? | Content-Type | 統合含む? |
        | :-- | :-- | :--: | :-- | :--: |
        | authenticity_token | ${authenticity_token} | on | text/plain | on |
        | username | ${user} | on | text/plain | on |
        | password | ${password} | on | text/plain | on |
        | login | ログイン | on | text/plain | on |

### 参考ファイル

[Redmine_FileDownload.jmx](./Redmine_FileDownload.jmx)

### 参考サイト

- [DATABASE SQL DEV:JMeterで認証が必要なシステムにログインする方法](http://ichannel.tokyo/technoracle/jmeter%E3%81%A7%E8%AA%8D%E8%A8%BC%E3%81%8C%E5%BF%85%E8%A6%81%E3%81%AA%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%81%AB%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95/4555/#%E3%83%96%E3%83%A9%E3%82%A6%E3%82%B6%E3%81%A7%E6%93%8D%E4%BD%9C%E3%81%97%E3%81%9F%E5%A0%B4%E5%90%88%E3%81%AE%E3%82%A4%E3%83%A1%E3%83%BC%E3%82%B8)