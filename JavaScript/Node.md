# Node.js

- [Node.js](#nodejs)
  - [コールバック](#コールバック)

## コールバック

``` node
function func01(args, (error, callback) => {
    if(error){
        callback(args)
    }
})
```

