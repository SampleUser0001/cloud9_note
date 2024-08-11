# VSCode

- [VSCode](#vscode)
  - [タブの入力](#タブの入力)
    - [参考](#参考)
  - [タブ/スペース切り替え](#タブスペース切り替え)
  - [全体を拡大or縮小表示する](#全体を拡大or縮小表示する)
  - [XML整形](#xml整形)
    - [参考](#参考-1)
  - [SQL整形](#sql整形)
  - [プラグイン](#プラグイン)
    - [Markdown PDF](#markdown-pdf)
  - [オフライン環境にプラグインをインストールする](#オフライン環境にプラグインをインストールする)
    - [参考:オフライン環境にプラグインをインストールする](#参考オフライン環境にプラグインをインストールする)
  - [markdownlint](#markdownlint)
    - [MD007](#md007)
    - [公式](#公式)

## タブの入力

設定が必要。

1. ctrl + shift + p
2. openkeyと入力し、キーボートショートカットを開く(JSON)を選択。
3. 下記を設定。
    ```json
    [
        {
        "key": "ctrl+t",
        "command": "type",
        "args": { "text": "\t" },
        "when": "editorTextFocus"
        }
        // 他の設定
    ]
    ```
4. ctrl + tでタブが入力できるようになる。

### 参考

- [コツコツと:Visual Studio Code でタブを入力する](https://kotsukotsu.work/tech/2020-10-15-visual-studio-code-%E3%81%A7%E3%82%BF%E3%83%96%E3%82%92%E5%85%A5%E5%8A%9B%E3%81%99%E3%82%8B/)

## タブ/スペース切り替え

1. ファイル -> ユーザ設定 -> 設定
2. Insert Space
3. 下記設定。
    - True : スペース
    - False : タブ

settings.json

``` json
{
    "editor.insertSpace": false
}
```

falseがスペース。

## 全体を拡大or縮小表示する

- 拡大
    - ctrl + shift + +
- 縮小
    - ctrl + -

## XML整形

```Shift``` + ```Alt``` + ```f```

### 参考

- [らくがきちょう:Visual Studio Code で整形機能を使う](https://sig9.hatenablog.com/entry/2020/01/03/000000)

## SQL整形

プラグインをインストールする。
[SQL Formatter Mod](https://marketplace.visualstudio.com/items?itemName=nmrmsys.vscode-sql-formatter-mod)

`Ctrl` + `Shift` + `P`で`Format SQL`を選ぶ。

## プラグイン

### Markdown PDF

入れておくと、PDF出力時にまっとうな見た目にしてくれる。  
Markdown All in Oneとは別に入れておく。

## オフライン環境にプラグインをインストールする

本当はこんなもんいらんのだが・・・

1. [https://marketplace.visualstudio.com/](https://marketplace.visualstudio.com/)にアクセスする。
2. インストールしたいプラグインを検索し、リンクをクリックする。
3. 「Download Extension」をクリックし、vsixファイルを取得する。
4. VSCodeで拡張機能アイコン→その他→vsixからのインストールをクリック。
5. ダウンロードしたvsixファイルを開く。

### 参考:オフライン環境にプラグインをインストールする

- [Qiita:VSCode拡張機能をオフライン環境でインストールする方法](https://qiita.com/ss_tom_jp/items/5977e4f16d78b8ca7cc8)

## markdownlint

### MD007

項目の深さのlint。TOC(Markdown All in One)とそれ以外で深さが異なるので、無効にする。

```settings.json```に下記を記載する。

``` json
    "markdownlint.config": {
        "MD007": false
    }, 
```

### 公式

- [markdownlint](https://github.com/DavidAnson/markdownlint/blob/v0.19.0/doc/Rules.md)
