# git bash

- [git bash](#git-bash)
  - [diffの文字化け対応](#diffの文字化け対応)
  - [Shift-JISのファイルに対してgrepする](#shift-jisのファイルに対してgrepする)

## diffの文字化け対応

``` bash
git config --global core.paper "nkf -w8 | less"
```

## Shift-JISのファイルに対してgrepする

本来はnkfを使うのだが、使えないとき用。  

- 事前に[NkfLike.java](../Java/Java.md#文字コードと改行コードの変換を行う)をコンパイルして、パスを通しておく。
- `xargs sgrep ${検索ワード}`するときは、`xargs`のオプションに`-n1`を追加すること。
    - 正しくは`xargs -n1 sgrep ${検索ワード}`

`nkf`コマンド

``` bash
#!/bin/bash

original=`realpath $1`
converted=`realpath $2`

pushd `dirname $0` > /dev/null

# echo $original
# echo $converted

java NkfLike $original Shift-JIS CRLF $converted UTF-8 LF

popd > /dev/null
```

`sgrep`

``` bash
#!/bin/bash

original=`realpath $2`
converted=/tmp/`uuidgen`
grep_word=$1

nkf $original $converted

while read data ; do
    echo $original:$data
done << END
`grep -n $grep_word $converted`
END

```
