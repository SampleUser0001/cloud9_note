# Python

- [Python](#python)
  - [配列の展開](#配列の展開)
    - [ソース](#ソース)
    - [実行結果](#実行結果)
    - [参考](#参考)
  - [str -> datetime](#str---datetime)
  - [依存モジュールの一覧化](#依存モジュールの一覧化)
    - [取得](#取得)
    - [導入](#導入)
  - [venv（仮想環境）](#venv仮想環境)
    - [仮想環境構築](#仮想環境構築)
    - [アクティベート](#アクティベート)
      - [Linux](#linux)
      - [Windows](#windows)
    - [デアクティベート](#デアクティベート)
    - [参考](#参考-1)

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

## str -> datetime

``` python
from datetime import datetime, timezone, timedelta

converted = datetime.strptime("2021-09-11T12:45:18.448117+00:00", "%Y-%m-%dT%H:%M:%S.%f%z")
print(converted)
print(converted.tzinfo)

# timezone変換
# timezoneインスタンスの生成
jst_timezone = timezone(timedelta(hours=9))
jst = converted.astimezone(jst_timezone)
print(jst)
print(jst.tzinfo)
```

``` txt
<class 'datetime.datetime'>
2021-09-11 12:45:18.448117+00:00
UTC
2021-09-11 21:45:18.448117+09:00
UTC+09:00
```

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

## venv（仮想環境）

### 仮想環境構築

``` 
python3 -m venv ${環境名}
```
環境名は「venv」とかでOK。

### アクティベート

アクティベートすると「${環境名}」が表示される。

#### Linux

``` sh
source ${環境名}/bin/activate
```

#### Windows

``` cmd
.\${環境名}\Scripts\activate
```

### デアクティベート

```
deactivate
```

### 参考

- [venv: Python 仮想環境管理:Qiita](https://qiita.com/fiftystorm36/items/b2fd47cf32c7694adc2e)