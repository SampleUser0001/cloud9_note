# TypeScript

- [TypeScript](#typescript)
  - [init](#init)
    - [tsconfig.json](#tsconfigjson)
  - [consoleでエラーになる](#consoleでエラーになる)
    - [参考](#参考)
  - [実装例](#実装例)
    - [ビルド](#ビルド)

## init

``` bash
mkdir src

npm install typescript
npm install @types/node
```

### tsconfig.json

``` json
{
    "compilerOptions": {
      "lib": ["es2015"],
      "module": "commonjs",
      "outDir": "dist",
      "sourceMap": true,
      "strict": true,
      "target": "es2015"
    },
    "include": [
      "src"
    ]
}
  
```


## consoleでエラーになる

``` bash
npm install @types/node
```

### 参考

- [TypeScriptでConsole.log()を呼び出そうとするとエラーになるので直した。:くうと徒然なるままに](https://kuxumarin.hatenablog.com/entry/2019/12/13/195636)

## 実装例

``` typescript

class Student {
    fullName: string; // 型指定を追加
    constructor(
        public firstName: string,
        public middleInitial: string, 
        public lastName: string
    ) {
        this.fullName = `${firstName} ${middleInitial} ${lastName}`; // テンプレートリテラルを使用
    }
}

interface Person {
    firstName: string;
    lastName: string;
}

function greeter(person: Person) {
    return "Hello! " + person.firstName + " " + person.lastName; // スペースを追加
}

let user: Person = { firstName: "Jane", lastName: "User" }; // 型を明示的に指定

// DOMが完全に読み込まれてから実行
window.onload = () => {
    document.body.textContent = greeter(user);
};

```

``` html
<!DOCTYPE html>
<html>
  <head>
    <title>TypeScript Greeter</title>
  </head>
  <body>
    <script src="greeter.js"></script>
  </body>
</html>
```

### ビルド

``` bash 
tsc greeter.ts
```
