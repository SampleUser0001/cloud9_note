# Composer

PHPの標準的なパッケージ管理ツール。

- [Composer](#composer)
  - [バージョン表記](#バージョン表記)
  - [コマンド](#コマンド)
  - [依存関係の確認](#依存関係の確認)
  - [コマンド(run)](#コマンドrun)
    - [書き方](#書き方)
    - [実行](#実行)

## バージョン表記

| 表記   | 対応範囲 |
| :------| :------- |
| 2.*    | 2.0.0 <= ver < 3.0.0 |
| 2.1.*  | 2.1.0 <= ver < 3.0.0 |
| ~2.1   | 2.1.0 <= ver < 3.0.0 |
| ~2.2.3 | 2.2.3 <= ver < 3.0.0 |
| ^1.3.2 | 1.3.2 <= ver < 2.0.0 |
| ^2.0.2 | 2.0.2 <= ver < 3.0.0 |
| ^0.3.2 | 0.3.2 <= ver < 0.4.0 |

## コマンド

- ```composer install```
  - composer.lockを参照してモジュールを導入する。
  - composer.lockがない場合はcomposer.jsonを参照する。
- ```composer update```
  - composer.jsonを参照して、依存関係を考慮してインストールする。
  - パッケージの追加/削除で使用する。
- ```composer require ${パッケージ名}```
  - composer.jsonに記載し、指定したパッケージをインストールする。
- ```composer require ${パッケージ名}:"${バージョン}"```
  - 指定したパッケージを指定したバージョンでインストールする。
  - バージョンはバージョン表記項目の記載に従う。
- ```composer remove ${パッケージ名}```
  - パッケージを削除する
- ```composer require/remove --dev ${パッケージ名}```
  - dev環境用としてインストール/削除する。

## 依存関係の確認

- [Packagist](https://packagist.org)を確認する。

## コマンド(run)

### 書き方

composer.jsonに下記を記載する。

``` json
    "scripts": {
        "start": [
            "php -S localhost:8080 -t public public/index.php"
        ]
    },
```

### 実行

``` bash
composer run ${コマンド}
```
