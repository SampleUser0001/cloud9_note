# OWASP ZAP

- [OWASP ZAP](#owasp-zap)
  - [前提](#前提)
  - [初期設定](#初期設定)
    - [プロキシ設定(OWASP ZAP)](#プロキシ設定owasp-zap)
    - [プロキシ設定(OS)](#プロキシ設定os)
      - [Chromebook](#chromebook)
      - [Windows10](#windows10)
  - [ツール実行 - 攻撃](#ツール実行---攻撃)
  - [実行結果のエクスポート](#実行結果のエクスポート)
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

### プロキシ設定(OS)

#### Chromebook

1. ネットワーク→接続しているネットワークを選択
2. プロキシ
3. 手動プロキシ設定
4. HTTPプロキシと保護されたHTTPプロキシにOWASP ZAPで設定した値を設定。

#### Windows10

1. スタート→設定→「プロキシ」で検索→プロキシの設定をクリック
2. 手動プロキシ セットアップで下記設定。
   - プロキシ サーバーを使う：オン
   - アドレス：localhost
     - テスト対象サーバがlocalhostの場合、接続先がlocalhostの場合もプロキシを使用するように設定する。
   - ポート：OWASPZAPで設定した値
3. 保存ボタン押下

## ツール実行 - 攻撃

1. *(重要) プロテクトモードに変更する。*
   - 左上のプルダウンメニューからプロテクトモードを選択する。
2. ブラウザでテスト対象のページにアクセスする
   - OWASP ZAPにテスト対象のURLとして取り込まれる。
     - Windows版だと取り込まれるが、Java版だと取り込まれなかった？
     - テスト対象ページすべてにアクセスする。
       - アクセスしたページがテスト対象となる。アクセスしていないページは、IP,Portが同じでもテスト対象に追加されない。
3. テスト対象ページをコンテキストに含める
   1. 対象URLを右クリック→コンテキストに含める→New Context
   2. OKボタン押下
4. テスト対象ページに攻撃する
   1. 対象URLを右クリック→攻撃→動的スキャン

## 実行結果のエクスポート

1. レポート→HTML レポート生成をクリック。

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
- 実行結果
  - [HTML5_CSS_JavaScript_Programing](https://github.com/SampleUser0001/HTML5_CSS_JavaScript_Programing)に対して実行した結果
    - [sample.json](./OWASP_ZAP/sample.json)
      - トップページのみ
    - [sample2.json](./OWASP_ZAP/sample2.json)
      - トップページ + Sample1.html ～ Sample6.html