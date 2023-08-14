# Python

- [Python](#python)
  - [Enum/dotenv](#enumdotenv)
    - [src](#src)
      - [.env](#env)
      - [config.py](#configpy)
      - [app.py](#apppy)
    - [実行結果](#実行結果)
    - [参考](#参考)
  - [クラス宣言とコンストラクタ](#クラス宣言とコンストラクタ)
  - [配列の展開](#配列の展開)
    - [ソース](#ソース)
    - [実行結果](#実行結果-1)
    - [参考](#参考-1)
  - [str -\> int -\> bool](#str---int---bool)
    - [実行例](#実行例)
  - [str -\> datetime](#str---datetime)
  - [型の判定](#型の判定)
    - [参考](#参考-2)
  - [部分配列の取得](#部分配列の取得)
    - [先頭を取得する](#先頭を取得する)
    - [末尾を取得する](#末尾を取得する)
    - [間を取得する](#間を取得する)
  - [@staticmethodと@classmethodの違い](#staticmethodとclassmethodの違い)
    - [回答](#回答)
  - [依存モジュールの一覧化](#依存モジュールの一覧化)
    - [取得](#取得)
    - [導入](#導入)
  - [venv（仮想環境）](#venv仮想環境)
    - [仮想環境構築](#仮想環境構築)
    - [アクティベート](#アクティベート)
      - [Linux](#linux)
      - [Windows](#windows)
    - [デアクティベート](#デアクティベート)
    - [参考](#参考-3)
  - [format](#format)
  - [for](#for)
  - [マルチプロセス](#マルチプロセス)
    - [配列をマルチプロセスで処理する](#配列をマルチプロセスで処理する)
    - [配列ではないがマルチプロセスで処理する](#配列ではないがマルチプロセスで処理する)
  - [boto3](#boto3)
    - [サービスのclientを取得する](#サービスのclientを取得する)
  - [pyenv](#pyenv)
    - [インストール可能なバージョン一覧](#インストール可能なバージョン一覧)
    - [特定バージョンのPythonインストール](#特定バージョンのpythonインストール)
      - [参考](#参考-4)
    - [インストール済みバージョンの一覧](#インストール済みバージョンの一覧)
    - [切り替え](#切り替え)
    - [アンインストール](#アンインストール)
    - [切り替わらないとき](#切り替わらないとき)
      - [set by PYENV\_VERSION environment variable](#set-by-pyenv_version-environment-variable)
        - [参考](#参考-5)

## Enum/dotenv

``` bash
pip install python-dotenv
```

### src

#### .env

``` 
HOGE=hoge
```

#### config.py

``` python
from dotenv import load_dotenv
load_dotenv()

import os
from enum import Enum

class SampleEnum(Enum):
    HOGE = os.getenv("HOGE")
```

#### app.py

``` python
from config import SampleEnum

print(SampleEnum.HOGE)
print(SampleEnum.HOGE.value)
```

### 実行結果

``` bash
$ python app.py
SampleEnum.HOGE
hoge
```

### 参考

- [.env ファイルで環境変数を設定する (python-dotenv):まくまくPythonノート](https://maku77.github.io/python/env/dotenv.html)

## クラス宣言とコンストラクタ

``` python
class SampleClass:
    def __init__(self, v):
        self.v = v
```

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

## str -> int -> bool

あくまで整数。

| 値  | True/False |
| :-- | :--------- |
| 1 | True |
| 0 | False |
| 上記以外 | True |

### 実行例

``` python
import sys

def main(args):
    i = int(args[1]);
    if i:
        print(True)
    else:
        print(False)

if __name__ == '__main__':
    main(sys.argv)
```

``` bash
$ python app.py 1
True
```

``` bash
$ python app.py 0
False
```

``` bash
$ python app.py 2
True
```

``` bash
$ python app.py -1
True
```

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

## 型の判定

``` python
if type(value) is str:
    # 
```

### 参考

- [Pythonで型を取得・判定するtype関数, isinstance関数:note.nkmk.me](https://note.nkmk.me/python-type-isinstance/)

## 部分配列の取得

### 先頭を取得する

``` python
l = [1,2,3,4,5]
part = l[:3]
print(part)
```

``` txt
[1, 2, 3]
```

### 末尾を取得する

``` python
l = [1,2,3,4,5]
part = l[3:]
print(part)
```

``` txt
[4, 5]
```

### 間を取得する

``` python
l = [1,2,3,4,5]
part = l[1:3]
print(part)
```

``` txt
[2, 3]
```

## @staticmethodと@classmethodの違い

ChatGPT-3.5に下記の質問をした。

``` txt
Pythonで@staticmethodと@classmethodの違いを教えてください。
```

### 回答

`@staticmethod`と`@classmethod`は、Pythonにおけるクラスメソッドの異なる種類を示すデコレータです。両者は、クラス自体から呼び出すことができるメソッドを定義するために使用されますが、異なる動作を持っています。

1. `@staticmethod`（静的メソッド）:
   - クラスのインスタンスとは関係なく、クラス自体から呼び出すことができるメソッドです。
   - インスタンス変数やクラス変数へのアクセスは直接行えません。そのため、通常の関数として使用されることがあります。
   - 引数に `self` や `cls` を含まないため、メソッド内でこれらのキーワードを使用することはありません。

```python
class MyClass:
    @staticmethod
    def static_method():
        print("This is a static method.")

# クラスから直接呼び出し
MyClass.static_method()
```

2. `@classmethod`（クラスメソッド）:
   - クラス自体と関連がありますが、クラス変数へのアクセスが可能です。
   - 引数の1つ目に `cls`（クラス自体）が渡され、クラス変数やメソッドにアクセスするために使用されます。
   - サブクラスからも継承されるため、オーバーライドすることもできます。

```python
class MyClass:
    class_variable = 10
    
    @classmethod
    def class_method(cls):
        print(f"This is a class method. Class variable: {cls.class_variable}")

# クラスから呼び出し
MyClass.class_method()
```

使い分け:
- `@staticmethod`は、クラスと密接な関係がなく、単に名前空間を提供するためのメソッドに適しています。
- `@classmethod`は、クラスのコンテキストを必要とするメソッド（例えば、ファクトリーメソッド）や、クラス変数にアクセスが必要なメソッドに適しています。

どちらのデコレータも、クラスのインスタンスを作成せずに直接クラスから呼び出せる点が共通しています。

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

## format

``` python
x = 1
print(f"いまはこの表記が主流。 x = {x}")
```

## for

``` python
# -*- coding: utf-8 -*-

dic = {0:'hoge', 1:'piyo'}

# キーを取得
for k in dic:
    print('k : {}'.format(k))
    
# 値だけを取得
for v in dic.values():
    print('v : {}'.format(v))

# 両方取得
for (k, v) in dic.items():
    print('k : {} , v : {}'.format(k,v))
```

``` txt
k : 0
k : 1
v : hoge
v : piyo
k : 0 , v : hoge
k : 1 , v : piyo
```

## マルチプロセス

### 配列をマルチプロセスで処理する

``` python
# -*- coding: utf-8 -*-
from multiprocessing import Pool

SQUARE_COUNT = 10

def square(i):
    return i*i

if __name__ == '__main__':
    with Pool(4) as pool:
        print(pool.map(square, range(SQUARE_COUNT)))
```

``` txt
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
```

### 配列ではないがマルチプロセスで処理する

``` python 
# -*- coding: utf-8 -*-
from multiprocessing import Pool
import random
import datetime 

RANDOM_SQUARE_COUNT = 10000000

def square(i):
    return random.random() * random.random()

def multi_process_performance(process_count):
    start = datetime.datetime.now()
    with Pool(process_count) as pool:
        pool.map(square, range(RANDOM_SQUARE_COUNT))
    finish = datetime.datetime.now()
    print(f'process {process_count} , time : {finish - start}')

if __name__ == '__main__':
    multi_process_performance(1)
    multi_process_performance(4)
    multi_process_performance(100)

```

``` txt
process 1 , time : 0:00:03.838766
process 4 , time : 0:00:00.768664
process 100 , time : 0:00:00.709970
```

## boto3

### サービスのclientを取得する

- [AWS_Pipeline_CodeBuild](https://github.com/SampleUser0001/AWS_Pipeline_CodeBuild)

## pyenv

### インストール可能なバージョン一覧

``` bash
pyenv install -l | less
```

### 特定バージョンのPythonインストール

``` bash
pyenv install ${python_version}
```

#### 参考

- [pyenv:github](https://github.com/pyenv/pyenv/wiki#suggested-build-environment)
  - インストールに失敗したら参照する。

### インストール済みバージョンの一覧

``` bash
pyenv versions
```

### 切り替え

``` bash
pyenv local ${python_version}
```

### アンインストール

``` bash
pyenv uninstall ${python_version}
```

### 切り替わらないとき

#### set by PYENV_VERSION environment variable

``` bash
$ pyenv version
3.10.8 (set by PYENV_VERSION environment variable)
```

PYENV_VERSIONが優先されるため、切り替わらない。  
下記を実行する。

``` bash
pyenv shell --unset
```

##### 参考

- [[Sy] 「pyenv local」が効かない（バージョンがうまく切り替わってくれない）場合の対処 : Syntax Error.](https://utano.jp/entry/2019/02/pyenv-local-does-not-work/)