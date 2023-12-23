# Golang

- [Golang](#golang)
  - [モジュールの作成](#モジュールの作成)
  - [go install](#go-install)
  - [フォーマッタ](#フォーマッタ)
  - [lint(staticcheck)](#lintstaticcheck)
  - [package mainでエラーになる](#package-mainでエラーになる)
    - [参考](#参考)
  - [スライス](#スライス)
    - [append](#append)
    - [copy](#copy)
  - [map](#map)
  - [for](#for)
    - [range](#range)
  - [switch](#switch)
  - [関数型](#関数型)
    - [関数を返す関数](#関数を返す関数)
  - [型メソッド](#型メソッド)
  - [初めてのGo言語](#初めてのgo言語)

## モジュールの作成

``` bash
mkdir ${module_name}
cd ${module_name}
go mod init ${module_name}

# モジュール実装

go mod tidy
go build

# 実行
./${module_name}
```

## go install

GithubなどにソースがUPされている場合、`go install`コマンドで導入できる。

``` bash
# $GOHOME/binのパスにインストールされる。
go install github.com/rakyll/hey@latest
hey https://www.golang.org
```

## フォーマッタ

``` bash
go install golang.org/x/tools/cmd/goimports@latest
goimports -l -w .
# または `go fmt`
```

## lint(staticcheck)

``` bash
go install honnef.co/go/tools/cmd/staticcheck@latest
staticcheck
# go.modがあるフォルダに対してチェックする
go vet
```

## package mainでエラーになる

``` bash
# プロジェクトのHOMEで実行すること。
go work init

go work use ${エラーを吐いているgoファイルがあるディレクトリ}
```

### 参考

- [gopls was not able to find modules in your workspace. への対処:Qiita](https://qiita.com/39shin52/items/84301f4ccb0b7f5a1a92)

## スライス

Javaで言うList。（配列もあるが、サイズが固定化される。）

### append

``` golang
	evenValues := []int{}
	for i := 0; i < 10; i++ {
		evenValues = append(evenValues, i*2)
	}
```

### copy

``` go
package main

import "fmt"

func main() {
    x := []int{1, 2, 3, 4}
    z := make([]int, len(x))
    length := copy(z, x)
    z[1] = 10
    fmt.Printf("z : %d , length : %d, x : %d\n", z, length, x)
}
```

```txt
z : [1 10 3 4] , length : 4, x : [1 2 3 4]
```

## map

```golang
package main

import "fmt"

func printFound(hashMap map[int]string, key int) bool {
	value, have := hashMap[key]
	if have {
		fmt.Println("value :", value)
	} else {
		fmt.Println("Not Found :", key)
	}
	return have
}

func main() {
	// LinkedHashMapはない。
	hashMap := map[int]string{
		2: "piyo",
		3: "fuga",
		1: "hoge",
	}
	fmt.Println(hashMap)

	for k := range hashMap {
		fmt.Printf("key : %d , value : %s\n", k, hashMap[k])
	}

	printFound(hashMap, 1)
	printFound(hashMap, 4)
}
```

``` txt
map[1:hoge 2:piyo 3:fuga]
key : 3 , value : fuga
key : 1 , value : hoge
key : 2 , value : piyo
value : hoge
Not Found : 4
```

## for

### range

``` golang
package main

import "fmt"

func main() {
	evenValues := []int{}
	for i := 0; i < 10; i++ {
		evenValues = append(evenValues, i*2)
	}

	for i, v := range evenValues {
		fmt.Println("i :", i, " v :", v)
	}
}
```

``` txt
i : 0  v : 0
i : 1  v : 2
i : 2  v : 4
i : 3  v : 6
i : 4  v : 8
```

## switch

goのswitchはbreak不要。

```golang
package main

import "fmt"

func main() {
	n := 0
	switch n {
	case 0:
		fmt.Println(n)
	case 1:
		fmt.Println(n)
	default:
		fmt.Println(n)
	}
}
```

``` txt
0
```

## 関数型

``` golang
package main

import "fmt"

func echo(v string) {
	fmt.Println(v)
}

type funcType func(string)

func main() {
	var e funcType = echo
	e("hoge")
}
```

### 関数を返す関数

- [ex0512.go:mushahiroyuki:lgo:Github](https://github.com/mushahiroyuki/lgo/blob/main/example/ch05/ex0512.go)

``` txt
0: 0, 0
1: 2, 3
2: 4, 6
3: 6, 9
4: 8, 12
5: 10, 15
```

## 型メソッド

構造体にメソッドを追加する。

``` golang
package main

import "fmt"

type Model struct {
	id    int
	value string
}

func (m Model) toString() string {
	return fmt.Sprintf("Model[id:%d, value:%s]", m.id, m.value)
}

func main() {
	model := Model{
		id:    1,
		value: "hoge",
	}

	fmt.Println(model.toString())
}

```

``` txt
Model[id:1, value:hoge]
```

## 初めてのGo言語

- [mushahiroyuki:lgo:Github](https://github.com/mushahiroyuki/lgo)
