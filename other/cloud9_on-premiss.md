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

``` sh 
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

## Xubuntuでログイン時に起動する

forever使ったり、スタートアップに起動シェルを登録したりすればいいはずなのだが、何故かうまく動かなかったので別解。  
GUI＋自動ログイン前提。

1. 起動sh作成。

    ``` sh
    . ~/.nvm/nvm.sh
    nvm use v12.20.1
    
    cd /home/satorutanaka/c9sdk 
    node server.js -l 0.0.0.0 -p 8181 -a user:pass -w /home/satorutanaka/environment 1> /dev/null 2> /dev/null &
    ```

2. ${HOME}/.bashrcに上記のshを実行するように追記。
3. Terminalの起動をスタートアップに登録する。
    1. ターミナル起動アイコンを右クリック -> 起動コマンド確認
    2. 設定マネージャー -> セッションと起動 -> 自動開始アプリケーション から、1で確認したコマンドを登録。

## 参考

- [cloud9をwindowsにインストールして、幸せになる:Qiita](https://qiita.com/aki-f/items/b7b45a6e6ed33ce81eb9)
- [Node.jsアプリをLinux環境で常駐化させる　forever編:Qiita](https://qiita.com/chihiro/items/24ca8ac81cb20c22b47e)
- [xubuntuのスタートアップにアプリを追加:気まま・お気楽日記](http://kimamaokiraku.jugem.jp/?eid=723)