# React.js

- [React.js](#reactjs)
  - [init](#init)
    - [webpack.config.js](#webpackconfigjs)
    - [.babelrc](#babelrc)
    - [index.html](#indexhtml)
    - [src/index.js](#srcindexjs)
    - [package.json](#packagejson)
    - [src/App.js](#srcappjs)
    - [実行](#実行)
    - [備考](#備考)
  - [勉強用リポジトリ](#勉強用リポジトリ)

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
createRoot(document.getElementById("root")).render(<App />);
```

### package.json

``` json
  "scripts": {
    "clean": "rm -fR ./dist",
    "build": "npm run clean && mkdir ./dist && cp ./index.html ./dist/ && webpack --mode development",
    "start": "serve ./dist",
    "test": "echo \"Error: no test specified\" && exit 1"
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

## 勉強用リポジトリ

- [React_Hands_on_Learning_Practice:SampleUser0001:Github](https://github.com/SampleUser0001/React_Hands_on_Learning_Practice)

