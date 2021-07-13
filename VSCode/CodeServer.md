# Code Server

VSCodeのブラウザ版。

- [Code Server](#code-server)
  - [install](#install)
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

## 参考

- [code-server:Github](https://github.com/cdr/code-server)