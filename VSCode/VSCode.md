# VSCode

- [VSCode](#vscode)
  - [タブの入力](#タブの入力)
    - [参考](#参考)
  - [XML整形](#xml整形)
    - [参考](#参考-1)
  - [オフライン環境にプラグインをインストールする](#オフライン環境にプラグインをインストールする)
    - [参考:オフライン環境にプラグインをインストールする](#参考オフライン環境にプラグインをインストールする)

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

## XML整形

```Shift``` + ```Alt``` + ```f```

### 参考

- [らくがきちょう:Visual Studio Code で整形機能を使う](https://sig9.hatenablog.com/entry/2020/01/03/000000)

## オフライン環境にプラグインをインストールする

本当はこんなもんいらんのだが・・・

1. [https://marketplace.visualstudio.com/](https://marketplace.visualstudio.com/)にアクセスする。
2. インストールしたいプラグインを検索し、リンクをクリックする。
3. 「Download Extension」をクリックし、vsixファイルを取得する。
4. VSCodeで拡張機能アイコン→その他→vsixからのインストールをクリック。
5. ダウンロードしたvsixファイルを開く。

### 参考:オフライン環境にプラグインをインストールする

- [Qiita:VSCode拡張機能をオフライン環境でインストールする方法](https://qiita.com/ss_tom_jp/items/5977e4f16d78b8ca7cc8)