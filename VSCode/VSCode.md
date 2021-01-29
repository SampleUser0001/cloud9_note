# VSCode

- [VSCode](#vscode)
  - [タブの入力](#タブの入力)
    - [参考](#参考)

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

