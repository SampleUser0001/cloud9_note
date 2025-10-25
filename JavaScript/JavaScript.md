# JavaScript
- [JavaScript](#javascript)
  - [ページ読み込み時に呼び出す](#ページ読み込み時に呼び出す)
    - [参考](#参考)
  - [変更が発生したときに呼び出す](#変更が発生したときに呼び出す)
  - [イベントループ](#イベントループ)
    - [イメージ](#イメージ)
    - [参考](#参考-1)
  - [配列操作](#配列操作)
    - [map](#map)
    - [filter](#filter)
    - [find](#find)
  - [slice](#slice)
  - [import, require, export](#import-require-export)
    - [export](#export)
      - [module.exports](#moduleexports)
      - [module.exports.関数名](#moduleexports関数名)
    - [参考](#参考-2)
  - [Mapオブジェクト](#mapオブジェクト)
  - [ブラウザでファイルを読み込む](#ブラウザでファイルを読み込む)
    - [前提](#前提)
    - [HTML](#html)
    - [JavaScript](#javascript-1)
    - [コールバックで共通化する](#コールバックで共通化する)
  - [JSON - Base64変換](#json---base64変換)
  - [サブウィンドウ](#サブウィンドウ)

## ページ読み込み時に呼び出す

``` javascript
window.onload = function(){
    // ページ読み込み時に実行したい処理
}
```

### 参考

- [ページ読み込み時に実行するjavascriptについてのTips:TIPS NOTE by TAM](https://www.tam-tam.co.jp/tipsnote/javascript/post601.html)

## 変更が発生したときに呼び出す

``` html
<input type="text" name="main_pull_request_url" id="id_main_pull_request_url" oninput="updateInputState()"/>
```

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

## slice

部分配列を返す

- [Array slice : mozila](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Array/slice)

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

## Mapオブジェクト

Javaとだいたい同じだが、forの書き方が違う。

``` javascript
// なにかMapオブジェクトを返す関数。
const map = getMap();

// map.entries()でも、mapでも同様。
for (const [key, value] of map.entries()) {
    console.log(`${key}: ${value}`);
}
```

## ブラウザでファイルを読み込む

### 前提

自動読み込みはできない。必ずユーザ操作が必要。

### HTML

``` html
<input type="file" id="job_list_load" />
<button id="job_list_load_button" onclick="load()">Load</button>
```

### JavaScript

``` javascript
let jobList = [];
function load() {
    const input = document.getElementById('job_list_load');
    const filepath = input.files[0];
    console.info("filepath: ", filepath);
    if (filepath) {
        const reader = new FileReader();
        reader.onload = function(e) {
            try {
                jobList = JSON.parse(e.target.result);
                console.info(jobList);
            } catch (e) {
                alert('Jobデータファイルの読み込みに失敗しました。' + e);
                console.error(e);
            }
        }
        reader.readAsText(filepath);
    } else {
        const errorMessage = 'ファイルが選択されていません。';
        alert(errorMessage);
        console.error(errorMessage);
    }
}

```

### コールバックで共通化する

``` javascript
    function loadData(id, onSucess, onError) {
        const input = document.getElementById(id);
        const filepath = input.files[0];
        console.info("filepath: ", filepath);
        if (filepath) {
            const reader = new FileReader();
            reader.onload = function(e) {
                try {
                    const data = JSON.parse(e.target.result);
                    console.info(data);
                    onSucess(data);
                } catch (e) {
                    alert(onError + e);
                    console.error(e);
                }
            }
            reader.readAsText(filepath);
        } else {
            const errorMessage = 'ファイルが選択されていません。';
            alert(errorMessage);
            console.error(errorMessage);
            return;
        }
    }

    let dependencyList = [];
    function loadDependencies() {
        const id = 'dependencies_load';
        const message = 'ジョブ依存ファイルの読み込み'
        const errorMessage = 'ジョブ依存の読み込みに失敗しました。'

        loadData(id, (data) => {
            dependencyList = data;
            console.info(message + " finished.")
            document.getElementById('load_schedule').style.visibility = 'visible';
        }, errorMessage);
    }

    let scheduledList = [];
    function loadScheduleList() {
        const id = 'load_schedule_list';
        const message = 'Jobスケジュールファイルの読み込み'
        const errorMessage = 'Jobスケジュールファイルの読み込みに失敗しました。'

        loadData(id, (data) => {
            scheduledList = data;
            console.info(message + " finished.");
            document.getElementById('load_job').style.visibility = 'visible';
        }, errorMessage);
    }

    function loadJobList() {
        const id = 'load_job_list';
        const message = 'Jobデータファイルの読み込み'
        const errorMessage = 'Jobデータファイルの読み込みに失敗しました。'

        loadData(id, (data) => {
            jobList = data;
            (async function() {
                await addDependencies();
                await addScheduled();
                await drawChart();
            })();
            console.info(message + " finished.")
        }, errorMessage);
    }
```

## JSON - Base64変換

- リポジトリ
    - [base64_encode_decode_sample](https://github.com/SampleUser0001/base64_encode_decode_sample)
- Pages
    - [単項目](https://sampleuser0001.github.io/base64_encode_decode_sample/)
    - [複数項目](https://sampleuser0001.github.io/base64_encode_decode_sample/multi_item.html)

## サブウィンドウ

- [subwindow:SampleUser0001](https://github.com/SampleUser0001/subwindow)