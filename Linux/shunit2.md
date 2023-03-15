# shunit2

- [shunit2](#shunit2)

## 基本的な使い方

細かいことは公式ドキュメントと、$SHUNIT2_HOME/examples/配下のshファイルを参照。  
suite_test.shファイルを元に作成。

### ファイル一覧

``` bash
$ ls -all
total 12
drwxr-xr-x 2 ec2-user ec2-user  51 Mar 15 14:52 .
drwxrwxr-x 3 ec2-user ec2-user  44 Mar 15 14:44 ..
-rwxr-xr-x 1 ec2-user ec2-user  45 Mar 15 14:57 app.sh
-rwxr-xr-x 1 ec2-user ec2-user  55 Mar 15 14:57 funcs.sh
-rwxr-xr-x 1 ec2-user ec2-user 171 Mar 15 14:58 test.sh
ec2-user:~/environment/tmp/shell/use_ahunit2 $ 
```

### app.sh

``` bash
#!/bin/bash

. ./funcs.sh

echo `hello_world`
```

### funcs.sh

``` bash
#!/bin/bash

hello_world() {
    echo 'Hello World!'
}
```

### test.sh

``` bash
#!/bin/bash

. $SHUNIT2_HOME/shunit2
. ./funcs.sh

suite() {
    suite_addTest hello_world_test
}

hello_world_test() {
    assertEquals 'Hello World!' "`hello_world`"
}
```

### 通常のシェル実行

``` shell
$ sh app.sh
Hello World!
```

### テスト実行

``` shell
$ sh test.sh

Ran 0 tests.

OK
```

## 参考

- [shunit2:kward:Github](https://github.com/kward/shunit2)
    - 公式