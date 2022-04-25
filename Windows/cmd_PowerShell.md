# コマンドプロンプト/PowerShell

- [コマンドプロンプト/PowerShell](#コマンドプロンプトpowershell)
  - [PowerShell](#powershell)
    - [tail](#tail)
      - [参考](#参考)
    - [grep](#grep)
      - [再帰grep](#再帰grep)
    - [find](#find)
  - [コマンドプロンプト](#コマンドプロンプト)
    - [findstr](#findstr)
      - [findstr:オプション](#findstrオプション)


## PowerShell

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
dir -Recurse | Select-String -Pattern ${検索文字列}
```

### find

``` powershell
Get-ChildItem -r -Filter "条件" -Name
```

## コマンドプロンプト

### findstr

``` cmd
findstr /s /i /n "検索文字列" "検索対象パス"
```

#### findstr:オプション

| オプション | 効果 |
| :------  | :-- |
| /s       | 再帰検索する。 |
| /n       | 検索結果に行番号を表示する。 |
| /i       | 大文字小文字の違いを無視する。 |

## touch（新しいファイルを生成する）

``` powershell
New-Item -Path . -Name "test.txt" -ItemType "file" -Value "New-Item cmdlet test."
```