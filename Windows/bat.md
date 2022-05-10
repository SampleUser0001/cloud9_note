# Windows batch

- [Windows batch](#windows-batch)
  - [起動引数](#起動引数)
  - [変数](#変数)
    - [宣言](#宣言)
    - [参照](#参照)
  - [if : 条件分岐](#if--条件分岐)
    - [例 : 文字列](#例--文字列)
  - [for](#for)
    - [ディレクトリ配下のファイル一覧を取得する](#ディレクトリ配下のファイル一覧を取得する)
      - [オプション](#オプション)
      - [実行例](#実行例)
      - [参考](#参考)

## 起動引数

``` batch
%0
%1
...
```

※%0は起動ファイル名。

## 変数

### 宣言

``` batch
set 変数名=値
```

### 参照

``` batch
%変数名%
```

## if : 条件分岐

``` bat
if 条件 (
  コマンド
) else (
  コマンド
)
```

### 例 : 文字列

``` bat
@echo off

set hoge=%1

if %hoge%==hoge (
  echo true
) else (
  echo false
)
```

``` bat
>if.bat hoge
true
```

``` bat
>if.bat piyo
false
```

## for

### ディレクトリ配下のファイル一覧を取得する

``` bat
for オプション 検索対象フォルダ %%A in (ファイル名) do (
  echo %%A 
)
```

#### オプション

| オプション | 効果 |
| :--------- | :--- |
| /r | 再帰検索して、ファイルのみ取得 |
| /d | ディレクトリのみ取得 |

#### 実行例

``` cmd
>dir sample01 /b /s
sample01\sample01_01.txt
sample01\sample02
sample01\sample02\sample02_01.txt
```

``` bat
@echo off

for /r .\sample01 %%A in (*.*) do (
  echo %%A 
)
```

``` txt
C:\Users\ittim\BatchSample\sample01\sample01_01.txt
C:\Users\ittim\BatchSample\sample01\sample02\sample02_01.txt
```

#### 参考

- [.bat（バッチファイル）のforコマンド解説。:Qiita](https://qiita.com/plcherrim/items/67be34bab1fdf3fb87f9)
