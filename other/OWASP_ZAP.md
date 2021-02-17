# OWASP ZAP

## 前提

- 別名設定済み。  
  - [リンク](../Cloud9_init_note.md)
- 画面から実行すること。

## 実行例



## コマンドライン実行例

実行できる事自体は確認しているが、プロテクトモードで起動しているかわからないため、封印。

``` sh
mkdir owaspzap_report
owaspzap -daemon -quickurl http://192.168.1.34:8080/ -quickout ./owaspzap_report/zap_out.xml
```

## 参考

- [Qiita:OWASP ZAP CLI 入門(インストール、起動方法、基本的なオプション)](https://qiita.com/zackey2/items/b10ae87c0844eed8ef81)
- [ZAP:Command Line](https://www.zaproxy.org/docs/desktop/cmdline/)
  - コマンドラインの一覧
- [「」:CentOS7: OWASP ZAP: コマンドライン](https://ameblo.jp/consa-spo/entry-12568024183.html)
  - コマンドラインで実行する方法