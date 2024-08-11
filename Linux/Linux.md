# Linux

- [Linux](#linux)
  - [圧縮解凍(tar, gunzip)](#圧縮解凍tar-gunzip)
    - [解凍](#解凍)
      - [tar.gz解凍](#targz解凍)
      - [tar解凍](#tar解凍)
      - [gz解凍](#gz解凍)
    - [圧縮](#圧縮)
      - [tar.gz圧縮](#targz圧縮)
      - [tar圧縮](#tar圧縮)
      - [gz圧縮](#gz圧縮)
  - [別名の設定(aliasコマンド)](#別名の設定aliasコマンド)
  - [BOMの扱い](#bomの扱い)
    - [有無の確認](#有無の確認)
    - [除去](#除去)
    - [付与](#付与)
    - [参考](#参考)
  - [フォルダのサイズを確認する(duコマンド)](#フォルダのサイズを確認するduコマンド)
  - [フォルダの空き容量を表示する(dfコマンド)](#フォルダの空き容量を表示するdfコマンド)
  - [文字列を編集する(sedコマンド)](#文字列を編集するsedコマンド)
    - [先頭に追記する](#先頭に追記する)
    - [指定した個所を別のファイルの内容に置換する](#指定した個所を別のファイルの内容に置換する)
    - [元のファイルの文字列を置換する](#元のファイルの文字列を置換する)
  - [列単位で編集する(awk)](#列単位で編集するawk)
  - [scpコマンド](#scpコマンド)
    - [scp 参考](#scp-参考)
  - [ファイル名にDateを使う](#ファイル名にdateを使う)
  - [dateコマンドでタイムゾーンを変更する](#dateコマンドでタイムゾーンを変更する)
  - [freeコマンド](#freeコマンド)
    - [参考](#参考-1)
  - [シンボリックリンク(lnコマンド)](#シンボリックリンクlnコマンド)
  - [grep](#grep)
    - [IPアドレスを抽出する](#ipアドレスを抽出する)
      - [参考](#参考-2)
    - [特定のファイルを除外する](#特定のファイルを除外する)
      - [参考](#参考-3)
    - [権限がないエラーを出力させない](#権限がないエラーを出力させない)
    - [ファイル名のみ出力する](#ファイル名のみ出力する)
    - [バイナリファイルを無視する](#バイナリファイルを無視する)
      - [オプション一覧](#オプション一覧)
      - [参考](#参考-4)
  - [バイナリファイルかどうか確認する(fileコマンド)](#バイナリファイルかどうか確認するfileコマンド)
  - [文字コードを変換する(iconv)](#文字コードを変換するiconv)
    - [参考](#参考-5)
  - [xargs](#xargs)
    - [パイプで受け取ったファイルパスの出力位置を任意で修正する](#パイプで受け取ったファイルパスの出力位置を任意で修正する)
  - [サービスの登録(systemd)(Ubuntu)](#サービスの登録systemdubuntu)
    - [登録方法](#登録方法)
    - [起動/停止/ステータス確認](#起動停止ステータス確認)
    - [参考](#参考-6)
  - [CPU,メモリの監視をログに出力する(vmstat, tee)](#cpuメモリの監視をログに出力するvmstat-tee)
    - [参考](#参考-7)
  - [標準出力/エラー出力を捨てる](#標準出力エラー出力を捨てる)
    - [参考](#参考-8)
  - [ログローテート](#ログローテート)
  - [ダミーファイルを作成する(ddコマンド)](#ダミーファイルを作成するddコマンド)
    - [参考](#参考-9)
  - [cat json - jq - lessを色付きにする](#cat-json---jq---lessを色付きにする)
  - [改行コード確認](#改行コード確認)
  - [改行コード変換](#改行コード変換)
    - [nkfを使う](#nkfを使う)
  - [tab -\> スペース変換(expand)](#tab---スペース変換expand)
  - [diff](#diff)
    - [差分の行数を取得する](#差分の行数を取得する)
    - [標準出力の結果の差分を取得する](#標準出力の結果の差分を取得する)
    - [タブ・スペース・開業の違いを無視する](#タブスペース開業の違いを無視する)
      - [参考](#参考-10)
  - [ファイルの行数を取得する(wc)](#ファイルの行数を取得するwc)
  - [重複排除](#重複排除)
  - [sshポートフォワーディング](#sshポートフォワーディング)
  - [GUIとCUIを切り替える](#guiとcuiを切り替える)
    - [CUIにする](#cuiにする)
      - [一時的な変更](#一時的な変更)
      - [永続的な変更](#永続的な変更)
      - [ログイン](#ログイン)
    - [GUIにする](#guiにする)
      - [一時的な変更](#一時的な変更-1)
      - [永続的な変更](#永続的な変更-1)
  - [リモートデスクトップサービス](#リモートデスクトップサービス)
    - [インストール](#インストール)
    - [起動設定](#起動設定)
  - [起動時に何らかのサービスを起動する](#起動時に何らかのサービスを起動する)
  - [ストレージのチェックと修復](#ストレージのチェックと修復)
    - [参考](#参考-11)
  - [バイナリ単位で比較する(cmp)](#バイナリ単位で比較するcmp)
  - [公開鍵作成](#公開鍵作成)
    - [sftpサーバの場合](#sftpサーバの場合)
    - [.ssh/config](#sshconfig)
  - [公開鍵削除](#公開鍵削除)
    - [クライアント](#クライアント)
    - [サーバ](#サーバ)
  - [known\_hosts(ssh鍵用のファイル)を編集する](#known_hostsssh鍵用のファイルを編集する)
    - [削除](#削除)
    - [追加](#追加)
    - [参考](#参考-12)
  - [クリップボードに貼り付ける](#クリップボードに貼り付ける)
    - [Ubuntu](#ubuntu)
  - [chmod](#chmod)
    - [シンボルモード](#シンボルモード)
  - [所属しているグループを確認する](#所属しているグループを確認する)
    - [例](#例)
    - [参考](#参考-13)
  - [tmpの自動削除](#tmpの自動削除)
    - [Ubuntu](#ubuntu-1)
      - [参考](#参考-14)
  - [設定ファイルの読み込み順](#設定ファイルの読み込み順)
    - [参考](#参考-15)
  - [パスワードを保存する(.netrc)](#パスワードを保存するnetrc)
  - [相対パス -\> 絶対パス(フルパス)変換](#相対パス---絶対パスフルパス変換)
  - [プロンプトを設定する](#プロンプトを設定する)
    - [設定例](#設定例)
      - [ChatGPTによる解説](#chatgptによる解説)
    - [`$PS1` の詳細](#ps1-の詳細)
    - [まとめ](#まとめ)
  - [大文字 -\> 小文字](#大文字---小文字)

## 圧縮解凍(tar, gunzip)

### 解凍

#### tar.gz解凍

``` sh
tar zxvf ${対象ファイル}.tar.gz
```

#### tar解凍

``` sh
tar xvf ${対象ファイル}.tar
```

#### gz解凍

``` sh
gunzip -k ${対象ファイル}.gz
```

または

``` sh
gzip -d ${対象ファイル}.gz
```

### 圧縮

#### tar.gz圧縮

``` sh
tar zcvf ${対象ファイル}.tar.gz ${対象ディレクトリ}
```

#### tar圧縮

``` sh
tar cvf ${対象ファイル}.tar ${対象ディレクトリ}
```

#### gz圧縮

```sh
gzip -r ${対象ディレクトリ}
```

## 別名の設定(aliasコマンド)

`${HOME}/.bashrc`にでも書いておくといいんでね？

``` bash
alias 別名=元のコマンド
# スペースを含む場合はダブルクォーテーションで囲む。
```

## BOMの扱い

### 有無の確認

``` bash
file ${filepath}
```

### 除去

``` bash
vi -c 'set nobomb' -c 'wq!' ${filepath}
```

### 付与

``` bash
vi -c 'set bomb' -c 'wq!' ${filepath}
```

### 参考

- [UTF-8のBOM付きとBOMなしを変換する方法（Linux）:minory](https://minory.org/linux-utf-8-bom.html)

## フォルダのサイズを確認する(duコマンド)

```sh
du -ms <パス> | sort -nr
```

- \-m
  - MB単位表示
- \-s
  - 総計を表示

## フォルダの空き容量を表示する(dfコマンド)

``` sh
df -hT /dev/xvda1
```

## 文字列を編集する(sedコマンド)

### 先頭に追記する

``` sh
sed -i '1i${記載したい文字列}' ${ファイルパス}

# まとめて書く
sed -i '1i${記載したい文字列}' *.sql
```

### 指定した個所を別のファイルの内容に置換する

``` sh
$ cat file1 
# この下を何かに置換したい
${basicauth}
``` 

``` sh
$ cat basicauth 
    hoge
    piyo
    fuga
```

``` sh
# 問題のコマンド
$ sed -e '/${basicauth}/r basicauth' file1 -e '/${basicauth}/d'
# この下を何かに置換したい
    hoge
    piyo
    fuga
```

### 元のファイルの文字列を置換する

``` sh
sed -i 's/${変換前}/${変換後}/g' ${ファイルパス}
```

## 列単位で編集する(awk)

```bash
#!/bin/bash

input_file="file"
output_file="output.csv"

awk -F' ' '{ print $1 "," toupper($2) "," $3 }' "$input_file" > "$output_file"
```

- -Fで区切り文字を指定。
- printで出力する。$1, $2, $3 ...で項目を選択。
- toupperはawkの関数。

## scpコマンド

```
scp <ローカルパス> <ユーザ名>@<接続先ホスト>:<コピー先パス>
```
### scp 参考

[Qiita:scpコマンド](https://qiita.com/chihiro/items/142ebe6980a498b5d4a7)

## ファイル名にDateを使う

```
cp -p <ファイル名> <ファイル名>`date "+%Y%m%d_%H%M%S"`.<拡張子>
```

## dateコマンドでタイムゾーンを変更する

```bash
$ date -d '2024-01-24 10:00:00 +0000' +'%Y-%m-%d %H:%M:%S'
2024-01-24 19:00:00
```

## freeコマンド
メモリの調査を行う

|オプション|効果|
|:---|:---|
|-s <数字>|<数字>秒ごとに表示|
|-b, -k, -m|xxxバイト単位で表示|
|-t|物理メモリ、スワップメモリの合計を表示|

実行例
```sh
$ free -s 5 -mt
              total        used        free      shared  buff/cache   available
Mem:           3933         508        2114         251        1309        2995
Swap:             0           0           0
Total:         3933         508        2114

              total        used        free      shared  buff/cache   available
Mem:           3933         508        2114         251        1309        2995
Swap:             0           0           0
Total:         3933         508        2114

              total        used        free      shared  buff/cache   available
Mem:           3933         508        2114         251        1309        2995
Swap:             0           0           0
Total:         3933         508        2114
```

### 参考

- [Qiita:Linux負荷監視コマンドまとめ](https://qiita.com/aosho235/items/c4d6995743dd1dac16e1)

## シンボリックリンク(lnコマンド)

シンボリックリンクを貼る
```sh
ln -s <リンク先パス> <入口>
```

シンボリックリンクを削除する
```sh
unlink <入口>
```

## grep

### IPアドレスを抽出する

厳密にはIPではないが…
```
grep -rE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' .
```

#### 参考

- [conf t:grepでIPアドレスを抽出する](https://monaski.hatenablog.com/entry/2015/12/14/173753)

### 特定のファイルを除外する

```
--exclude=<ファイル名>
```

#### 参考

- [Linuxエンジニアの備忘Log:特定のファイルやディレクトリをgrep結果から除却](http://www.sooota.com/%E7%89%B9%E5%AE%9A%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%84%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%82%92grep%E7%B5%90%E6%9E%9C%E3%81%8B%E3%82%89%E9%99%A4%E5%8D%B4/)

### 権限がないエラーを出力させない

``` sh
grep ${検索条件} 2> /dev/null
```

### ファイル名のみ出力する

``` sh
grep -ril ${検索条件} 
```

### バイナリファイルを無視する

```
--binary-files=without-match
```


#### オプション一覧

| オプション | 効果 |
| :--      | :--- |
| binaly | 「一致しました」と表示 |
| text | バイナリの中身を表示 |
| without-match | 無視する |

#### 参考

- [揮発性のメモ２:grepでバイナリファイルを無視する](https://iww.hateblo.jp/entry/20150724/binary_files_without_match)

## バイナリファイルかどうか確認する(fileコマンド)

```
file --mime <対象ファイル>
```

## 文字コードを変換する(iconv)

実行例：Shift-JISからUTF-8に変換する。

``` sh
iconv --f sjis -t utf8 ${変換対象ファイル}
```

### 参考

- [atmarkit:【 iconv 】コマンド——文字コードを変換する](https://www.atmarkit.co.jp/ait/articles/1609/12/news019.html)

## xargs

### パイプで受け取ったファイルパスの出力位置を任意で修正する

``` sh
find . -type f | xargs -I{} bash -c "iconv --f sjis -t utf8 {} > iconv_utf8_{}
```

別解

``` bash
find . -type f | while read file; do
    echo $file
done
```

## サービスの登録(systemd)(Ubuntu)

### 登録方法

1. /usr/lib/systemd/system配下に*.serviceのファイル名でファイル作成
2. 作成したファイルの中身を記載する。
3. ```sudo systemctl enable <サービス>.service```

[Install]が書いてあればシンボリックリンクは勝手に貼ってくれるはず。```/etc/systemd/system```配下のディレクトリに作成される。

### 起動/停止/ステータス確認

起動

``` sh
systemctl start <サービス名>
```

停止

``` sh
systemctl stop <サービス名>
```

ステータス

``` sh
systemctl status <サービス名>
```

### 参考

- [YUUKO's経験値:Ubuntu環境で自分で作ったサービスをシステムに登録する方法](https://yuukou-exp.plus/ubuntu-register-my-service-to-system/)
- [cles::blog:CentOS 7 で自分でビルドした apache を使うと systemctl start が戻ってこない](https://blog.cles.jp/item/9413)
- [Github:SampleUser0001:Transfer_service_memlog](https://github.com/SampleUser0001/Transfer_service_memlog)

## CPU,メモリの監視をログに出力する(vmstat, tee)

``` sh
vmstat -tn {出力間隔(秒)} | tee {ログファイル名} 
```

出力例

``` txt
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu----- -----timestamp-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st                 JST
 0  1      0 4356844  32664 1148536    0    0    54     1   15   79  0  0 99  0  0 2021-03-04 09:15:13
 0  0      0 4358884  32664 1148536    0    0    28     0   66  432  0  0 99  0  0 2021-03-04 09:15:14
 0  0      0 4358884  32664 1148536    0    0     0     0   61  407  0  0 100  0  0 2021-03-04 09:15:15
 0  0      0 4358884  32664 1148536    0    0     0     0   46  361  0  0 100  0  0 2021-03-04 09:15:16
 0  0      0 4358884  32664 1148536    0    0     0     0   47  366  0  0 100  0  0 2021-03-04 09:15:17
 0  0      0 4358884  32664 1148536    0    0     0     0   54  386  0  0 100  0  0 2021-03-04 09:15:18
 0  0      0 4358884  32672 1148528    0    0     0    32   66  427  0  0 99  1  0 2021-03-04 09:15:19
 0  0      0 4358884  32672 1148528    0    0     0     0   56  396  0  0 100  0  0 2021-03-04 09:15:20
 0  0      0 4358900  32672 1148584    0    0     0     0   59  392  0  0 100  0  0 2021-03-04 09:15:21
 0  0      0 4358900  32672 1148584    0    0     0     0   47  361  0  0 100  0  0 2021-03-04 09:15:22
 0  0      0 4358900  32672 1148584    0    0     0     0   67  417  0  0 100  0  0 2021-03-04 09:15:23
 0  0      0 4358900  32672 1148584    0    0     0     0   71  439  0  0 100  0  0 2021-03-04 09:15:24
 0  0      0 4358900  32680 1148576    0    0     0    12   74  454  0  0 99  1  0 2021-03-04 09:15:25
 0  0      0 4358900  32680 1148576    0    0     0     0   63  410  0  0 100  0  0 2021-03-04 09:15:26
 0  0      0 4358900  32680 1148576    0    0     0     0   45  351  0  0 100  0  0 2021-03-04 09:15:27
 0  0      0 4358900  32680 1148576    0    0     0     0   66  409  0  0 100  0  0 2021-03-04 09:15:28
 0  0      0 4358900  32680 1148576    0    0     0     0   74  435  0  0 100  0  0 2021-03-04 09:15:29
 0  0      0 4358900  32680 1148576    0    0     0     0   34  242  0  0 100  0  0 2021-03-04 09:15:30
 0  0      0 4358900  32688 1148568    0    0     0    12  113  536  0  0 99  1  0 2021-03-04 09:15:31
 0  0      0 4358900  32688 1148568    0    0     0     0   47  359  0  0 100  0  0 2021-03-04 09:15:32
 0  0      0 4358900  32688 1148568    0    0     0     0   57  385  0  0 100  0  0 2021-03-04 09:15:33
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu----- -----timestamp-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st                 JST
 2  0      0 4358900  32688 1148568    0    0     0     0   61  400  0  0 100  0  0 2021-03-04 09:15:34
 0  0      0 4358900  32688 1148568    0    0     0     0   59  406  0  0 100  0  0 2021-03-04 09:15:35
 0  0      0 4358900  32688 1148568    0    0     0     0   53  374  0  0 100  0  0 2021-03-04 09:15:36
 0  0      0 4358900  32696 1148560    0    0     0    12   59  392  0  0 100  0  0 2021-03-04 09:15:37
 0  0      0 4358900  32696 1148560    0    0     0     0   57  397  0  0 100  0  0 2021-03-04 09:15:38
```

### 参考

- [プログラミングを学ぶ:【Linux】CPUとメモリの負荷と使用率をタイムスタンプ付きでログに残す](https://pg.echo-s.net/%E3%80%90linux%E3%80%91cpu%E3%81%A8%E3%83%A1%E3%83%A2%E3%83%AA%E3%81%AE%E8%B2%A0%E8%8D%B7%E3%81%A8%E4%BD%BF%E7%94%A8%E7%8E%87%E3%82%92%E3%82%BF%E3%82%A4%E3%83%A0%E3%82%B9%E3%82%BF%E3%83%B3%E3%83%97/)
- [atmarkit:
【 vmstat 】コマンド——仮想メモリやディスクI/Oの統計情報を表示する](https://www.atmarkit.co.jp/ait/articles/1707/13/news015.html)
  - vmstatのオプションについて

## 標準出力/エラー出力を捨てる

標準出力

``` sh
${何らかのコマンド} 1> /dev/null
```

エラー出力

``` sh
${何らかのコマンド} 2> /dev/null
```

### 参考

- [Qiita:bashで標準出力、エラーを捨てるとか、ファイルディスクリプタ](https://qiita.com/harasakih/items/868a850fcdc99a2c37b0)
- [UNIX/Linuxの部屋 用語集:リダイレクト:用語集 リダイレクト コマンドの出力をファイルや別のコマンドに振り分ける (リダイレクション・パイプ) ](http://x68000.q-e-d.net/%7E68user/unix/pickup?%A5%EA%A5%C0%A5%A4%A5%EC%A5%AF%A5%C8)

## ログローテート

[logrotate.md](./logrotate.md)

## ダミーファイルを作成する(ddコマンド)

``` sh
dd if=/dev/zero of=${ファイルパス} bs=1${ファイルサイズ単位} count=${サイズ}
```

実行例

``` sh
dd if=/dev/zero of=15G.dummy bs=1G count=15
```

### 参考

- [Qiita:Linux で任意のサイズのファイルを作る](https://qiita.com/toshihirock/items/6cb99a85d86f524bc153)

## cat json - jq - lessを色付きにする

``` sh
cat ${任意のファイル} | jq '.' -C | less -R
```

## 改行コード確認

``` sh
# バイナリ形式で表示する。
od -c ${対象ファイル}

# 文字コードと改行コードを両方表示する。
nkf --guess ${対象ファイル}
```

## 改行コード変換

``` sh
tr '変換元改行コード' '変換先改行コード' < 変換元ファイルパス > 変換先ファイルパス
```

### nkfを使う

``` sh
# UTF-8に変換して上書きする
nkf -w --overwrite ${ファイルパス}

# 改行コードをLFに変換して上書きする
nkf -Lu --overwrite ${ファイルパス}
```

## tab -> スペース変換(expand)

``` bash
expand -t ${スペースの個数} ${ファイルパス}
```

## diff

### 差分の行数を取得する

``` sh
diff ${ファイルパス1} ${ファイルパス2} | grep "^>" | wc -l
```

### 標準出力の結果の差分を取得する

``` sh
diff <(...) <(...)
```

``` sh
diff <(cat hoge.json | jq '.') <(cat piyo.json | jq '.')
```
みたいな感じで使う。

### タブ・スペース・開業の違いを無視する

| オプション | 意味 |
| :--------- | :--- |
| -E | タブとスペースの違いを無視するが・・・タブはスペース8個に換算される。 |
| -b | スペースの個数の違いを無視する。 |
| -w | スペースの違いを無視する。 | 
| -B | 空行を無視する。 |


#### 参考

- [diffで空白を無視する:適当なメモ](https://boscono.hatenablog.com/entry/20130126/p1)

## ファイルの行数を取得する(wc)

``` sh
cat ${ファイルパス} | wc -l
```

## 重複排除

``` sh
cat ${対象ファイル} | sort | uniq
```

## sshポートフォワーディング

``` sh
ssh -2 -N -f -L ${LOCAL_PORT}:${接続先ホスト名}:${接続先ポート番号} ${SSH2_USER}@${SSH2_HOST} -p ${SSH2_PORT}
```

** 使用終了時にプロセスをkillすること。**

## GUIとCUIを切り替える

### CUIにする

#### 一時的な変更

``` sh
systemctl isolate multi-user.target
```

#### 永続的な変更

``` sh
systemctl set-default multi-user.target
```

#### ログイン

Ctrl + Alt + F1 〜 F5

### GUIにする

#### 一時的な変更

``` sh
systemctl isolate graphical.target
```

#### 永続的な変更

``` sh
systemctl set-default graphical.target
```

## リモートデスクトップサービス

### インストール

``` sh
apt update && sudo apt upgrade -y
sudo apt install -y xrdp
```

### 起動設定

``` sh
sudo systemctl enable xrdp
sudo systemctl start xrdp
```

## 起動時に何らかのサービスを起動する

Ubuntuでは通常systemctlを使用するらしいが・・・

```sh
crontab -e
```

``` crontab
@reboot /etc/rc.local
```

``` sh
touch /etc/rc.local
nano /etc/rc.local
```

``` sh
# /etc/rc.localに起動したいサービスを書く
```

``` sh
chmod 755 /etc/rc.local
```

## ストレージのチェックと修復

``` bash
# ストレージの調査
sudo fdisk -l


# 不良セクタのチェック
sudo badblocks -v -s ${調査対象のストレージ} | tee /tmp/badblocks.txt

# 不良セクタのマーキング
e2fsck -l /tmp/badblocks.txt
```

### 参考

- [Linuxでディスクのエラーや不良セクタのチェックと修正をする方法 : Hack](https://kaworu.jpn.org/ubuntu/Linux%E3%81%A7%E3%83%87%E3%82%A3%E3%82%B9%E3%82%AF%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%82%84%E4%B8%8D%E8%89%AF%E3%82%BB%E3%82%AF%E3%82%BF%E3%81%AE%E3%83%81%E3%82%A7%E3%83%83%E3%82%AF%E3%81%A8%E4%BF%AE%E6%AD%A3%E3%82%92%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95)

## バイナリ単位で比較する(cmp)

``` bash 
cmp ${file1} ${file2}
```

## 公開鍵作成

Github認証や、sftp認証で使用する。

``` bash
ssh-keygen -t rsa
# 作成するファイルパスを入力
# 基本的には${HOME}/.ssh/配下を指定。

# パスワードを入力
# パスワードを入力

# 拡張子が.pubのファイルが公開鍵。接続先サーバに配置する。配置方法は接続先のサービスに依存。
```

### sftpサーバの場合

``` bash
# サーバ側

# ユーザ作成
sudo useradd ${new_user}
sudo passwd ${new_user}
# パスワード入力

```

``` bash
# クライアント側
cd ~/.ssh

# 公開鍵作成
ssh-keygen -t rsa

# 公開鍵転送
ssh-copy-id -p ${port} -i ${公開鍵ファイルパス} ${サーバ側user}@${サーバホスト名}
```

``` bash
# サーバ側

# ファイルがあることを確認する。
su - ${new_user}

cd ~/.ssh
ls -all

# ※clientuser/.ssh/*.pub ファイルの中身がサーバ側の$HOME/.ssh/authorized_keysに記載されていること。
# ディレクトリ権限は700, authorized_keysは600であること。(クライアント、サーバ両方)
```

``` bash
# 接続
sftp ${サーバ側ユーザ}@${サーバホスト}
# 鍵生成時にパスフレーズを設定している場合は、ここで入力する。
```

### .ssh/config

```
Host ホスト名
  HostName ホスト名
  User 接続先ユーザ名
  IdentityFile 秘密鍵パス
  IdentitiesOnly yes
```

## 公開鍵削除

`ssh-remove-id`というコマンドがあるらしいが、今回は使用しない。

### クライアント

``` bash
# known_hostsから削除する
ssh-keygen -R ${サーバ名}

# ~/.ssh/configから削除。手動。
# 公開鍵、秘密鍵を削除。rmコマンド実行。
```

### サーバ

コマンドは見当たらない。  
`~/.ssh/authorized_keys`から削除する必要があるが、`@revoked`をつけて無効化する。

## known_hosts(ssh鍵用のファイル)を編集する

### 削除

``` bash
ssh-keygen -R $hostname
ssh-keygen -R $ip_address
ssh-keygen -R $hostname,$ip_address
```

### 追加

``` bash
ssh-keyscan -H $hostname,$ip_address >> ~/.ssh/known_hosts
ssh-keyscan -H $ip_address >> ~/.ssh/known_hosts
ssh-keyscan -H $hostname >> ~/.ssh/known_hosts
```

### 参考

- [新しいホストをknown_hostsに追加する:Qiita](https://qiita.com/ntatsuya/items/cee0ed6eaeaf2aea19fc)

## クリップボードに貼り付ける

### Ubuntu

``` sh
# xselがインストールされていない可能性がある。
cat ${ファイルパス} | xsel --clipboard --input
```

## chmod

### シンボルモード

| 記号 | 意味 |
| :--- | :--- |
| u | 所有者 | 
| g | グループ |
| o | グループ外 |
| a | すべて |

| 記号 | 意味 |
| :--- | :--- |
| + | 追加 |
| - | 削除 |

| 記号 | 意味 |
| :--- | :--- |
| r | 読み込み |
| w | 書き込み |
| x | 実行 |

## 所属しているグループを確認する

``` bash
less /etc/group
```

### 例

``` txt
docker:x:999:ubuntuuser
```

- グループ : docker 
- 暗号化されたパスワード
- グループID : 999
- 所属ユーザ : ubuntuuser

### 参考

- [Linux グループ一覧の確認と/etc/group ファイル:kazmax Linuxで自宅サーバー](https://kazmax.zpp.jp/linux_beginner/etc_group.html)

## tmpの自動削除

### Ubuntu

``` bash
# systemd-tmpfiles-clean.timerで削除する。
sudo systemctl cat systemd-tmpfiles-clean.timer
```

``` sh
...
[Timer]
OnBootSec=15min
OnUnitActiveSec=1d
```

``` bash
# 削除対象ディレクトリ
cat /usr/lib/tmpfiles.d/tmp.conf
```

#### 参考

- [[Amazon linux 2] /tmp配下の自動削除:Qiita](https://qiita.com/yoshii0110/items/248c828ca0284d826006)

## 設定ファイルの読み込み順

1. `/etc/profile`
2. 下記のいずれか
    1. `~/.bash_profile`
    2. `~/.bash_login`
    3. `~/.profile`
3. `~/.bashrc`
4. `/etc/bashrc`

### 参考

- [環境変数の設定(~/.bash_profile, ~/.bashrc):わくわくBank](https://www.wakuwakubank.com/posts/389-linux-bashrc/)

## パスワードを保存する(.netrc)

`${HOME}/.netrc`ファイルを作成する。  
もとはFTPのためのユーザ設定ファイルだが、gitもこのファイルを参照する。

``` bash
# ファイル作成
touch ${HOME}/.netrc
chmod 600 ${HOME}/.netrc
```

``` txt
machine ${ドメイン名}
login ${id}
password ${password}
```

## 相対パス -> 絶対パス(フルパス)変換

``` bash
echo ${filepath} | xargs readlink -f
```

## プロンプトを設定する

### 設定例

``` bash
$ echo $PS1
${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)" 2>/dev/null) $
```

#### ChatGPTによる解説

このプロンプト環境変数 (`$PS1`) は、Bash シェルのプロンプトの表示を制御します。具体的には、シェルのコマンドラインに表示される情報を指定します。以下、この構成を詳しく説明します。

### `$PS1` の詳細

1. **`${debian_chroot:+($debian_chroot)}`**:
   - もし `debian_chroot` という環境変数が設定されていれば、その値をカッコ内に表示します。Debian や Ubuntu などの一部の Linux ディストリビューションでは、chroot 環境で作業している場合、この変数が設定されます。

2. **`\[\033[01;32m\]`**:
   - この部分はエスケープシーケンスで、次に表示されるテキストの色やスタイルを指定します。`01;32m` は太字の緑色を意味します。

3. **`\u@\h`**:
   - `\u` は現在のユーザー名を表示し、`@` の後に続く `\h` はホスト名（マシン名）を表示します。これにより、プロンプトに「ユーザー名@ホスト名」が表示されます。

4. **`\[\033[00m\]`**:
   - これもエスケープシーケンスで、テキストスタイルをリセット（通常の表示に戻す）します。

5. **`: `**:
   - コロン（`: `）が表示されます。

6. **`\[\033[01;34m\]\w\[\033[00m\]`**:
   - これもエスケープシーケンスを使用しています。`01;34m` は太字の青色を指定し、`\w` は現在の作業ディレクトリ（カレントディレクトリ）を表示します。その後、スタイルをリセットします。

7. **`$(__git_ps1 " (%s)" 2>/dev/null)`**:
   - これはGitリポジトリのステータスを表示します。`__git_ps1` は現在のGitブランチ名やステータスを表示するためのコマンドです。`" (%s)"` はブランチ名をカッコ内に表示することを指定しています。`2>/dev/null` はエラー出力を無視するため、Gitリポジトリでない場合でもエラーを表示しません。

8. **`$ `**:
   - 最後にプロンプトの終わりとして `$` 記号が表示され、コマンドを入力する準備ができたことを示します。

### まとめ

この `PS1` の設定により、Bash シェルのプロンプトには次のような情報が表示されます：

- (もし設定されていれば) `debian_chroot` の内容
- ユーザー名とホスト名（緑色）
- カレントディレクトリ（青色）
- 現在のGitブランチ（Gitリポジトリ内の場合）
- 最後に `$` 記号

これにより、シェルを使用する際にユーザーは現在の環境や作業場所を一目で確認できるようになっています。

## 大文字 -> 小文字

``` bash
echo ${word} | tr [:upper:] [:lower:]
```
