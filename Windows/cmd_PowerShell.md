# コマンドプロンプト/PowerShell

- [コマンドプロンプト/PowerShell](#コマンドプロンプトpowershell)
  - [PowerShell](#powershell)
    - [uuidgen](#uuidgen)
    - [tail](#tail)
      - [参考](#参考)
    - [grep](#grep)
      - [再帰grep](#再帰grep)
    - [find](#find)
    - [touch（新しいファイルを生成する）](#touch新しいファイルを生成する)
      - [空のファイルを作る](#空のファイルを作る)
    - [ファイルを空にする](#ファイルを空にする)
    - [コンソール出力](#コンソール出力)
    - [ps1ファイルの起動引数の取得](#ps1ファイルの起動引数の取得)
    - [文字列の置換](#文字列の置換)
    - [ファイル読み込み](#ファイル読み込み)
      - [単一の文字列](#単一の文字列)
      - [配列](#配列)
    - [ファイル書き込み](#ファイル書き込み)
    - [ファイルに追記](#ファイルに追記)
    - [Map(ハッシュテーブル)](#mapハッシュテーブル)
  - [コマンドプロンプト](#コマンドプロンプト)
    - [ディレクトリごとコピーする(robocopy)](#ディレクトリごとコピーするrobocopy)
      - [オプション](#オプション)
    - [再帰削除](#再帰削除)
    - [find(grep)](#findgrep)
    - [パイプ](#パイプ)
    - [findstr](#findstr)
      - [findstr:オプション](#findstrオプション)
    - [ファイルサイズを取得する(where)](#ファイルサイズを取得するwhere)
      - [参考](#参考-1)
    - [xcopy](#xcopy)
      - [参考](#参考-2)
    - [サービスの停止/起動](#サービスの停止起動)


## PowerShell

### uuidgen

``` powershell
[Guid]::NewGuid().toString()
```

`toString()`は無くても動くが、余計なものがついてくる。

### tail

``` powershell
Get-Content -Path ${ファイルパス} -Tail 0 -Wait [-Encoding ${encode}]
```

#### 参考

- [PowerShell でも tail -f がしたいし grep もしたい:Qiita](https://qiita.com/yokra9/items/d95abda8a795d4e19e0e)

### grep

``` powershell
Select-String -Path ${ファイルパス} -Pattern ${検索文字列}
```

#### 再帰grep

``` powershell
Get-ChildItem -Filter ${ファイル条件} -Recurse | Select-String -Pattern ${検索文字列}
```

### find

``` powershell
Get-ChildItem -r -Filter "条件" -Name
```

``` powershell
dir -Recurse | Get-ChildItem -Filter "条件" -Recurse
```

### touch（新しいファイルを生成する）

``` powershell
New-Item -Path . -Name "test.txt" -ItemType "file" -Value "New-Item cmdlet test."
```

#### 空のファイルを作る

``` powershell
New-Item -Type File ${ファイルパス}
```

### ファイルを空にする

``` powershell
Clear-Content ${ファイルパス}
```

### コンソール出力

``` powershell
Write-Host $str
```

### ps1ファイルの起動引数の取得

``` powershell
Write-Host $Args[0]
Write-Host $Args[1]

```

### 文字列の置換

``` powershell
$str = '{hoge}'
Write-Host $str.replace($str, 'hoge')
```

### ファイル読み込み

#### 単一の文字列

``` powershell
$str = Get-Content $file_path -Raw
```

#### 配列

``` powershell
$list = Get-Content $file_path

foreach ($str in $arr) {
    Write-Host $str
}
```

### ファイル書き込み

``` powershell
# -Encodingを指定しない場合、ShiftJISになる。
Set-Content -Path $file_path -Value $str [-Encoding UTF8]
```

### ファイルに追記

``` powershell
Add-Content -Path $file_path -Value $str
```

### Map(ハッシュテーブル)

``` powershell
$hash_table = @{}
$hash_table.add('key','value')

foreach($key in $hash_table.Keys) {
    Write-Host $hash_table[$key]
}
```

## コマンドプロンプト

### ディレクトリごとコピーする(robocopy)

``` bat
robocopy %ORIGIN% %TARGET% /s /e
```

#### オプション

- /s : サブフォルダをコピーする
- /e : 空フォルダをコピーする

### 再帰削除

``` bat
rem rm -rfの代替
rm /s /q %対象ディレクトリ%
rmdir /s /q %対象ディレクトリ%
```

### find(grep)

``` bat
rem 通常の検索
find %word% %filepath%

rem 件数のみ
find /s %word% %filepath%

rem 指定した単語が引っかからない行
find /v %word% %filepath%
```

### パイプ

### findstr

``` bat
@rem ダブルクォーテーションで囲まなければいけない。シングルクォーテーションはNG。
findstr /s /i /n "検索文字列" "検索対象パス"
```

#### findstr:オプション

| オプション | 効果 |
| :------  | :-- |
| /s       | 再帰検索する。 |
| /n       | 検索結果に行番号を表示する。 |
| /i       | 大文字小文字の違いを無視する。 |

### ファイルサイズを取得する(where)

``` bat
where /R %検索対象パス% * /T > %実行結果出力パス%
```

#### 参考

- [【Windows10】コマンドプロンプトでファイルサイズ一覧を簡単に作成する方法(where):梅屋ラボ](https://umeyalabo.com/cmd_where)

### xcopy 

``` bat
xcopy /S /E /F /G /H /R /K /Y SOURCE DESTINATION
```

#### 参考

- [XCOPY コマンドでディレクトリとファイルの再帰的なコピー:Landscape - エンジニアのメモ 2006-04-13](http://sonic64.com/2006-04-13.html)

### サービスの停止/起動

``` bat
@REM 停止
net stop %service_name%

@REM 起動
net start %service_name%
```
