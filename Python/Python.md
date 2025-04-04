# Python

- [Python](#python)
  - [CSV読み込み](#csv読み込み)
    - [実行結果](#実行結果)
    - [Util.py](#utilpy)
    - [ヘッダ行を読み飛ばす](#ヘッダ行を読み飛ばす)
  - [普通のファイル読み込み](#普通のファイル読み込み)
  - [csv -\> json](#csv---json)
    - [csvもどきを読み込む](#csvもどきを読み込む)
  - [jsonを読み込む](#jsonを読み込む)
    - [dict](#dict)
    - [dataclass](#dataclass)
      - [Simple](#simple)
      - [List](#list)
  - [dict -\> jsonファイル出力する](#dict---jsonファイル出力する)
  - [ディレクトリ配下を再帰的に検索する](#ディレクトリ配下を再帰的に検索する)
  - [\_\_init\_\_をオーバーロードする](#__init__をオーバーロードする)
  - [dataclassの初期化](#dataclassの初期化)
  - [Enumの実装例](#enumの実装例)
  - [Enum/dotenv](#enumdotenv)
    - [src](#src)
      - [.env](#env)
      - [config.py](#configpy)
      - [app.py](#apppy)
    - [実行結果](#実行結果-1)
    - [参考](#参考)
  - [dataclassのsort](#dataclassのsort)
  - [クラス宣言とコンストラクタ](#クラス宣言とコンストラクタ)
  - [配列の展開](#配列の展開)
    - [ソース](#ソース)
    - [実行結果](#実行結果-2)
    - [参考](#参考-1)
  - [文字列の配列を何らかの文字列で連結する](#文字列の配列を何らかの文字列で連結する)
  - [str -\> int -\> bool](#str---int---bool)
    - [実行例](#実行例)
  - [datetime](#datetime)
    - [str -\> datetime , timezone](#str---datetime--timezone)
    - [datetime -\> str](#datetime---str)
    - [int -\> datetime -\> str](#int---datetime---str)
    - [日付計算](#日付計算)
  - [型の判定](#型の判定)
    - [参考](#参考-2)
  - [APIを実行する](#apiを実行する)
    - [参考](#参考-3)
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
    - [参考](#参考-4)
  - [virtualenv](#virtualenv)
    - [参考](#参考-5)
  - [format](#format)
  - [for](#for)
  - [重複排除(list -\> set)](#重複排除list---set)
  - [メソッド呼び出し時に副作用的に別の処理を呼び出す](#メソッド呼び出し時に副作用的に別の処理を呼び出す)
    - [デコレータを使う](#デコレータを使う)
    - [クラス全体にデコレータを適用する](#クラス全体にデコレータを適用する)
    - [`__getattribute__`を使用する](#__getattribute__を使用する)
  - [マルチプロセス](#マルチプロセス)
    - [ProcessPoolExecutor](#processpoolexecutor)
    - [配列をマルチプロセスで処理する](#配列をマルチプロセスで処理する)
    - [配列ではないがマルチプロセスで処理する](#配列ではないがマルチプロセスで処理する)
  - [unittest](#unittest)
    - [テスト実行前にメソッドを実行する](#テスト実行前にメソッドを実行する)
  - [boto3](#boto3)
    - [サービスのclientを取得する](#サービスのclientを取得する)
  - [pyenv](#pyenv)
    - [インストール可能なバージョン一覧](#インストール可能なバージョン一覧)
    - [特定バージョンのPythonインストール](#特定バージョンのpythonインストール)
      - [参考](#参考-6)
    - [インストール済みバージョンの一覧](#インストール済みバージョンの一覧)
    - [切り替え](#切り替え)
    - [アンインストール](#アンインストール)
    - [切り替わらないとき](#切り替わらないとき)
      - [set by PYENV\_VERSION environment variable](#set-by-pyenv_version-environment-variable)
        - [参考](#参考-7)
  - [sqlite3](#sqlite3)
    - [バインドする](#バインドする)
  - [ラムダ式](#ラムダ式)
    - [配列から特定要素を削除する](#配列から特定要素を削除する)
  - [フォーマットを読み込んで置換する](#フォーマットを読み込んで置換する)
  - [グラフを生成する](#グラフを生成する)
  - [ssh接続する](#ssh接続する)
  - [mainの戻り値を指定する](#mainの戻り値を指定する)
  - [pandas](#pandas)
  - [oracledb](#oracledb)
    - [selectを投げる](#selectを投げる)

## CSV読み込み

```python 
# -*- coding: utf-8 -*-
import csv
import sys
from model import ReleaseModel
from util import Util

if __name__ == '__main__':
    args = sys.argv
    filepath = args[1]
    
    release_list = []
    with open(filepath, encoding='utf8', newline='\n') as f:
        csvreader = csv.reader(f, quotechar='"', quoting=csv.QUOTE_NONNUMERIC)
        for row in csvreader:
            model = ReleaseModel(row)
            release_list.append(model)
            print(model)
            
    for job in Util.get_deploy_job(release_list):
        print(f'- {job}')
    
```

``` python
# -*- coding: utf-8 -*-

from dataclasses import dataclass

@dataclass
class ReleaseModel:
    title: str
    repository: str
    deploy: set
    def __init__(self, line: list):
        index = 0
        self.title = line[index]; index += 1
        self.repository = line[index]; index += 1
        self.deploy = line[index].split('|'); index += 1
```

``` csv
"title1","batch","ST0|IKR01|IKR03"
"title2","print","ST0|IKR01|IKR03"
"title3","batch","ST0|IKR01|SIT01"
"title4","webapps","ST0|IKR01|SIT01|ST101"
```

### 実行結果

``` txt
ReleaseModel(title='title1', repository='batch', deploy=['ST0', 'IKR01', 'IKR03'])
ReleaseModel(title='title2', repository='print', deploy=['ST0', 'IKR01', 'IKR03'])
ReleaseModel(title='title3', repository='batch', deploy=['ST0', 'IKR01', 'SIT01'])
ReleaseModel(title='title4', repository='webapps', deploy=['ST0', 'IKR01', 'SIT01', 'ST101'])
- batch-IKR01
- batch-IKR03
- batch-SIT01
- batch-ST0
- print-IKR01
- print-IKR03
- print-ST0
- webapps-IKR01
- webapps-SIT01
- webapps-ST0
- webapps-ST101
- webapps-eob-IKR01
- webapps-eob-SIT01
- webapps-eob-ST0
- webapps-eob-ST101
```

### Util.py

``` python
# -*- coding: utf-8 -*-

# from model import ReleaseModel

class Util:
    @staticmethod
    def get_deploy_job(relase_list: list):
        job_list = []

        for release in relase_list:
            for env in release.deploy:
                job_list.append((release.repository, env))
                if release.repository == 'webapps':
                    job_list.append((release.repository + '-eob', env))

        return_list = []
        for job in set(job_list):
            return_list.append(job[0] + '-' + job[1])
        
        return_list.sort()
        return return_list

```

### ヘッダ行を読み飛ばす

``` python
csvreader = csv.reader(f, quotechar='"', quoting=csv.QUOTE_NONNUMERIC)
next(csvreader)
```

## 普通のファイル読み込み

``` python
def import_format():
     return_list = []
    with open(FORMAT_PATH, 'r') as f:
        # readlineとか、readlines等の関数もあるが、末尾に改行コードが残る（仕様）。
        # 改行を除去したいため、下記を使用する。
        for line in f.read().splitlines():
            return_list.append(line)
    return return_list

```

## csv -> json

pandasを使用する。  
（当初はcsvに重複する項目があった場合、json側はリストにするつもりだったが未確認。）

`data.csv`

``` csv
a,b,b,c
hoge,piyo,1,fuga
aaa,bb,2,ccc
```

```python
import pandas as pd

df_data = pd.read_csv('data.csv')
df_data.to_json('data.json', orient='records')
```

`data.json`

```json
[{"a":"hoge","b":"piyo","b.1":1,"c":"fuga"},{"a":"aaa","b":"bb","b.1":2,"c":"ccc"}]
```

### csvもどきを読み込む

[FakeCSV_convert_to_Json](https://github.com/SampleUser0001/FakeCSV_convert_to_Json)

こういうやつだが・・・  
**こんなファイルを作ってはいけない！！**  
**これはCSVではない！！**  
作りたいのであれば別ファイルに分けるべき。

``` csv
PATTERN_A
a,b,b,c
hoge,piyo,1,fuga
aaa,bb,2,ccc
PATTERN_B
a,a,b,c,c
hoge,1,piyo,fuga,2
```

## jsonを読み込む

### dict

``` python
import json

with open(REPLACE_DICT_PATH, 'r') as d:
    replace_dict = json.load(d)
```

### dataclass

#### Simple

``` json
{
    "id" : 1,
    "name" : "hogehoge"
}
```

```python
from dataclasses import dataclass

@dataclass
class SimpleModel:
    id: int
    name: str
```

``` python
from model SimpleModel
import json

with open("simple.json", "r") as fp:
    json_data = json.load(fp)
    print(SimpleModel(**json_data))
```

#### List

``` json
[
    {
        "id" : 1,
        "name" : "top",
        "sub" : [
            {
                "id" : "A1",
                "name" : "sub_A1"
            },
            {
                "id" : "A2",
                "name" : "sub_A2"
            }
        ]
    },
    {
        "id" : 2,
        "name" : "second",
        "sub" : [
            {
                "id" : "B1",
                "name" : "sub_B1"
            },
            {
                "id" : "B2",
                "name" : "sub_B2"
            }
        ]
    }
]
```

``` python
from dataclasses import dataclass, field
from dataclasses_json import dataclass_json
from typing import List

@dataclass
class SubModel:
    id: str
    name: str
    value: str
    
@dataclass
class JsonModel:
    id: int 
    name: str
    sub: List[SubModel]  = field(default_factory=list)
```

``` python
from model import JsonModel
import json

with open("sample.json", "r") as fp:
    json_data = json.load(fp=fp)
    print([JsonModel.from_dict(model) for model in json_data])
```

## dict -> jsonファイル出力する

``` python
import json
dict_datas = {}
# dict_datasに値を詰める（省略）
with open('data.json', 'w') as f:
    json.dump(dict_datas, f, ensure_ascii=False)
    # ensure_asciiは文字をエスケープするかどうかの設定。Falseでしない。
```

## ディレクトリ配下を再帰的に検索する

```python 
import glob

files = glob.glob("./**/*.py", recursive=True)
for file in files:
    print(file)
```

## __init__をオーバーロードする

Pythonの場合、__init__は１クラスに1つしか作れないため、オーバーロードできない。  
`@dataclass`をつけた場合、`__init__`メソッドが生成されるが、CSV -> dataclassしたい場合は、listで渡したい場合もある。

``` python

from dataclasses import dataclass

@dataclass
class SampleDataClass:
    id: str
    hoge: str

    def sets(self, line: list):
        index = 0
        self.id = list[index]; index += 1
        self.hoge = list[index]; index += 1
```

## dataclassの初期化

`dataclass`は初期値がない場合は、引数なしでコンストラクタを呼び出せない。  
なるべく初期値は設定したほうが良い。

``` python
from dataclasses import dataclass

@dataclass
class HogeModel():
    id: int = 0
    v: str = None
```

## Enumの実装例

- [Enum_inPython : SampleUser0001 : Github](https://github.com/SampleUser0001/Enum_inPython)

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

## dataclassのsort

``` python
from operator import attrgetter

# ageはdataclassのメンバ変数名。
sorted(person_list, key=attrgetter('age'))
```

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

def unpack_03(original):
    """あとから展開したものを追加するだけならこれでOK。"""
    return_list = []
    for l in original:
        return_list.extend(l)
    return return_list

def main():
    original = [[1,2],[3,4],[5,6]]

    print(original)
    print(unpack_01(original))
    print(unpack_02(original))
    print(unpack_03(original))
    
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

## 文字列の配列を何らかの文字列で連結する

```python
','.join(str_list)
```

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

## datetime

### str -> datetime , timezone

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

### datetime -> str

``` python
import datetime

now = datetime.datetime.now()
print(now)
print(now.strftime("%Y%m%d"))
```

``` txt
2023-12-12 23:49:39.010985
20231212
```

### int -> datetime -> str

```python
import sys
import datetime

def convert_unixtime_to_hhmm(unixtime):
    time = datetime.datetime.fromtimestamp(unixtime)
    print(time)
    formatted_time = time.strftime("%H:%M")
    return formatted_time

if __name__ == '__main__':
    args = sys.argv

    print(convert_unixtime_to_hhmm(int(args[1])/1000000))
    
    # 正しくはないが下記でも動く。
    # print(convert_unixtime_to_hhmm(int(str(args[1][0:10]))))
```

``` bash
$ python app.py 1704206837620459
2024-01-02 23:47:17.620459
23:47
```

### 日付計算

```python
import datetime

now = datetime.datetime.now()
print(now)
print(now + datetime.timedelta(days=1))
```

```txt
2023-12-12 23:48:52.882272
2023-12-13 23:48:52.882272
```

## 型の判定

``` python
if type(value) is str:
    # 
```

### 参考

- [Pythonで型を取得・判定するtype関数, isinstance関数:note.nkmk.me](https://note.nkmk.me/python-type-isinstance/)

## APIを実行する

- `requests`をinstallする。
- Azure DevOpsのリポジトリIDを取得するサンプル。

``` python
import requests

def getURL(organization:str, project:str) -> str:
    return f'https://dev.azure.com/{organization}/{project}/_apis/git/repositories?api-version=7.0'

if __name__ == '__main__':
    # 起動引数の取得
    # args = sys.argv
    # args[0]はpythonのファイル名。
    # 実際の引数はargs[1]から。

    result = requests.get(
        getURL(
            ImportEnvKeyEnum.ORGANIZATION.value,
            ImportEnvKeyEnum.PROJECT.value),
        auth=('git', ImportEnvKeyEnum.Token.value)).json()
    
    logger.info(result)
    
    for repo in result['value']:
        print(repo['id'])

```

### 参考

- [requests : pypi](https://pypi.org/project/requests/)

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

## virtualenv

``` bash
pip install -U pip
pip install --user --upgrade virtualenv
virtualenv aip-env
source aip-env/bin/activate
```

### 参考

- [Python クライアント ライブラリの使用:Google](https://cloud.google.com/ai-platform/prediction/docs/python-client-library?hl=ja)

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

## 重複排除(list -> set)

``` python
deploy_jobs = []

deploy_jobs.append(('batch','ST0'))
deploy_jobs.append(('batch','IKR01'))
deploy_jobs.append(('batch','ST0'))

print(set(deploy_jobs))
```

## メソッド呼び出し時に副作用的に別の処理を呼び出す

```python
# -*- coding: utf-8 -*-
from logging import getLogger, config
import os
from logutil import LogUtil

PYTHON_APP_HOME = os.getenv('PYTHON_APP_HOME')
LOG_CONFIG_FILE = ['config', 'log_config.json']

log_conf = LogUtil.get_log_conf(os.path.join(PYTHON_APP_HOME, *LOG_CONFIG_FILE))
config.dictConfig(log_conf)

class SampleController():
    def __init__(self) -> None:
        pass

    def print_log_info_only(self) -> None:
        logger = getLogger("controller.SampleController.print_log_info_only")
        logger.info("This is an INFO log")
        logger.debug("This DEBUG log will not be shown")

    def print_log_debug(self) -> None:
        logger = getLogger("controller.SampleController.print_log_debug")
        logger.info("This is an INFO log")
        logger.debug("This is a DEBUG log")

```

### デコレータを使う

``` python
from functools import wraps
from logging import getLogger, config
import os

def dynamic_logger(logger_name):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            logger = getLogger(logger_name)
            setattr(args[0], 'logger', logger)  # インスタンスにロガーを設定
            return func(*args, **kwargs)
        return wrapper
    return decorator


class SampleController():
    def __init__(self):
        pass

    @dynamic_logger("controller.SampleController.print_log_info_only")
    def print_log_info_only(self):
        self.logger.info("This is an INFO log")
        self.logger.debug("This DEBUG log will not be shown")

    @dynamic_logger("controller.SampleController.print_log_debug")
    def print_log_debug(self):
        self.logger.info("This is an INFO log")
        self.logger.debug("This is a DEBUG log")

```

### クラス全体にデコレータを適用する

``` python
def apply_logger(cls):
    for attr_name, attr_value in cls.__dict__.items():
        if callable(attr_value):  # メソッドかどうか確認
            logger_name = f"{cls.__name__}.{attr_name}"
            decorated = dynamic_logger(logger_name)(attr_value)
            setattr(cls, attr_name, decorated)
    return cls


@apply_logger
class SampleController():
    def __init__(self):
        pass

    def print_log_info_only(self):
        self.logger.info("This is an INFO log")
        self.logger.debug("This DEBUG log will not be shown")

    def print_log_debug(self):
        self.logger.info("This is an INFO log")
        self.logger.debug("This is a DEBUG log")
```

### `__getattribute__`を使用する

``` python
def apply_logger(cls):
    for attr_name, attr_value in cls.__dict__.items():
        if callable(attr_value):  # メソッドかどうか確認
            logger_name = f"{cls.__name__}.{attr_name}"
            decorated = dynamic_logger(logger_name)(attr_value)
            setattr(cls, attr_name, decorated)
    return cls


@apply_logger
class SampleController():
    def __init__(self):
        pass

    def print_log_info_only(self):
        self.logger.info("This is an INFO log")
        self.logger.debug("This DEBUG log will not be shown")

    def print_log_debug(self):
        self.logger.info("This is an INFO log")
        self.logger.debug("This is a DEBUG log")

```

## マルチプロセス

### ProcessPoolExecutor

``` python
import csv
from concurrent.futures import ProcessPoolExecutor

replace_dict_1 = {
    "A" : "hoge",
    "B" : "fuga",
    "C" : "piyo",
    "D" : "foo",
    "E" : "bar",
    "F" : "baz"
}
replace_dict_3 = {
    1 : "one",
    2 : "two",
    3 : "three",
    4 : "four",
    5 : "five",
    6 : "six",
    7 : "seven",
    8 : "eight",
    9 : "nine",
    10 : "ten"
}

def process_row(row):
    # Replace the first column using replace_dict_1
    row[0] = replace_dict_1.get(row[0], row[0])
    # Replace the third column using replace_dict_3
    try:
        key = int(row[2])
        row[2] = replace_dict_3.get(key, row[2])
    except ValueError:
        pass
    return row

with open('list.tsv', 'r', newline='') as f:
    reader = csv.reader(f, delimiter='\t')
    rows = list(reader)

with ProcessPoolExecutor() as executor:
    processed_rows = list(executor.map(process_row, rows))

print(processed_rows)
```

### 配列をマルチプロセスで処理する

``` python
# -*- coding: utf-8 -*-
from multiprocessing import Pool

SQUARE_COUNT = 10

def square(i):
    return i*i

if __name__ == '__main__':
    int_list = list(range(SQUARE_COUNT))
    
    print(f'int_list : {int_list}')
    
    # 第1引数に関数、第2引数に処理する配列を受ける
    with Pool(4) as pool:
        result = pool.map(square, int_list)
        
    print(result)
```

``` txt
int_list : [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
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

## unittest

### テスト実行前にメソッドを実行する

``` python
import unittest

class TestSampleClass(unittest.TestClass):
    @classmethod
    def setUpClass(cls):
        # ここにやりたいことを書く
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

## sqlite3

### バインドする

``` python
cur.execute("select * from hoge_table where id = ?",(id))
cur.execute("select * from hoge_table where id = :id",({"id": id}))
```

## ラムダ式

### 配列から特定要素を削除する

```python
# 空文字を削除
result_list = list(filter(lambda s: s != '', origin_list))
```

## フォーマットを読み込んで置換する

至って普通。

`config.json`

```json
{
    "format" : "$hoge$"
}
```

`app.py`

```python
import json

# ファイルパス
file_path = "config.json"

# ファイルを読み込む
with open(file_path, "r") as file:
    config_data = json.load(file)

# 読み込んだデータを表示する
print(config_data)
print(config_data["format"].replace("$hoge$", "fuga"))
```

```txt
{'format': '$hoge$'}
fuga
```

## グラフを生成する

- [Use_graphviz](https://github.com/SampleUser0001/Use_graphviz)

## ssh接続する

paramikoを使用する。  
(実装例は使用する機会が合った時に記載する。)

## mainの戻り値を指定する

基本的に0が正常終了。

``` python
import sys

def main():
    try:
        v1 = sys.argv[1]
        v2 = sys.argv[2]
        sys.exit(0)
    except IndexError:
        sys.exit("引数が足りません")

    # ここに処理を記述する

if __name__ == "__main__":
    main()
```

## pandas

- [実装例](https://github.com/SampleUser0001/Pandas_sample/blob/main/app/src/controller.py)

## oracledb

### selectを投げる

``` python
import oracledb

try:
    with oracledb.connect(
        user=,
        password=,
        dsn='IP:Port/接続名') as connection:

        with connection.cursor() as cursor:
            for r in cursor.execute(sql, parameter_dict):
                # r[0] : 1項目
                # r[1] : 2項目
```
