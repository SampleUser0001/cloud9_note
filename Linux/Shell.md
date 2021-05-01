# Linux Shell

## ディレクトリ配下のファイルでループする

``` sh
for file in $(pwd)/<対象ディレクトリ>/* ; do
    echo ${file}
done 
```

## ファイルを一行ずつ読み込んでループする

### その1

``` sh 
while read data; do
  echo ${data}
done << END
`cat ${filename}`
END
```

### その2

``` sh 
while read data ; do
    echo ${data}
done < <対象ファイル>
```

#### 注意点

末尾にLFがある行しか読み込まない。（CRLFはNG。）

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

## .envファイルの読み込み方

``` sh
export $(cat .env | grep -v ^# | xargs)
```
