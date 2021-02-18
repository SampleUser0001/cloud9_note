# OWASP ZAP

- [OWASP ZAP](#owasp-zap)
  - [前提](#前提)
  - [初期設定](#初期設定)
    - [プロキシ設定(OWASP ZAP)](#プロキシ設定owasp-zap)
    - [プロキシ設定(chromebook)](#プロキシ設定chromebook)
    - [OWASP ZAP](#owasp-zap-1)
  - [コマンドライン実行例](#コマンドライン実行例)
  - [参考](#参考)

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
2. ブラウザでテスト対象のページにアクセスする
   - 本来、この時点でOWASP ZAPにテスト対象のURLとして取り込まれるはずだが、反応しない。

## コマンドライン実行例

OWASP ZAPの画面で設定した項目の影響を受ける。（プロテクトモードに設定していればプロテクトモードで実行されるが、テスト対象外のURLに接続しようとすると怒られる。）

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
- [Web Application Security Memo:OWASP ZAP スキャンポリシーの検査項目一覧(Release版)](https://www.pupha.net/archives/2106/)
  - OWASP ZAPのチェック項目一覧。
- [OWASP ZAP:Documentation](https://www.zaproxy.org/docs/)
  - 公式ドキュメント1
