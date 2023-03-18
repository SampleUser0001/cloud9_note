# JavaScript
- [JavaScript](#javascript)
  - [ページ読み込み時に呼び出す](#ページ読み込み時に呼び出す)
    - [参考](#参考)
  - [イベントループ](#イベントループ)
    - [イメージ](#イメージ)
    - [参考](#参考-1)
  - [配列操作](#配列操作)
    - [map](#map)
    - [filter](#filter)
    - [find](#find)
  - [import, require, export](#import-require-export)
    - [export](#export)
      - [module.exports](#moduleexports)
      - [module.exports.関数名](#moduleexports関数名)
    - [参考](#参考-2)

## ページ読み込み時に呼び出す

``` javascript
window.onload = function(){
    // ページ読み込み時に実行したい処理
}
```

### 参考

- [ページ読み込み時に実行するjavascriptについてのTips:TIPS NOTE by TAM](https://www.tam-tam.co.jp/tipsnote/javascript/post601.html)

## イベントループ

1. コールスタック
    - 関数の呼び出し順。
    - LIFO
    - JavaScriptエンジン内で実装される。
2. ヒープ
    - 動的に使用されるメモリ領域。
    - JavaScriptエンジン内で実装される。
3. タスクキュー
    - 関数の呼び出し準。
    - FIFO
    - JavaScriptエンジン内で実装される。
4. Web API
    - DOM, Event, setTimeout, Ajax等を指す。
    - ノンブロッキング（非同期）に実行される。
    - ブラウザが提供する。

### イメージ

``` javascript
while(queue.waitForMessage()){
  queue.processNextMessage();
}
```

> ```queue.waitForMessage```はもしその時点でメッセージが存在しないのであれば、同期的にメッセージが到着するのを待ちます。

### 参考

- [JavaScriptのイベントループを理解する:Qiita](https://qiita.com/hirokikondo86/items/226905890944603dba39)
- [並行モデルとイベントループ:mdn web docs](https://developer.mozilla.org/ja/docs/Web/JavaScript/EventLoop)

## 配列操作

### map

``` javascript
'use strict'

const list = [1, 2, 3, 4, 5];
console.info(list.map((v , i, array) => {
    return array[i] * 2;
}));
console.info(list);
```

``` javascript
[ 2, 4, 6, 8, 10 ]
[ 1, 2, 3, 4, 5 ]
```

### filter

``` javascript
'use strict'

const list = [1, 2, 3, 4, 5];
console.info(list.filter((v, i, array) => {
    return v % 2 == 0;
}));
console.info(list);
```

``` javascript
[ 2, 4 ]
[ 1, 2, 3, 4, 5 ]
```

### find

最初に条件に一致した要素を返す。

``` javascript 
'use strict'

const list = [1, 2, 3, 4, 5];
console.info(list.find((v, i, array) => {
    return v % 2 == 0;
}));
```

``` txt
2
```

## import, require, export

- import
    - ESM方式
    - ES6(ECMAScript)で定義されている文。
        - ECMAScript : JavaScriptの仕様。
        - ES6が動くブラウザでないと、動作しない。
- require
    - CJS(CommonJS)方式
        - CommonJS : サーバサイド等、ブラウザ外でのJavaScript仕様を決めている。

### export

- export
    - ES6構文
- module.exports
    - CJS構文
- exports
    - module.exportsのコンテキスト

#### module.exports

``` javascript
// export
// filename : sample.js
const hoge = () => {
    // pass
}

module.exports = hoge;
```

``` javascript
// require
const sample = require('./sample');
sample();
```

#### module.exports.関数名

``` javascript
// export
// filename : sample.js
const hoge = () => {
    // pass
}

module.exports.hoge = hoge;
```

``` javascript
// require
const sample = require('./sample');
sample.hoge();
```

### 参考

- [jsのimportとrequireの違い:Qiita](https://qiita.com/minato-naka/items/39ecc285d1e37226a283)
- [CommonJS:Wikipedia](https://ja.wikipedia.org/wiki/CommonJS)