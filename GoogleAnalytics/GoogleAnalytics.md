# GoogleAnalytics

- [GoogleAnalytics](#googleanalytics)
  - [導入](#導入)
    - [アカウントの取得](#アカウントの取得)
    - [gtag.jsの生成](#gtagjsの生成)
    - [gtag.jsの取得](#gtagjsの取得)
  - [任意のイベントを取得できるようにする](#任意のイベントを取得できるようにする)
    - [実装例：任意のイベントを取得できるようにする](#実装例任意のイベントを取得できるようにする)
  - [gtag.jsを別ファイルにする](#gtagjsを別ファイルにする)
    - [別ファイル(ga.js)](#別ファイルgajs)
    - [呼び出し側](#呼び出し側)

## 導入

アカウントの取得からgtag.jsの生成までを記載する。  

### アカウントの取得
1. 下記ページに遷移
   - [https://analytics.google.com/analytics/web/provision/#/provision](https://analytics.google.com/analytics/web/provision/#/provision)
2. 「無料で設定」ボタンをクリックする。
3. アカウントの設定を行う。
   1. 任意の「アカウント名」を入力する。
   2. 画面下部の「次へ」をクリックする。
4. プロパティの設定を行う。
   1. 「プロパティ名」（アプリ名を入力すると扱いやすい）を入力する。
   2. 「レポートのタイムゾーン」を「日本」に変更する。
   3. 「通貨」を「日本円」に変更する。
   4. 「次へ」をクリックする。
5. ビジネスの概要を入力する。
   1. 「業種」をアプリの用途に応じて選択する。
   2. 「ビジネスの規模」を事業規模に応じて選択する。
   3. 「利用目的」を選択する。
        - 「その他」を選択する場合は、その内容も入力する。
   4. 「作成」ボタンをクリックする。
6. 「Google アナリティクス利用規約」画面
    1. プルダウンから「日本」を選択する。
    2. 「GDPR で必須となるデータ処理規約にも同意します。」にチェックする。
    3. 「私は Google と共有するデータについて、「測定管理者間のデータ保護条項」に同意します。」をチェックする。
    4. 「同意する」ボタンをクリックする。

### gtag.jsの生成

1. データストリーム 設定画面に遷移する。
   - (アカウントの取得を行った場合は、既にこの画面に遷移しているため、操作不要。）
   1. （左側のメニューから）管理メニューをクリックする。
   2. （右のプロパティ一覧から）プロパティプルダウンを選択する。
   3. 設定するプロパティをクリックする。
   4. 「データストリーム」をクリックする。
2. データストリームを作成する。
   1. 「ウェブ」ボタンをクリックする。
   2. ウェブサイトのURLとストリーム名を入力する。
      - ストリーム名は任意の値を設定する。
   3. 「ストリームを作成」ボタンをクリックする。

### gtag.jsの取得

1. 「ウェブ ストリームの詳細」画面の「グローバル サイトタグ（gtag.js）」をクリックする。
2. 表示されたコードを、測定対象のすべてのページの```<head>```の先頭に貼り付ける。 

## 任意のイベントを取得できるようにする

```
gtag('event', <任意のイベント名>, {'event_category': '<任意のカテゴリ名>', 'event_label': '<任意のラベル>'})
```

### 実装例：任意のイベントを取得できるようにする

下記は「aタグがクリックされたことを取得する」例。
```
    <a href="./02_testPage.html"
        onClick="gtag('event', 'click', {'event_category': 'Video', 'event_label': 'video_not_complete'});">
        次のページ
    </a>
```

## gtag.jsを別ファイルにする

### 別ファイル(ga.js)

仮にファイル名をga.jsとする
```javascript:ga.js
document.write('<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>');
window.dataLayer = window.dataLayer || [];
function gtag(){
  dataLayer.push(arguments);
}
gtag('js', new Date());gtag('config', 'G-XXXXXXXXXX');

```
G-XXXXXXXXXXは[gtag.jsの取得](#gtag.jsの取得)で確認できるウェブストリームの値を設定する。

### 呼び出し側

```html
<head>
   <script type="text/javascript" src="./ga.js"></script>
</head>
```