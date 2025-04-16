# 任意個数の引数でgrep 

- [任意個数の引数でgrep](#任意個数の引数でgrep)
  - [実装例](#実装例)

## 実装例

``` bash
#!/bin/bash

# 検索対象のファイル
TARGET_FILE="example.txt"

# 引数が渡されているか確認
if [ $# -eq 0 ]; then
  echo "使用法: $0 検索パターン1 [検索パターン2 ...]"
  exit 1
fi

# 全引数を-eオプションで処理
grep_args=""
for pattern in "$@"; do
  grep_args="$grep_args -e $pattern"
done

grep $grep_args $TARGET_FILE
```
