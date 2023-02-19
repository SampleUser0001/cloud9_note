# Node.js

- [Node.js](#nodejs)
  - [コールバック](#コールバック)
  - [キャッシュクリア](#キャッシュクリア)
    - [参考](#参考)
  - [fetch](#fetch)
    - [実装例(GET)](#実装例get)
    - [参考](#参考-1)

## コールバック

``` node
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
- 