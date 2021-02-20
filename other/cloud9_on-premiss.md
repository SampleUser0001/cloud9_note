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

## 起動シェル作成

```
mkdir ${HOME}/environment
touch start.sh
chmod 755 start.sh
```

``` sh : start.sh
#/!bin/bash
node server.js -l 0.0.0.0 -p 8181 -a user:pass -w ${HOME}/environment
```

### 起動オプション

```
# すべてのホストに公開
-l 0.0.0.0
```

```
# 接続ポート
-p 8181
```

```
# ベーシック認証
-a <user>:<pass>
```

```
# デフォルトディレクトリ
-w <ディレクトリ>
```

## 起動コマンド

``` sh
cd c9sdk
sh start.sh
```

## 参考

- [Qiita:cloud9をwindowsにインストールして、幸せになる](https://qiita.com/aki-f/items/b7b45a6e6ed33ce81eb9)