# cloud9(on-premiss)

## 前提

Node.js Ver12

## インストール

``` sh
sudo apt update
sudo apt upgrade
sudo apt install gcc make
# インストール時に依存関係が足りないエラーが出た場合、都度インストールする。

git clone git://github.com/c9/core.git c9sdk
cd c9sdk
git checkout HEAD -- node_modules
scripts/install-sdk.sh
```

## サービス化する

foreverをインストールする。

``` sh
npm install -g forever
```

登録

``` sh : ${HOME}/.bashrc
# cloud9
forever start server.js -l 0.0.0.0 -p 8181 -a user:pass -w ${HOME}/environment
```

### 起動オプション

``` sh
# すべてのホストに公開
-l 0.0.0.0
```

``` sh
# 接続ポート
-p 8181
```

``` sh
# ベーシック認証
-a <user>:<pass>
```

``` sh
# デフォルトディレクトリ
-w <ディレクトリ>
```

## 参考

- [Qiita:cloud9をwindowsにインストールして、幸せになる](https://qiita.com/aki-f/items/b7b45a6e6ed33ce81eb9)
- [Qiita:Node.jsアプリをLinux環境で常駐化させる　forever編](https://qiita.com/chihiro/items/24ca8ac81cb20c22b47e)