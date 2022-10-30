# TypeScript

- [TypeScript](#typescript)
  - [init](#init)
    - [tsconfig.json](#tsconfigjson)
  - [consoleでエラーになる](#consoleでエラーになる)
    - [参考](#参考)

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

