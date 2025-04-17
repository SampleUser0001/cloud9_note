# 任意個数の引数でgrep 

- [任意個数の引数でgrep](#任意個数の引数でgrep)
  - [実装例](#実装例)

## 実装例

``` bash
#!/bin/bash

# 引数が十分にあるか確認
if [ $# -lt 2 ]; then
  echo "使用法: $0 ファイル名 検索パターン1 [検索パターン2 ...]"
  exit 1
fi

# 最初の引数をファイル名として取得
TARGET_FILE="$1"
shift

# ファイルの存在確認
if [ ! -f "$TARGET_FILE" ]; then
  echo "エラー: ファイル '$TARGET_FILE' が見つかりません。"
  exit 1
fi

# 最初のパターンで検索を開始
result=$(grep "$1" "$TARGET_FILE")

# 2つ目以降のパターンで絞り込み
shift
for pattern in "$@"; do
  if [ -z "$result" ]; then
    # 結果がすでに空の場合は処理を中止
    break
  fi
  # 前の結果に対して次のパターンでgrepを実行
  result=$(echo "$result" | grep "$pattern")
done

# 結果の出力
echo "$result"
```
