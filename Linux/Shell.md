# Linux Shell

- [Linux Shell](#linux-shell)
  - [ディレクトリ配下のファイルでループする](#ディレクトリ配下のファイルでループする)
    - [直下のみ](#直下のみ)
    - [再帰＋拡張子指定](#再帰拡張子指定)
  - [ファイルを一行ずつ読み込んでループする](#ファイルを一行ずつ読み込んでループする)
    - [過去のログ:その1](#過去のログその1)
    - [過去のログ:その1](#過去のログその1-1)
      - [注意点](#注意点)
  - [forをワンライナーで行う](#forをワンライナーで行う)
  - [起動引数を使う](#起動引数を使う)
  - [任意の引数を取得する](#任意の引数を取得する)
  - [関数を宣言/使用する](#関数を宣言使用する)
  - [ディレクトリ/ファイルの存在チェック](#ディレクトリファイルの存在チェック)
  - [部分文字列の取得](#部分文字列の取得)
    - [部分文字列の取得：参考](#部分文字列の取得参考)
  - [タブ区切り(空白区切り)のN番目の要素を取得する](#タブ区切り空白区切りのn番目の要素を取得する)
    - [参考](#参考)
  - [tsvを正しく読み込む](#tsvを正しく読み込む)
  - [シェルの実行ディレクトリを取得する](#シェルの実行ディレクトリを取得する)
    - [例：シェルの実行ディレクトリを取得する](#例シェルの実行ディレクトリを取得する)
  - [ファイルパスから絶対パスを取得する](#ファイルパスから絶対パスを取得する)
  - [ファイルパスからファイル名のみ取得](#ファイルパスからファイル名のみ取得)
  - [ファイルパスからディレクトリ名のみ取得](#ファイルパスからディレクトリ名のみ取得)
  - [.envファイルの読み込み方](#envファイルの読み込み方)
  - [異なる値のenvファイルを読み込む](#異なる値のenvファイルを読み込む)
    - [実行結果](#実行結果)
  - [ランダムな文字列を取得する](#ランダムな文字列を取得する)
  - [実行年月日時分秒を取得する](#実行年月日時分秒を取得する)
  - [タブを出力する](#タブを出力する)
    - [タブを出力する：参考](#タブを出力する参考)
  - [拡張子がほしい/いらない](#拡張子がほしいいらない)
    - [拡張子だけがほしい](#拡張子だけがほしい)
    - [拡張子を除外したファイル名が欲しい](#拡張子を除外したファイル名が欲しい)
    - [参考](#参考-1)
  - [配列](#配列)
    - [実行結果](#実行結果-1)
    - [参考](#参考-2)
  - [連想配列](#連想配列)
    - [参考](#参考-3)
  - [対話式のコマンドを自動化する(expect)](#対話式のコマンドを自動化するexpect)
    - [試してみた](#試してみた)
    - [参考](#参考-4)
  - [変数のスコープ](#変数のスコープ)
  - [pushd/popd](#pushdpopd)
    - [実行例](#実行例)
  - [インデントをつける](#インデントをつける)
    - [参考](#参考-5)
  - [BOMがついているUTF-8ファイルを作成する](#bomがついているutf-8ファイルを作成する)
  - [属性を維持してコピーする](#属性を維持してコピーする)
  - [環境変数を指定する](#環境変数を指定する)
  - [コマンドの戻り値を取る](#コマンドの戻り値を取る)
  - [作業ディレクトリを作成する](#作業ディレクトリを作成する)
    - [参考](#参考-6)
  - [特定の行番号を出力する](#特定の行番号を出力する)
  - [テストデータを生成する](#テストデータを生成する)

## ディレクトリ配下のファイルでループする

### 直下のみ

``` sh
for file in $(pwd)/<対象ディレクトリ>/* ; do
  echo ${file}
done 
```

### 再帰＋拡張子指定

``` sh
for file in `\find . -type f -iname "*.json" ` ; do
  echo ${file}
done 
```

## ファイルを一行ずつ読み込んでループする

``` sh
for v in `cat $filename`; do
    echo $v
done
```

### 過去のログ:その1

``` sh 
while read data; do
  echo ${data}
done << END
`cat ${filename}`
END
```

### 過去のログ:その1

``` sh 
while read data ; do
  echo ${data}
done < <対象ファイル>
```

#### 注意点

末尾にLFがある行しか読み込まない。（CRLFはNG。）

## forをワンライナーで行う

``` sh
for v in `一覧を返す処理` ; do 結果を使う処理 ; done
# 結果を使う処理内の変数は $v 。
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

## 任意の引数を取得する

``` bash
#!/bin/bash

# オプションなしの場合の初期値
aflag=0
bflag=0
bvalue=""

while getopts 'ab:' OPTION; do
  case "$OPTION" in
    a)
      aflag=1
      ;;
    b)
      bflag=1
      bvalue="$OPTARG"
      ;;
    ?)
      echo "スクリプトの使い方: $(basename $0) [-a] [-b value]" >&2
      exit 1
      ;;
  esac
done

# オプション -a が指定された場合のアクション
if [ "$aflag" -eq 1 ]; then
  echo "-a が指定されました。"
fi

# オプション -b が指定され、値が与えられた場合のアクション
if [ "$bflag" -eq 1 ]; then
  echo "-b が指定されました。値は ${bvalue} です。"
fi
```

## 関数を宣言/使用する

``` bash
# 関数宣言
# 引数が欲しい場合でも、カッコの中身は空にする。
nanrakano_kansu() {
    hikisuu1=$1
    hikisuu2=$2
}

# 関数呼び出し
# 呼び出し時にカッコは不要
nanrakano_kansu 'aaa' 'bbb'
```

## ディレクトリ/ファイルの存在チェック

``` sh
if [-e ${対象ディレクトリ/ファイル} ]; then
  # やりたい処理を書く
fi
```

## 部分文字列の取得

※WSL2だと動かない。
```
${変数名:開始位置:取得文字数}
```
- 変数名に「$」は不要。
- 開始位置は0基底。

シェル
``` sh
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

## タブ区切り(空白区切り)のN番目の要素を取得する

`cut`コマンドを使う。

``` bash
# N番目の要素を取得
pos=1

# 区切り文字がタブの場合は「何で区切るか」は省略可。
cut -f $pos ${tsvファイルパス}

# 区切り文字がタブ以外の場合は-dオプションを使う。
delimiter=' '
cut -d '$delimiter' -f $pos ${ファイルパス}
```

### 参考

- [cutコマンドでタブ区切りの1列目を取り出すには:Ninton](https://www.ninton.co.jp/archives/1993)

## tsvを正しく読み込む

`for`を使うと、行ではなく、要素単位で取得される。  
普通に`while`で回すと、区切り文字が半角スペースに変換されるため、要素に半角スペースを含んでいる場合、うまく処理できない。

``` bash
#!/bin/bash

filepath=$1
# id, nameは変数名。tsvの要素の1個目と2個目
while IFS=$'\t' read -r id name ; do
    echo -e $id '\t' $name
done << END
`cat $filepath`
END
```

## シェルの実行ディレクトリを取得する

``` bash
`dirname $0`
```

### 例：シェルの実行ディレクトリを取得する

```sh:test.sh
#!/bin/bash

echo `dirname $0`
```

ファイルパス
``` bash
ittimfn@penguin:~/cloud9_note/tmp$ pwd
/home/ittimfn/cloud9_note/tmp
ittimfn@penguin:~/cloud9_note/tmp$ ls
test.sh
```

shがあるディレクトリで実行
``` bash
ittimfn@penguin:~/cloud9_note/tmp$ sh test.sh 
.
```

shより上のディレクトリで実行
``` bash
ittimfn@penguin:~$ sh ./cloud9_note/tmp/test.sh 
./cloud9_note/tmp
```

shより下のディレクトリで実行
``` bash
ittimfn@penguin:~/cloud9_note/tmp/tmp2$ sh ../test.sh 
..
```

## ファイルパスから絶対パスを取得する

``` bash
realpath ${filepath}
```

## ファイルパスからファイル名のみ取得

``` bash
basename ${filepath}
```

## ファイルパスからディレクトリ名のみ取得

``` bash
dirname ${filepath}
```

## .envファイルの読み込み方

``` sh
export $(cat .env | grep -v ^# | xargs)
```

## 異なる値のenvファイルを読み込む

app.sh
``` bash
# !/bin/bash

source $1

echo ${env_value}

```

1.env
``` sh
env_value="1"
```

2.env
``` sh
env_value="2"
```

### 実行結果

``` bash
ec2-user:~/environment/tmp/shell/env $ bash app.sh 1.env
1
ec2-user:~/environment/tmp/shell/env $ bash app.sh 2.env
2
ec2-user:~/environment/tmp/shell/env $ 
```

## ランダムな文字列を取得する

``` bash
# hold -w ${桁数}
random_str=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
```

## 実行年月日時分秒を取得する

``` bash
now=`date '+%Y%m%d_%H%M%S'` 
```

## タブを出力する

``` sh
echo -e "\t"
```

### タブを出力する：参考

- [echoコマンドで改行やタブを扱うには@Linux bash:Mazn.net](https://www.mazn.net/blog/2009/01/06/169.html)

## 拡張子がほしい/いらない

### 拡張子だけがほしい

``` sh
for f in *.md ;do
  echo $f | sed 's/^.*\.\([^\.]*\)$/\1/'
done
```

### 拡張子を除外したファイル名が欲しい

``` sh
for f in *.md ;do
  # ファイル名取得。
  echo ${f##*/}
  # 拡張子除外
  echo ${f%.*}
done
```

### 参考

- [bashの変数展開によるファイル名や拡張子の取得:Qiita](https://qiita.com/mriho/items/b30b3a33e8d2e25e94a8)

## 配列

**bash**で起動すること。

``` bash
#!/bin/bash
# 重要：shだとエラーになる。bashコマンドの引数として渡すこと。

# 宣言
declare -a sample_list=("a" "b" "c")

# 参照
echo ${sample_list[0]}
echo ${sample_list[1]}
echo ${sample_list[2]}
echo ${sample_list[-1]}
echo ${sample_list[@]}
echo ${sample_list[*]}
echo "----"

# 要素数確認
echo ${#sample_list[@]}
echo ${#sample_list[*]}
echo "----"

# forで参照する。
# 他にも書き方はあるが、Cっぽいのがわかりやすい気がする。
for ((i = 0 ; i < ${#sample_list[@]} ; i++)) {
    echo "sample_list[$i] = ${sample_list[i]}"
}
```

### 実行結果

``` txt
a
b
c
c
a b c
a b c
----
3
3
----
sample_list[0] = a
sample_list[1] = b
sample_list[2] = c
```

### 参考

- [bash 配列まとめ:Qiita](https://qiita.com/b4b4r07/items/e56a8e3471fb45df2f59)

## 連想配列

要はMap。

``` bash
#!/bin/bash

declare -A user=([id]=1 [name]=$(whoami))

echo ${user[id]}
echo ${user[name]}
```

``` txt
$ sh app.sh 
1
ec2-user
```

### 参考

- [bash 連想配列 メモ:個人的勉強メモ置き場:はてなブログ](https://zykbgame.hateblo.jp/entry/2022/04/05/195950)

## 対話式のコマンドを自動化する(expect)

実行したいコマンドをダブルクオーテーションで囲んで、引数として渡す。  
送信するコマンドもダブルクオーテーションで囲む（エスケープする）。

``` bash
    expect -c "
    set timeout 5
    
    spawn sftp -r ${user}@${host}
    
    expect \"sftp>\"
    send \"cd ${to}\r\"
    expect \"sftp>\"
    send \"put ${from}\r\"
    
    expect \"sftp>\"
    send \"exit\"
"
```

- spawn
    - 別プロセスを起動する。
- expect
    - 条件分岐。標準出力でこれが表示されているかを確認する。
- send 
    - 実行したいコマンド。

### 試してみた

- [sftp_auto_exec_sample:SampleUser0001:Github](https://github.com/SampleUser0001/sftp_auto_exec_sample)
    - sftp-putを自動化した。

### 参考

- [Linuxの対話がめんどくさい?そんな時こそ自動化だ！-expect編-:Qiita](https://qiita.com/ine1127/items/cd6bc91174635016db9b)

## 変数のスコープ

app.sh

``` bash
#!/bin/bash

func() {
    echo $HOGE
}

HOGE=hoge
func
echo $HOGE
```

実行結果

``` bash
sh app.sh 
hoge
hoge
```

## pushd/popd

ディレクトリ移動をスタックで管理する。

- pushd
    - 指定したディレクトリをスタックに入れ、そのディレクトリに移動する。
- popd
    - スタックからディレクトリを取り出し、そのディレクトリに移動する。

### 実行例

``` txt
ec2-user:~/environment/tmp/shell/push_pop $ ls
app.sh  directory
ec2-user:~/environment/tmp/shell/push_pop $ tree .
.
├── app.sh
└── directory
    ├── file01
    ├── file02
    └── file03

1 directory, 4 files
ec2-user:~/environment/tmp/shell/push_pop $ bash app.sh 
/home/ec2-user/environment/tmp/shell/push_pop
~/environment/tmp/shell/push_pop/directory ~/environment/tmp/shell/push_pop
file01
file02
file03
~/environment/tmp/shell/push_pop
/home/ec2-user/environment/tmp/shell/push_pop
ec2-user:~/environment/tmp/shell/push_pop $ 
```

## インデントをつける

1. フォーマッタ（拡張機能）をインストール
    - shell-format
2. 下記キー入力。

| OS | Command |
| :-- | :---- |
| Linux | `Shift + Ctrl + I` |
| Windows | `Shift + Alt + F` |

### 参考

- [【時短！】VSCodeでインデントを一瞬で自動整形する方法をわかりやすく解説します！ : エンジニアブログ](https://programming-engineer.com/vscode-indentation/)

## BOMがついているUTF-8ファイルを作成する

``` bash
# 上書きされる。
nkf --overrite --oc=UTF-8-BOM ${filepath}

# 上書きされない
nkf --oc=UTF-8-BOM ${filepath} > ${new_filepath}
```

## 属性を維持してコピーする

``` bash
cp -p ${original} ${target}
```

## 環境変数を指定する

`.bash_profile`にexport付きで宣言する。

## コマンドの戻り値を取る

``` sh
#!/bin/bash

python app.py $1 $2
retval=$?

if [ $retval -eq 0 ]; then
    echo "Success"
else
    echo "Failure"
fi
```

## 作業ディレクトリを作成する

``` bash
tmpdir=$(mktemp -d)
```

### 参考

- [一時ファイルやディレクトリを作成するmktempコマンドの使い方:Tech+](https://news.mynavi.jp/techplus/article/20180913-692141/)

## 特定の行番号を出力する

``` bash
sed -n ${行番号}p ${ファイルパス}
```

## テストデータを生成する

[generate_test_data:SampleUser0001:Github]https://github.com/SampleUser0001/generate_test_data