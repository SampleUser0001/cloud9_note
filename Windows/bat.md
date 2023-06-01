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
    - [ファイルを読み込む](#ファイルを読み込む)
      - [参考](#参考-1)
  - [ファイルの???のみ取得する](#ファイルののみ取得する)
    - [実行例](#実行例-1)
    - [参考](#参考-2)
  - [置換](#置換)
    - [実装例](#実装例)
    - [参考](#参考-3)

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

変数(%%A)は必ず1文字でなくてはいけない。

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

### ファイルを読み込む

``` bat
@echo off

set filename=%1

for /f %%l in (%filename%) do (
  echo %%l
)
```

#### 参考

- [ファイルから文字列を読み込む:知識ゼロからのwindowsバッチファイル超入門](https://jj-blues.com/cms/wantto-readstringfromfile/)

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

## 置換

### 実装例

``` bat
@echo off
setlocal enabledelayedexpansion

set PROJECT_HOME=c:\work\
set PWD=%~dp0

for /f "delims=" %%a in (%1) do (
    set line=%%a
    echo !line:%PROJECT_HOME%=%PWD%!

)
```

``` txt
c:\work2\copies>type list.txt
c:\work\hoge\hoge.txt
c:\work\hoge\piyo\piyo.txt
```

``` txt
c:\work2\copies>create_copies.bat list.txt
c:\work2\copies\hoge\hoge.txt
c:\work2\copies\hoge\piyo\piyo.txt
```

### 参考

- [Windowsバッチでファイル内の特定文字を置換する方法:Qiita](https://qiita.com/yacchi1123/items/97e75c6784b5b507f701)