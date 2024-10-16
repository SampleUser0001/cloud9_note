# WinMerge

- [WinMerge](#winmerge)
  - [コマンドラインでレポートを出力する](#コマンドラインでレポートを出力する)
    - [参考](#参考)

## コマンドラインでレポートを出力する

``` bat
winmergeu dir_A dir_B -minimize -noninteractive -noprefs -cfg Settings/DirViewExpandSubdirs=1 -cfg ReportFiles/ReportType=2 -cfg ReportFiles/IncludeFileCmpReport=1 -r -u -or "./winmerge_diff_report.html"
```

### 参考

[WinMergeのコマンドラインオプション:Qiita](https://qiita.com/mima_ita/items/ac21c0588080e73fc458)