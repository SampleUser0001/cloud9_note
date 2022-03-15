# Node.js

- [Node.js](#nodejs)
  - [コールバック](#コールバック)
  - [キャッシュクリア](#キャッシュクリア)
    - [参考](#参考)

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
rm -rf node_modules
```

### 参考

- [npmキャッシュ削除とインストール済みを削除して再インストール:TICKLECODE](https://ticklecode.com/npmcachedelete/)