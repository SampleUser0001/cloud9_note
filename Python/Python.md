# Python

- [Python](#python)
  - [配列の展開](#配列の展開)
    - [ソース](#ソース)
    - [実行結果](#実行結果)
    - [参考](#参考)
  - [依存モジュールの一覧化](#依存モジュールの一覧化)
    - [取得](#取得)
    - [導入](#導入)

## 配列の展開

### ソース

``` python
# -*- coding: utf-8 -*-
import itertools

def unpack_01(original):
  """ もっといい書き方があると思うんだけど・・・"""
  unpacked = []
  for l in original:
    for i in l:
      unpacked.append(i)
  return unpacked

def unpack_02(original):
  return list(itertools.chain(*original))
  
def main():
  original = [[1,2],[3,4],[5,6]]

  print(original)
  print(unpack_01(original))
  print(unpack_02(original))
  
if __name__ == '__main__':
  main()
```

### 実行結果

```
[[1, 2], [3, 4], [5, 6]]
[1, 2, 3, 4, 5, 6]
[1, 2, 3, 4, 5, 6]
```

### 参考

- [Python > list > 二重listを一重listに変換する](https://qiita.com/7of9/items/84dcb552668a8a3bdcd3)

## 依存モジュールの一覧化

### 取得

ファイル名は何でもいいが、requirements.txtにするのが通例。

``` sh
pip freeze > requirements.txt
```

### 導入

``` sh
pip install -r requirements.txt
```