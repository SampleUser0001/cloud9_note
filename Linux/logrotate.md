# Linux logrotate

## 設定

本体は```/etc/logrotate.conf```だが、  
 ```/etc/logrotate.d/``` ディレクトリ配下に設定ファイルを置く。

``` sh
# 対象のログファイル
/var/log/sample-service/sample.log { 
    # ログファイルが空でもローテーションする
    ifempty
    # dateフォーマットを任意のものに変更する
    dateformat .%Y%m%d 
    # ログファイルがなくてもエラーを出さない
    missingok
    # 圧縮する
    compress
    # 毎日ローテートする
    daily
    # 10世代分古いログを残す
    rotate 10
    # 実行ユーザ
    su root root
    # ローテート後にsyslogを再起動
    postrotate
        /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
    endscript
}
```

※設定値は参考サイト参照。

## コマンド

動作確認

``` sh
logrotate -dv /etc/logrotate.d/${ファイル名}
``` 

実行

``` sh
logrotate /etc/logrotate.d/${ファイル名}
```

強制的にローテート

``` sh
logrotate -f /etc/logrotate.d/${ファイル名}
```

## 参考

- [Qiita:任意のログをlogrotateを使って管理する](https://qiita.com/Esfahan/items/a8058f1eb593170855a1)
- [Qiita:1777 なディレクトリのログを logrotate したときのエラー](https://qiita.com/ngyuki/items/9a0ebfdb09e3b779e4fd)