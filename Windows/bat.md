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

## ファイルの???のみ取得する

| オプション | 取得するもの |
| :--------- | :----------- |
| %%f    | ファイルのフルパス | 
| %%~nf  | ファイル名のみ。拡張子を除く。| 
| %%~xf  | 拡張子のみ。（"."がついてくる。）| 
| %%~nxf | ファイル名のみ。拡張子を含む。| 
| %%~df  | ドライブレター（C:]等）| 
| %%~pf  | ドライブレターを除いたディレクトリ名 | 
| %%~dpf | ディレクトリ名 | 
| %%~tf  | ファイル更新日 | 
| %%~zf  | ファイルサイズ | 

### 実行例

``` txt
>dir hogedir
 ドライブ C のボリューム ラベルがありません。
 ボリューム シリアル番号は AC93-73F5 です

 C:\Users\alluser\WindowsBatSample\hogedir のディレクトリ

2022/05/11  09:01    <DIR>          .
2022/05/11  09:01    <DIR>          ..
2022/05/11  08:52                 4 piyo.txt
               1 個のファイル                   4 バイト
               2 個のディレクトリ  48,286,896,128 バイトの空き領域
```

``` bat
@echo off

for /r .\hogedir %%f in (*.*) do (
  echo %%f
  echo %%~nf
  echo %%~xf
  echo %%~nxf
  echo %%~df
  echo %%~pf
  echo %%~dpf
  echo %%~tf
  echo %%~zf
  echo   
)

```

``` txt
>hoge.bat
C:\Users\alluser\WindowsBatSample\hogedir\piyo.txt
piyo
.txt
piyo.txt
C:
\Users\alluser\WindowsBatSample\hogedir\
C:\Users\alluser\WindowsBatSample\hogedir\
2022/05/11 08:52
4
ECHO は <OFF> です。
```

### 参考

- [バッチでファイルパスやファイル名を取得する方法:Rainbow Engine](https://rainbow-engine.com/batch-get-filepath-filename/)

