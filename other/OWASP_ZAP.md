# OWASP ZAP

## 前提

- 別名設定済み。  
  - [リンク](../Cloud9_init_note.md)
- 画面から実行すること。

## 初期設定

### プロキシ設定(OWASP ZAP)

1. ツール→オプション
2. ローカル・プロキシ
3. Address, ポートに任意の値を設定。
4. OKボタン押下

### プロキシ設定(chromebook)

1. ネットワーク→接続しているネットワークを選択
2. プロキシ
3. 手動プロキシ設定
4. HTTPプロキシと保護されたHTTPプロキシにOWASP ZAPで設定した値を設定。

### OWASP ZAP

1. *(重要) プロテクトモードに変更する。*

## コマンドライン実行例

実行できる事自体は確認しているが、プロテクトモードで起動しているかわからないため、封印。

``` sh
mkdir owaspzap_report
owaspzap -daemon -quickurl http://192.168.1.34:8080/ -quickout ./owaspzap_report/zap_out.xml
```

## 参考

- [Qiita:OWASP ZAPの設定と使い方](https://qiita.com/sangi/items/ba7e3d39237045c9be36)
- [Qiita:OWASP ZAP CLI 入門(インストール、起動方法、基本的なオプション)](https://qiita.com/zackey2/items/b10ae87c0844eed8ef81)
- [ZAP:Command Line](https://www.zaproxy.org/docs/desktop/cmdline/)
  - コマンドラインの一覧
- [「」:CentOS7: OWASP ZAP: コマンドライン](https://ameblo.jp/consa-spo/entry-12568024183.html)
  - コマンドラインで実行する方法
