# コマンドプロンプト/PowerShell

- [コマンドプロンプト/PowerShell](#コマンドプロンプトpowershell)
  - [tail](#tail)
  - [grep](#grep)
    - [再帰grep](#再帰grep)

## tail

``` powershell
Get-Content -Path ${ファイルパス} -Tail 0 -Wait [-Encoding ${encode}]
```

## grep

``` powershell
Select-String -Path ${ファイルパス} -Pattern ${検索文字列}
```

### 再帰grep

``` powershell
dir -Recurse | Select-String -Pattern ${検索文字列}
```

