# React.js

- [React.js](#reactjs)
  - [init](#init)
    - [webpack.config.js](#webpackconfigjs)
    - [.babelrc](#babelrc)
    - [.eslintrc.js](#eslintrcjs)
    - [.eslintignore](#eslintignore)
    - [.prettierrc](#prettierrc)
    - [index.html](#indexhtml)
    - [src/index.js](#srcindexjs)
    - [package.json](#packagejson)
    - [src/App.js](#srcappjs)
    - [実行](#実行)
    - [備考](#備考)
      - [prettier実行](#prettier実行)
  - [useState](#usestate)
  - [Reactコンテキスト](#reactコンテキスト)
    - [コンテキストプロバイダー](#コンテキストプロバイダー)
    - [コンテキストコンシューマー](#コンテキストコンシューマー)
    - [実装例](#実装例)
    - [その他の参考](#その他の参考)
  - [useEffect](#useeffect)
  - [URLによって生成するコンテキストを変更する](#urlによって生成するコンテキストを変更する)
  - [実装](#実装)
    - [プロジェクト例](#プロジェクト例)
  - [Tailwindを導入する](#tailwindを導入する)
  - [注意点](#注意点)
  - [勉強用リポジトリ](#勉強用リポジトリ)
    - [Checkbox](#checkbox)
  - [参考ソース](#参考ソース)
  - [Document](#document)

## init

``` bash
npm init -y

# React インストール
npm install react react-dom serve

# webpack
npm install --save-dev webpack webpack-cli

# babel
npm install --save-dev babel-loader @babel/core

# babelプリセット
npm install @babel/preset-env @babel/preset-react --save-dev

# プラグイン
# eslint, prettier
# prettierはフォーマッタ。任意でインストール。
npm install eslint eslint-plugin-react-hooks eslint-plugin-jsx-a11y prettier eslint-config-prettier eslint-plugin-prettier

# TypeScript
# @typesがTypeScriptで使う型情報。
npm install typescript @types/node @types/react @types/react-dom

# Jest
npm install jest @types/jest
```

### webpack.config.js

``` javascript
const path = require("path");

module.exports = {
    entry: "./src/index.js",
    output: {
        path: path.join(__dirname, "dist", "asserts"),
        filename: "bundle.js"
    },
    module: {
        rules: [{
            test: /\.js$/,
            exclude: (/node_modules/),
            loader: "babel-loader"
        }]
    },
    devtool: "source-map"
};
```

### .babelrc

``` json
{
    "presets": ["@babel/preset-env", "@babel/preset-react"]
}
```

### .eslintrc.js

`npx eslint --init`で生成できる。  
必要に応じて編集。

``` js
module.exports = {
    "env": {
        "browser": true,
        "es2021": true
    },
    "extends": [
        "eslint:recommended",
        "plugin:react/recommended",
        "plugin:@typescript-eslint/recommended",
        "plugin:jsx-a11y/recommended",
        "plugin:prettier/recommended"
    ],
    "overrides": [
    ],
    "parser": "@typescript-eslint/parser",
    "parserOptions": {
        "ecmaVersion": "latest",
        "sourceType": "module"
    },
    "plugins": [
        "react",
        "react-hooks",
        "jsx-a11y",
        "@typescript-eslint",
        "prettier"
    ],
    "rules": {
        "react-hooks/rules-of-hooks": "error",
        "react-hooks/exhaustive-deps": "warn",
        "prettier/prettier": "error"
    }
}

```

### .eslintignore

eslint対象外ファイルを記載する。

``` 
webpack.config.js
.eslintrc.js
```

### .prettierrc

``` json
{
    "semi": true,
    "trailingComma": none,
    "singleQuote": true,
    "printWidth": 120,
    "tabWidth": 4 
}
```

### index.html

``` html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>React App</title>
    </head>
    <body>
        <div id="root"></div>
        <script src="asserts/bundle.js"></script>
    </body>
</html>
```

### src/index.js

``` javascript
import React from "react";
import { createRoot } from "react-dom/client"
import App from "./App";

//createRoot(document.getElementById("root")).render(<Menu recipes={data} />);
createRoot(document.getElementById("root")).render(
    <React.StrictMode>
        <App />
    </React.StrictMode>
);
```

### package.json

``` json
  "scripts": {
    "clean": "rm -fR ./dist",
    "build": "npm run clean && mkdir ./dist && cp ./index.html ./dist/ && webpack --mode development",
    "start": "serve ./dist",
    "test": "echo \"Error: no test specified\" && exit 1",
    "lint": "eslint ."
  },
```

### src/App.js

``` javascript
import React from "react";

export default function App() {
    return (
        <h1>Hello React.</h1>
    ); 
}
```

### 実行

``` bash
# npm install
npm run build
npm run start
```

### 備考

下記で一括で作成される。

``` bash
npx create-react-app ${プロジェクト名}
```

#### prettier実行

自動変換される。

``` bash
npx prettier --write ${ファイルパス or ディレクトリ}
```

## useState

Reactが管理するstateと、stateを更新するための関数を返す。  
stateを変更する場合は、必ずuseStateの戻り値として渡される関数を使う必要がある。

``` javascript
import {useState} from 'react';

const ClickCounter = () => {
    const [count, setCount] = useState(0);
    function handleClick() {
        setCount(count + 1);
    }

    return (
        <>
            <p>Clicked {count} times</p>
            <button onClick={handleClick}>Count up</button>
        </>
    )
}

export default ClickCounter;
```

## Reactコンテキスト

useStateを呼ぶ箇所と戻り値を使用する箇所が離れている場合、useStateで生成した変数と関数を引数経由で渡す必要があり、ソースが読みづらくなる。  
コンテキストを使用すると、引数経由で渡す必要がなくなる。  
(SpringBootのDIコンテナのイメージ？)

- コンテキストプロパイダー
    - 定義する。
- コンテキストコンシューマー
    - コンテキストを使用する。

### コンテキストプロバイダー

``` javascript
import React from 'react';

const UserProfileContext = React.createContext({});

export default UserProfileContext;
```

### コンテキストコンシューマー

``` javascript
import React, {useContext} from "react";
import UserProfileContext from "./UserProfileContext";

function UserProfile() {
    const userProfile = useContext(UserProfileContext);

    return (
        <div>
            <h2>User Profile</h2>
            <p>Username: {userProfile.username}</p>
            <p>Email: {userProfile.email}</p>
        </div>
    )
}

export default UserProfile;
```

### 実装例

``` javascript
import { useState } from 'react';
import './App.css';
import UserProfileContext from './UserProfileContext'; 
import UserProfile from './UserProfile';

function App() {
  const [userProfile, setUserProfile] = useState({
    username: "SampleUser0001",
    email: "ittimfn+github@gmail.com"
  })
  return (
    <UserProfileContext.Provider value={userProfile}>
      <div>
        <h1>User Profile</h1>
        <UserProfile />
      </div>
    </UserProfileContext.Provider>
  );
}

export default App;

```

### その他の参考

- [List_React:SampleUser0001:Github](https://github.com/SampleUser0001/List_React)

## useEffect

副作用フック。  
指定した変数が更新されたときに、動く処理を定義できる。

``` javascript
import React, { useState, useEffect } from "react";

export default function App() {
    // 入力欄に入力されている値
    const [val, set] = useState("");

    // 入力欄のphrase
    const [phrase, setPhrase] = useState("example phrase");

    // phraseをvalで更新する。
    // 入力欄自体は初期化する
    const createPhrase = () => {
        setPhrase(val);
        set('');
    };

    useEffect(() => {
        console.log(`typing "${val}"`);
    }, [val]);

    useEffect(() => {
        console.log(`saved phrase: "${phrase}"`);
    }, [phrase]);

    return (
        <>
            <label>Favorite phrase:</label>
            <input
                value={val}
                placeholder={phrase}
                onChange={e => set(e.target.value)}
            />
            <button onClick={createPhrase}>send</button>
        </>
    );
}
```

## URLによって生成するコンテキストを変更する

React Routerを使う。

``` bash
npm install react-router react-router-dom
```

## 実装

`index.js`

`BrowserRouter.Router`でアプリケーション全体を囲む必要がある。

``` javascript
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import { BrowserRouter as Router } from "react-router-dom";

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <Router>
      <App />
    </Router >
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();

```

`App.js`

``` javascript
import React from 'react';
import './index.css';
import Nav from './nav';
import Contents from './Contents';

function App() {
    return (
        <>
            <Nav />
            <Contents />
        </>
    );
}

export default App;
```

`nav.js`

`Link`を使用する。

``` javascript
import React from 'react';
import {
    Link,
} from "react-router-dom";
import './index.css';

const Nav = () => {
    // stateで遷移先に値を渡す。
    
    return (
        <nav className="bg-gray-800 p-4 text-white">
            <div className="container mx-auto">
                <Link to="/" className="font-semibold mr-4">ホーム</Link>
                <Link to="page_a" className="font-semibold mr-4">PageA</Link>
                <Link to="page_b" className="font-semibold mr-4">PageB</Link>
                {% raw %}
                <Link to="page_c" className="font-semibold mr-4" state={{"message" : "hoge"}}>PageC</Link>
                {% endraw %}
            </div>
        </nav>
    );
}

export default Nav;
```

`Contents.js`

`useRoutes`でURLのパスと要素を紐付ける。

```javascript
import React from "react";
import { useRoutes } from "react-router-dom";

import PageA from "./PageA";
import PageB from "./PageB";
import PageC from "./PageC";

function Contents() {
    let element = useRoutes([
        { path: "/", element: <PageA /> },
        { path: "page_a", element: <PageA /> },
        { path: "page_b", element: <PageB /> },
        { path: "page_c", element: <PageC /> },
    ]);
    return element;
}

export default Contents;
```

`PageC.js`

```javascript
import React from "react";
import { useLocation } from "react-router-dom";
import './index.css';

function PageC() {
    // 遷移元(nav.js)で渡されたstateを取得する
    const message = useLocation().state.message;
    return (
        <div className="container mx-auto mt-10">
            <h1>Page C</h1>
            <p>{message}</p>
        </div>
    );
}

export default PageC;
```

### プロジェクト例

- [React_Router](https://github.com/SampleUser0001/React_Router)
- [Reactハンズオンラーニング 第2版:11.1](https://github.com/oreilly-japan/learning-react-2e-ja/tree/master/chapter-11/11.1)
    - `pages.js`を参照。
    - `<Outlet />`タグで任意の位置の表示を切り替える。

## Tailwindを導入する

``` bash
npm install tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

`tailwind.config.js`

``` javascript
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}", // Reactコンポーネントのパス
    // 他のファイルパスもここに追加できます
  ],
  // その他の設定...
  theme: {
    extend: {},
  },
  plugins: [],
}
```

`src/index.css`
1行目に書く。
``` css
@tailwind base;
@tailwind components;
@tailwind utilities;

```

## 注意点

- `class`は使えない。`className`を使う。
- `h`タグが聞かない
    - Reactの問題ではない。CSSフレームワークの問題。cssファイルに記載する。
        - [Tailwind CSS Headings - Flowbite](https://flowbite.com/docs/typography/headings/)

## 勉強用リポジトリ

- [React_Hands_on_Learning_Practice:SampleUser0001:Github](https://github.com/SampleUser0001/React_Hands_on_Learning_Practice)

### Checkbox

- [List_React:SampleUser0001:Github](https://sampleuser0001.github.io/List_React/)

## 参考ソース

- [ReactSample:SampleUser0001:Github](https://github.com/SampleUser0001/React_Samples)
- [React + TypeScript cheatsheet](https://github.com/typescript-cheatsheets/react)

## Document

- [クイックスタート](https://ja.react.dev/learn)
- [Hello world](https://ja.legacy.reactjs.org/docs/hello-world.html)