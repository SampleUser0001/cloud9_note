# Linux

- [Linux](#linux)
  - [フォルダのサイズを確認する(duコマンド)](#フォルダのサイズを確認するduコマンド)
  - [scpコマンド](#scpコマンド)
    - [scp 参考](#scp-参考)
  - [ファイル名にDateを使う](#ファイル名にdateを使う)
  - [freeコマンド](#freeコマンド)
  - [シンボリックリンク(lnコマンド)](#シンボリックリンクlnコマンド)
  - [grep](#grep)
    - [IPアドレスを抽出する](#ipアドレスを抽出する)
      - [参考](#参考)
    - [特定のファイルを除外する](#特定のファイルを除外する)
      - [参考](#参考-1)
    - [バイナリファイルを無視する](#バイナリファイルを無視する)
      - [オプション一覧](#オプション一覧)
      - [参考](#参考-2)
  - [バイナリファイルかどうか確認する(fileコマンド)](#バイナリファイルかどうか確認するfileコマンド)
- [Shell](#shell)
  - [ディレクトリ配下のファイルでループする](#ディレクトリ配下のファイルでループする)
  - [ファイルを一行ずつ読み込んでループする](#ファイルを一行ずつ読み込んでループする)
  - [起動引数を使う](#起動引数を使う)
  - [部分文字列の取得](#部分文字列の取得)
    - [部分文字列の取得：参考](#部分文字列の取得参考)
  - [シェルの実行ディレクトリを取得する](#シェルの実行ディレクトリを取得する)
    - [例：シェルの実行ディレクトリを取得する](#例シェルの実行ディレクトリを取得する)

## フォルダのサイズを確認する(duコマンド)

```
du -ms <パス> | sort -nr
```

- \-m
  - MB単位表示
- \-s
  - 総計を表示

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


# Shell

## ディレクトリ配下のファイルでループする

```
for file in $(pwd)/<対象ディレクトリ>/* ; do
    echo ${file}
done 
```

## ファイルを一行ずつ読み込んでループする

```
while read data ; do
    echo ${data}
done << <対象ファイル>
```

## 起動引数を使う

シェル
```sh
#!/bin/bash

echo $1
echo $2
```

実行結果
```
ittimfn@DESKTOP-N4JLN1S:~/cloud9_note/tmp$ sh start.sh hoge piyo
hoge
piyo
```

## 部分文字列の取得

※WSL2だと動かない。
```
${変数名:開始位置:取得文字数}
```
- 変数名に「$」は不要。
- 開始位置は0基底。

シェル
```
#!/bin/bash

HOGE="abcdef"

# オフセット位置から長さ分を取得
echo ${HOGE:0:2}
# -> ab

echo ${HOGE:2:2}
# -> cd

echo ${HOGE:4:2}
# -> ef

# 長さを省略した場合はオフセットから最後まで出力
echo ${HOGE:2}
# -> cdef

# 長さにマイナスを指定した場合は最後からマイナス分引いた位置までの長さになる
echo ${HOGE:0:-2}
# -> abcd

# オフセットの位置にマイナスを指定した場合は文法として別のパラメータ展開になる(デフォルト値の指定)
# 指定した変数が空文字列の場合は右に指定した文字が入る
echo ${HOGE:-2}
# -> abcdef
HOGE=
echo ${HOGE:-2}
# -> 2
```
実行結果
```
ab
cd
ef
cdef
abcd
abcdef
2
```

### 部分文字列の取得：参考

[Qiita:bashで変数から部分文字列を取得する](https://qiita.com/koara-local/items/04d3efd1031ea62d8db5)

## シェルの実行ディレクトリを取得する

```
`dirname $0`
```

### 例：シェルの実行ディレクトリを取得する

```sh:test.sh
#!/bin/bash

echo `dirname $0`
```

ファイルパス
```
ittimfn@penguin:~/cloud9_note/tmp$ pwd
/home/ittimfn/cloud9_note/tmp
ittimfn@penguin:~/cloud9_note/tmp$ ls
test.sh
```

shがあるディレクトリで実行
```
ittimfn@penguin:~/cloud9_note/tmp$ sh test.sh 
.
```

shより上のディレクトリで実行
```
ittimfn@penguin:~$ sh ./cloud9_note/tmp/test.sh 
./cloud9_note/tmp
```

shより下のディレクトリで実行
```
ittimfn@penguin:~/cloud9_note/tmp/tmp2$ sh ../test.sh 
..
```