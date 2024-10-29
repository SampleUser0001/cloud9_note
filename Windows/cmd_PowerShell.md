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
    - [Excel -\> TSV](#excel---tsv)
    - [tsv -\> Excel](#tsv---excel)
      - [PowerShellスクリプト例：TSVからExcelへの変換](#powershellスクリプト例tsvからexcelへの変換)
      - [スクリプトの使い方](#スクリプトの使い方)
      - [変更点の説明](#変更点の説明)
      - [注意点](#注意点)
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
  - [MD5ハッシュ値取得](#md5ハッシュ値取得)


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

### Excel -> TSV

ChatGPTによる生成。まだ試せていない。

```powershell
param (
    [string]$inputFilePath,
    [string]$outputFilePath,
    [string]$sheetName,
    [bool]$preserveNewLines
)

if (-not $inputFilePath -or -not $outputFilePath -or -not $sheetName -or ($preserveNewLines -eq $null)) {
    Write-Error "Usage: .\ExcelToTsv.ps1 -inputFilePath <InputExcelFilePath> -outputFilePath <OutputTsvFilePath> -sheetName <SheetName> -preserveNewLines <true|false>"
    exit 1
}

# Excel COMオブジェクトを作成
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false

try {
    # Excelファイルを開く
    $workbook = $excel.Workbooks.Open($inputFilePath)
    $sheet = $workbook.Sheets.Item($sheetName)

    if (-not $sheet) {
        Write-Error "Sheet '$sheetName' not found in the workbook."
        exit 1
    }

    # 使用されている範囲を取得
    $range = $sheet.UsedRange
    $data = $range.Value2

    # データをTSV形式に変換
    $tsvContent = ""
    for ($i = 1; $i -le $data.GetLength(0); $i++) {
        $line = ""
        for ($j = 1; $j -le $data.GetLength(1); $j++) {
            $cellValue = $data[$i, $j]
            if ($preserveNewLines) {
                $cellValue = $cellValue -replace "\r\n|\n|\r", "`n"
            } else {
                $cellValue = $cellValue -replace "\r\n|\n|\r", " "
            }
            if ($j -eq 1) {
                $line += $cellValue
            } else {
                $line += "`t" + $cellValue
            }
        }
        $tsvContent += $line + "`r`n"
    }

    # TSVファイルに書き込み
    Set-Content -Path $outputFilePath -Value $tsvContent -Encoding UTF8

    Write-Output "TSVファイルへの出力が完了しました: $outputFilePath"
}
catch {
    Write-Error "エラーが発生しました: $_"
}
finally {
    # Excelを閉じてリソースを解放
    if ($workbook) { $workbook.Close($false) }
    if ($excel) { $excel.Quit() }
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($sheet) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($workbook) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
}

```

### tsv -> Excel

ChatGPTによる生成。まだ試していない。

PowerShellを使って、TSVファイルの内容をExcelファイルに変換するスクリプトも作成することができます。このスクリプトでは、Excel COMオブジェクトを利用して、TSVファイルを読み込み、それを新しいExcelワークブックに書き込みます。

以下に、TSVからExcelに変換するPowerShellスクリプトの例を示します。

#### PowerShellスクリプト例：TSVからExcelへの変換

```powershell
# 起動引数の確認
param (
    [string]$tsvFilePath,
    [string]$outputExcelPath,
    [string]$sheetName = "Sheet1"
)

if (-not $tsvFilePath -or -not $outputExcelPath) {
    Write-Error "Usage: .\TsvToExcel.ps1 -tsvFilePath <TsvFilePath> -outputExcelPath <OutputExcelPath> [-sheetName <SheetName>]"
    exit 1
}

# TSVファイルの内容を読み込む
$tsvContent = Get-Content -Path $tsvFilePath

# Excel COMオブジェクトを作成
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $false

# 新しいExcelワークブックを作成
$workbook = $excel.Workbooks.Add()
$sheet = $workbook.Sheets.Item(1)
$sheet.Name = $sheetName

# TSVデータをExcelシートに書き込み
$rowIndex = 1
foreach ($line in $tsvContent) {
    $columns = $line -split "`t"
    $columnIndex = 1
    foreach ($value in $columns) {
        $sheet.Cells.Item($rowIndex, $columnIndex).Value2 = $value
        $columnIndex++
    }
    $rowIndex++
}

# Excelファイルを保存
$workbook.SaveAs($outputExcelPath)

# Excelを閉じてリソースを解放
$workbook.Close($true)
$excel.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($sheet) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($workbook) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null

Write-Output "Excelファイルへの変換が完了しました: $outputExcelPath"
```

#### スクリプトの使い方

このスクリプトを実行するには、起動引数として以下の情報を渡す必要があります：
1. **TSVファイルのパス** (`-tsvFilePath`)。
2. **出力するExcelファイルのパス** (`-outputExcelPath`)。
3. **シート名**（任意） (`-sheetName`)。デフォルトは `"Sheet1"` です。

例えば、次のように実行します。

```powershell
.\TsvToExcel.ps1 -tsvFilePath "C:\path\to\your\file.tsv" -outputExcelPath "C:\path\to\your\output.xlsx" -sheetName "MyDataSheet"
```

#### 変更点の説明

1. **起動引数の定義**：
   - `param` ブロックでスクリプトの起動引数を受け取るようにしました。
   - `$tsvFilePath`, `$outputExcelPath`, `$sheetName` の3つの引数を受け取ります（`$sheetName` はオプションで、デフォルト値は `"Sheet1"`）。

2. **TSVデータの読み込み**：
   - `Get-Content` コマンドを使ってTSVファイルの各行を読み込みます。

3. **Excelファイルへの書き込み**：
   - Excel COMオブジェクトを作成して、新しいExcelワークブックを生成します。
   - シートに対して、各行・列のデータを書き込みます。

4. **Excelファイルの保存**：
   - `$workbook.SaveAs($outputExcelPath)` でExcelファイルとして保存します。

#### 注意点

- ExcelのCOMオブジェクトを利用しているため、実行環境にはExcelがインストールされている必要があります。
- TSVファイルの各行はタブで区切られていることを前提としています。TSVファイル内に不正なデータが含まれていると、Excelへの書き込みでエラーが発生する可能性があるので、必要に応じてTSVファイルの内容を確認してください。

このスクリプトを使って、TSVファイルのデータをExcelに変換する作業が簡単にできるはずです。何か追加の機能やカスタマイズが必要であれば教えてください。

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

## MD5ハッシュ値取得

``` bat
certutil -hashfile %filepath% MD5
```

