# Windows batch

- [Windows batch](#windows-batch)
  - [起動引数](#起動引数)
  - [変数](#変数)
    - [宣言](#宣言)
    - [参照](#参照)
  - [if : 条件分岐](#if--条件分岐)
    - [例 : 文字列](#例--文字列)

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
