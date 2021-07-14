# Code Server

VSCodeのブラウザ版。

- [Code Server](#code-server)
  - [install](#install)
  - [拡張機能のインストール](#拡張機能のインストール)
  - [参考](#参考)

## install

1. インストール
``` sh
curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run
curl -fsSL https://code-server.dev/install.sh | sh
```

2. 設定ファイル修正
``` sh
nano  ~/.config/code-server/config.yaml
```

``` yaml
bind-addr: ${任意のIPアドレス}:${任意のポート}
```

## 拡張機能のインストール

1. https://marketplace.visualstudio.com/
2. vsixファイルをダウンロード
3. ```code-server --install-extension ${ダウンロードしたファイル}.vsix ```

## 参考

- [code-server:Github](https://github.com/cdr/code-server)