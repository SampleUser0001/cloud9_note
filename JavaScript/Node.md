# Node.js

- [Node.js](#nodejs)
  - [コールバック](#コールバック)
  - [キャッシュクリア](#キャッシュクリア)
    - [参考](#参考)
  - [fetch](#fetch)
    - [実装例(GET)](#実装例get)
    - [参考](#参考-1)
  - [テスト](#テスト)
    - [コマンド](#コマンド)
  - [起動引数を取る](#起動引数を取る)

## コールバック

``` javascript
function func01(args, (error, callback) => {
    if(error){
        callback(args)
    }
})
```

## キャッシュクリア

``` bash
npm cache clean --force
rm -rf ~/.npm

# yarnを使っている場合はこれも実行。
yarn cache clean --force
rm -rf ~/.yarn

rm -rf node_modules
```

### 参考

- [npmキャッシュ削除とインストール済みを削除して再インストール:TICKLECODE](https://ticklecode.com/npmcachedelete/)

## fetch

ブラウザ側では何もしなくても使えるがNode.jsではinstallする必要がある。

``` bash
npm i node-fetch

# requireでインストールする場合はver2が必要。
npm install --save-dev node-fetch@2
```

### 実装例(GET)

``` javascript
const fetch = require('node-fetch');

async function requestGithubUser(githubLogin) {
    try {
        console.log(`User : ${githubLogin}`);
        const githubApiUrl = `https://api.github.com/users/${githubLogin}`;
        const response = await fetch(githubApiUrl);
        const userData = await response.json();
        console.log(userData);
    } catch (error) {
        console.error(error);
    }
}

requestGithubUser('SampleUser0001');
```

### 参考

- [node-fetch:npm](https://www.npmjs.com/package/node-fetch)

## テスト

`index.js`

``` javascript
const retry = async (someFunction, maxRetryCount) => {
    let currentCount = 0;
    let error = null;
    
    while (maxRetryCount >= currentCount) {
        try {
            return await someFunction();
        } catch (err) {
            error = err;
            currentCount++;
            console.log(`Count ${currentCount} failed: ${error.message}`);
            continue;
        }
    }
    
    throw new Error(`Failed after ${maxRetryCount} attempts: ${error.message}`);
}

module.exports = { retry };
```

`index.test.js`

``` javascript
const test = require('node:test');
const assert = require('node:assert');
const { retry } = require('./index');

test('Success test', async (t) => {
    assert.strictEqual(1, 1);
})

test('Success async retry.', async (t) => {
    const res = await retry(() => {
        return 123;
    }, 2);
    assert.strictEqual(res, 123);
});
```

### コマンド

``` bash
node --test *.test.js
```

## 起動引数を取る

``` js
const args = process.argv;

// 2から。0はnodeコマンド、1はファイル名。
let args_index = 2;

console.info(args[args_index++])
console.info(args[args_index++])
```
