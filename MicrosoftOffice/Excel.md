# Excel

- [Excel](#excel)
  - [列の値を参照して行に色を塗る](#列の値を参照して行に色を塗る)
    - [列の値を参照して行に色を塗る:参考](#列の値を参照して行に色を塗る参考)
  - [直交表プルダウン](#直交表プルダウン)
    - [仕込み](#仕込み)
    - [設定](#設定)
    - [直交表プルダウン:参考](#直交表プルダウン参考)

## 列の値を参照して行に色を塗る

1. 対象範囲の左上にセルカーソルを合わせる
2. 条件付き書式 - 新しいルールをクリック
3. 数式を使用して、書式設定するセルを決定をクリック
4. 条件と、設定する書式記載する。
   ```=${対象列}{対象行の１行目}="判定条件"```
5. セルカーソルの右下を適用範囲にドラッグ・アンド・ドロップ
6. オートフィルオプションをクリック
7. 書式のみコピーを選択

### 列の値を参照して行に色を塗る:参考

- [条件付き書式を使って特定の文字が入っている行に色を付ける:クリエアナブキのちょこテク](https://www.crie.co.jp/chokotech/detail/270/)

## 直交表プルダウン

### 仕込み

1. 表を作成する
2. 表のタイトル行を選択
3. 左上のセル名が出力されている箇所に任意のリスト名を入力
4. 表の各列を選択
5. 左上のセル名が出力されている箇所に各列の1行目を入力

### 設定

1. 左側（タイトル列）設定
   1. プルダウンを設定したい列を設定
   2. データ -> データの入力規則 -> データの入力規則
   3. 設定タブ -> 入力値の種類 -> リスト -> 仕込みの3で設定した値 -> OK
2. 右側（値列）設定
   1. プルダウンを設定したい列を設定
   2. データ -> データの入力規則 -> データの入力規則
   3. 設定タブ -> 入力値の種類 -> リスト -> INDIRECT(左列の一番上のセルのアドレス(絶対アドレスは不要)) -> OK

### 直交表プルダウン:参考

- [前の選択で次の選択肢が変わる連動ドロップダウンリスト:Be COOL Users](https://www.becoolusers.com/excel/indirect-list.html)