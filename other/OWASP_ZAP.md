# OWASP ZAP

- [OWASP ZAP](#owasp-zap)
  - [前提](#前提)
  - [初期設定](#初期設定)
    - [プロキシ設定(OWASP ZAP)](#プロキシ設定owasp-zap)
    - [プロキシ設定(OS)](#プロキシ設定os)
      - [Chromebook](#chromebook)
      - [Windows10](#windows10)
      - [Ubuntu](#ubuntu)
    - [証明書(CA)](#証明書ca)
      - [Firefoxの場合](#firefoxの場合)
  - [対象URLの指定](#対象urlの指定)
    - [意図していないURLが出現した場合](#意図していないurlが出現した場合)
  - [ツール実行 - 攻撃](#ツール実行---攻撃)
  - [実行結果のエクスポート](#実行結果のエクスポート)
  - [コマンドライン実行例](#コマンドライン実行例)
  - [参考](#参考)
  - [外部送信の脆弱性一覧](#外部送信の脆弱性一覧)

## 前提

- 別名設定済み。  
  - [リンク](../Cloud9_init_note.md)
- 画面から実行すること。

## 初期設定

### プロキシ設定(OWASP ZAP)

OWASP ZAP側はデフォルトで`127.0.0.1:8080`が設定されている。

1. ツール→オプション
2. ローカル・プロキシ
3. Address, ポートに任意の値を設定。
4. OKボタン押下

### プロキシ設定(OS)

使用するブラウザによる。
- Chrome, edge
    - OSの設定を参照するので、ここに書かれている設定が必要。  
- Firefox
    - ブラウザ単体で設定できる。
- ZAP内蔵ブラウザ
    - 設定不要。
    - ZAP上部メニュー：「Quick Start」 -> 「Launch Browser」

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

#### Ubuntu

1. 設定 -> ネットワーク -> ネットワークプロキシ
2. HTTPプロキシ、HTTPSプロキシを設定する。
    - OWASP ZAPで設定した値

### 証明書(CA)

HTTPS通信を行うために使用する。  
Firefoxはブラウザに、Chrome、edgeはOSに設定する。

#### Firefoxの場合

1. ZAP
    - Tools → Options → Network → Server Certificates
    - 「Save」または「Generate」
2. Firefox
    - 設定 → プライバシーとセキュリティ → 証明書
    - 認証局 → インポート
    - 「この認証局を信頼する（Webサイトを識別）」

## 対象URLの指定

1. 表示 -> タブを表示 -> クイックスタート タブ
2. 手動検索
3. 対象のURLを入力 -> ブラウザ起動
4. 左ペインの「サイト」に取り込まれたことを確認
5. テスト対象の操作を行う

### 意図していないURLが出現した場合

1. テスト対象のURLを右クリック -> コンテキストに含める -> 規定コンテキスト
2. テスト対象ではないURLを選択して右クリック -> 削除

## ツール実行 - 攻撃

1. *(重要) プロテクトモードに変更する。*
   - 左上のプルダウンメニューからプロテクトモードを選択する。
2. ブラウザでテスト対象のページにアクセスする
    - OWASP ZAPにテスト対象のURLとして取り込まれる。
        - Windows版だと取り込まれるが、Java版だと取り込まれなかった？
        - テスト対象ページすべてにアクセスする。
            - アクセスしたページがテスト対象となる。アクセスしていないページは、IP,Portが同じでもテスト対象に追加されない。
        - localhostではなく、プライベートIPでアクセスする。 
3. テスト対象ページをコンテキストに含める
   1. 対象URLを右クリック→コンテキストに含める→New Context
   2. OKボタン押下
4. テスト対象ページに攻撃する
   1. 対象URLを右クリック→攻撃→アクティブスキャン

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

## 外部送信の脆弱性一覧

ChatGPT 3.5の回答。

OWASP ZAPはさまざまなセキュリティアラートを検出できますが、具体的なアラートのリストはOWASP ZAPのバージョンや設定によって異なります。以下は一般的な外部送信に関連するアラートの一例です。これは一般的な項目であり、特定のアプリケーションによっては異なる可能性があります。

1. **外部ドメインへのデータ送信 (External Link):**
   - アプリケーションが外部ドメインにデータを送信する際に、その操作が検出されます。

2. **サードパーティのAPI呼び出し (Third Party Interaction):**
   - アプリケーションがサードパーティのAPIを呼び出している場合に検出されます。

3. **不正なデータ送信 (Data Exfiltration):**
   - アプリケーションがユーザーの個人情報や機密データを外部に送信しようとしている場合に検出されます。

4. **クロスサイトリクエストフォージェリ (CSRF):**
   - CSRF攻撃の可能性がある場合、外部ドメインに対するリクエストが検出されます。

5. **不正なフォーム操作 (Illegal Form Key Submission):**
   - フォームキーが不正に送信される場合に検出されます。

6. **外部スクリプトの使用 (External JavaScript):**
   - アプリケーションが外部からJavaScriptを読み込んでいる場合に検出されます。

7. **クロスサイトスクリプティング (XSS):**
   - XSS脆弱性が検出されると、外部にデータが送信される可能性があるため、これも注意が必要です。

8. **不正なリダイレクト (Open Redirect):**
   - 不正なリダイレクトが検出されると、外部のURLにユーザーが誘導される可能性があります。

これらのアラートはあくまで一般的なものであり、実際のアプリケーションによっては異なる可能性があります。OWASP ZAPのドキュメントやアプリケーションのコンテキストに基づいて設定を調整し、特定のアラートに焦点を当てることが重要です。

