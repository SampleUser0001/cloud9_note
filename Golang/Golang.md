# Golang

- [Golang](#golang)
  - [モジュールの作成](#モジュールの作成)
    - [Githubに登録する場合](#githubに登録する場合)
    - [Githubに登録されているモジュールを使用する場合](#githubに登録されているモジュールを使用する場合)
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
  - [iota](#iota)
  - [interface](#interface)
    - [関数をリストアップする](#関数をリストアップする)
  - [jsonファイルの読み込み](#jsonファイルの読み込み)
    - [構造体に変換する](#構造体に変換する)
    - [配列の場合](#配列の場合)
  - [起動引数を取得する](#起動引数を取得する)
  - [例外の扱い](#例外の扱い)
    - [センチネルエラー](#センチネルエラー)
  - [パッケージのインポート](#パッケージのインポート)
    - [例](#例)
  - [ゴルーチン](#ゴルーチン)
    - [doneチャネルパターン](#doneチャネルパターン)
  - [tsv読み込み](#tsv読み込み)
    - [別解](#別解)
  - [時間](#時間)
    - [time.Now()](#timenow)
    - [文字列 -\> Time](#文字列---time)
    - [文字列 -\> Duration](#文字列---duration)
  - [http.Client](#httpclient)
  - [http.Server](#httpserver)
    - [ルーティング](#ルーティング)
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

### Githubに登録する場合

``` bash
go mod init github.com/SampleUser0001/${reponame}
```

### Githubに登録されているモジュールを使用する場合

``` bash
go mod init ${project_name}
go get github.com/SampleUser0001/${reponame}
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

func double(i int) int {
	return i * 2
}

func triple(i int) int {
	return i * 3
}

type strFuncType func(string)
type intFuncType func(int) int

func main() {
	var e strFuncType = echo
	var df intFuncType = double
	var tf intFuncType = triple
	e("hoge")
	fmt.Println("double :", df(5))
	fmt.Println("triple :", tf(5))
}

```

``` txt
hoge
double : 10
triple : 15
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
	count int
}

// Modelで保持している値を返す
func (m Model) toString() string {
	return fmt.Sprintf("Model[id:%d, value:%s, count:%d]", m.id, m.value, m.count)
}

// countを加算する。
// 構造体の中で持っている値を直接更新する場合は、引数をポインタにする。
func (m *Model) countUp() {
	m.count = m.count + 1
}

// countを加算する。（実装ミス）
func (m Model) notCountUp() {
	m.count = m.count + 1
}

func main() {
	model := Model{
		id:    1,
		value: "hoge",
		count: 0,
	}

	fmt.Println(model.toString())
	model.countUp()
	fmt.Println(model.toString())
	model.notCountUp()
	fmt.Println(model.toString())
}
```

``` txt
Model[id:1, value:hoge, count:0]
Model[id:1, value:hoge, count:1]
Model[id:1, value:hoge, count:1]
```

## iota

enum（もどき）で使う。

``` golang
package main

import "fmt"

type Category int

const (
	A Category = iota
	B
	C
)

func main() {
	fmt.Printf("A : %d\n", A)
	fmt.Printf("B : %d\n", B)
	fmt.Printf("C : %d\n", C)
}
```

``` txt
A : 0
B : 1
C : 2
```

## interface

### 関数をリストアップする

``` golang
package main

import "fmt"

// TestInterface は3つのメソッドを持つインターフェースです
type TestInterface interface {
	func1()
	func2()
	func3()
}

// StructA は TestInterface を満たす構造体です
type StructA struct{}

func (a StructA) func1() { fmt.Println("StructA func1") }
func (a StructA) func2() { fmt.Println("StructA func2") }
func (a StructA) func3() { fmt.Println("StructA func3") }

// StructB は TestInterface を満たさない構造体です
type StructB struct{}

func (b StructB) func1() { fmt.Println("StructB func1") }
func (b StructB) func2() { fmt.Println("StructB func2") }

func main() {
	var test TestInterface
	test = StructA{} //OK
	test.func1()
	test.func2()
	test.func3()

	// 以下のコードはコンパイルエラーになります
	// test = StructB{} //NG
}

```

## jsonファイルの読み込み

- [ex0712e.go : mushahiroyuki:lgo:Github](https://github.com/mushahiroyuki/lgo/blob/main/example/ch07/ex0712e.go)

### 構造体に変換する

``` golang
package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
)

type Data struct {
	Id        string
	Name      string
	Image     Detail
	Thumbnail Detail
	// jsonと同じ項目を定義する。ただし、変数名は大文字。
}
type Detail struct {
	Url    string
	Width  int
	Height int
}

func main() {
	filePath := "data.json"

	// Read the JSON file
	data, err := os.ReadFile(filePath)
	if err != nil {
		log.Fatal(err)
	}

	// Unmarshal the JSON data into a struct
	var jsonData Data
	err = json.Unmarshal(data, &jsonData)
	if err != nil {
		log.Fatal(err)
	}

	// Print the data
	fmt.Println(jsonData)
}
```

`data.json`

``` json
{
    "id": "0001",
    "name": "Cake",
    "image": {
        "url": "images/pict0001.jpg",
        "width": 640,
        "height": 480
    },
    "thumbnail": {
        "url": "thumb/pict0001.jpg",
        "width": 64,
        "height": 64
    }
}
```

``` txt
{0001 Cake {images/pict0001.jpg 640 480} {thumb/pict0001.jpg 64 64}}
```

### 配列の場合

``` golang
	jsonData := []Data{}

	err = json.Unmarshal(data, &jsonData)
	if err != nil {
		fmt.Println("JSONデータのパースエラー:", err)
		return
	}

	// // データを表示する
	for _, item := range jsonData {
		fmt.Println(item.Id, item.Value)
	}

```

## 起動引数を取得する

``` golang
import (
	"fmt"
	"os"
	"strconv"
)

func main() { //liststart2
    if len(os.Args) != 3 {
		fmt.Println("引数の数が間違っています。")
		fmt.Println("使い方：ex0801 <被除数> <除数>")
		os.Exit(1)
	}
	var argsIndex int = 1

    // strconv.Atoiは文字列 -> 数値変換。
	numerator, _ := strconv.Atoi(os.Args[argsIndex])
	argsIndex++
	denominator, _ := strconv.Atoi(os.Args[argsIndex])
	argsIndex++
}
```

## 例外の扱い

``` golang
package main

import (
	"errors"
	"fmt"
	"os"
)

func main() {
	_, error := hogehoge()
	if error != nil {
		fmt.Println(error)
		os.Exit(1)
	}
}

func hogehoge() (int, error) {
	return 0, errors.New("なんかのエラーが発生しました。")
}
```

### センチネルエラー

`mod/mod.go`

```golang
package sentinelerror

import (
	"errors"
)

var SampleError = errors.New("なんかのエラーが発生しました。")

func SampleFunc() (int, error) {
	return 0, SampleError
}

```

``` golang
package main

import (
	"errors"
	"fmt"
	"os"
	"sentinelerror"
)

func main() {
	_, err := sentinelerror.SampleFunc()
	if err != nil {
		if errors.Is(err, sentinelerror.SampleError) {
			fmt.Println("SampleErrorが発生しました。")
			os.Exit(1)
		} else {
			fmt.Println("その他のエラーが発生しました。")
			os.Exit(1)
		}
	} else {
		fmt.Println("エラーは発生しませんでした。")
		os.Exit(0)
	}
}
```

## パッケージのインポート

``` bash
go mod init ${package}

# ダウンロードするものがある場合実行
go mod tidy
```

### 例

`main.go`

``` golang
package main

import "ittimfn/hoge"

func main() {
	hoge.PrintHoge()
}
```

`hoge/hoge.go`

``` golang
package hoge

func PrintHoge() {
	println("hoge")
}
```

``` bash
go mod init ittimfn

# 今回はローカルなので不要
# go mod tidy

go run main.go
```

`go.mod`

``` bash
module ittimfn

go 1.21.5
```

## ゴルーチン

- [ex1000.go](https://github.com/mushahiroyuki/lgo/blob/main/example/ch10/ex1000.go)

### doneチャネルパターン

``` golang
package main

import (
	"fmt"
	"time"
)

func doSomething(i int, done <-chan bool) {
	for {
		select {
		case <-done:
			fmt.Printf("処理 %d を終了\n", i)
			return
		default:
			// 通常の処理
			fmt.Printf("処理 %d 実行中\n", i)
			time.Sleep(time.Second) // 何かの処理を想定
		}
	}
}

func main() {
	done := make(chan bool)
	for i := 0; i < 3; i++ {
		go doSomething(i, done)
	}

	time.Sleep(3 * time.Second) // 何かの処理を想定
	close(done)                 // すべてのゴルーチンに終了を通知
	time.Sleep(time.Second)     // ゴルーチンの終了を待機
}

```

## tsv読み込み

```golang
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Item struct {
	id    int
	value string
}

func main() {
	argsIndex := 1
	filePath := os.Args[argsIndex]
	argsIndex++

	fp, err := os.Open(filePath)
	if err != nil {
		fmt.Println("ファイルの読み込みエラー:", err)
	}
	defer fp.Close()

	scanner := bufio.NewScanner(fp) // 1行ずつ読み込む
	var itemList []Item
	for scanner.Scan() {
		splited := strings.Split(scanner.Text(), "\t")
		id, _ := strconv.Atoi(splited[0])
		item := Item{
			id:    id,
			value: splited[1],
		}
		itemList = append(itemList, item)
	}

	fmt.Println(itemList)
}
```

```txt
$ cat file.tsv
1       hoge
2       piyo
3       fuga
```

``` bash
$ go run app.go file.tsv
[{1 hoge} {2 piyo} {3 fuga}]
```

### 別解

```golang
package main

import (
	"encoding/csv"
	"fmt"
	"os"
)

type Comment struct {
	Time    string
	Content string
}

func main() {
	// Open the comments.tsv file
	file, err := os.Open("comments.tsv")
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer file.Close()

	// Read the file as a CSV
	reader := csv.NewReader(file)
	reader.Comma = '\t'

	// Read all the records
	records, err := reader.ReadAll()
	if err != nil {
		fmt.Println("Error reading file:", err)
		return
	}

	// Create a slice to store the comments
	comments := make([]Comment, 0)

	// Iterate over the records and create Comment objects
	for _, record := range records {
		comment := Comment{
			Time:    record[0],
			Content: record[1],
		}
		comments = append(comments, comment)
	}

	// Print the comments
	for _, comment := range comments {
		fmt.Println(comment)
	}
}

```

## 時間

### time.Now()

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	currentTime := time.Now()
	// 2006-01-02 15:04:05でフォーマットする。
	fmt.Println(currentTime.Format("2006-01-02 15:04:05"))
}
```

```
2024-01-27 22:34:30
```

### 文字列 -> Time

```golang
package main

import (
	"fmt"
	"time"
)

func main() {
	// TimeZoneがないと、変換時にUTCとして扱われる。
	str := "2024/01/27 22:27:30 +0900"
	t, err := time.Parse("2006/01/02 15:04:05 -0700", str)
	if err != nil {
		fmt.Println("Error parsing time:", err)
		return
	}
	fmt.Println("Parsed time:", t)
}

```

```txt
Parsed time: 2024-01-27 22:27:30 +0900 JST
```

### 文字列 -> Duration

``` golang
func convertToDuration(timeString string) (time.Duration, error) {
	splited := strings.Split(timeString, ":")
	var hour, minute, second int = 0, 0, 0
	var err error
	if len(splited) == 2 {
		// 分秒
		hour = 0
		minute, err = strconv.Atoi(splited[0])
		if err != nil {
			return 0, fmt.Errorf("minute is not number")
		}
		second, err = strconv.Atoi(splited[1])
		if err != nil {
			return 0, fmt.Errorf("second is not number")
		}
	} else if len(splited) == 3 {
		// 時分秒
		hour, err = strconv.Atoi(splited[0])
		if err != nil {
			return 0, fmt.Errorf("hour is not number")
		}
		minute, err = strconv.Atoi(splited[1])
		if err != nil {
			return 0, fmt.Errorf("minute is not number")
		}
		second, err = strconv.Atoi(splited[2])
		if err != nil {
			return 0, fmt.Errorf("second is not number")
		}
	}

	duration := time.Duration(hour)*time.Hour + time.Duration(minute)*time.Minute + time.Duration(second)*time.Second
	return duration, nil
}
```

## http.Client

``` golang
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

type User struct {
	UserId    int    `json:"userId"`
	Id        int    `json:"id"`
	Title     string `json:"title"`
	Completed bool   `json:"completed"`
}

func (u User) String() string {
	return fmt.Sprintf("User{UserId: %d, Id: %d, Title: %s, Completed: %t}", u.UserId, u.Id, u.Title, u.Completed)
}

func main() {
	client := http.Client{
		Timeout: 10 * time.Second,
	}

	url := "https://jsonplaceholder.typicode.com/todos/1"
	req, err := http.NewRequestWithContext(
		context.Background(),
		http.MethodGet,
		url,
		nil,
	)

	if err != nil {
		panic(err)
	}

	res, err := client.Do(req)
	if err != nil {
		panic(err)
	}

	defer res.Body.Close()

	if res.StatusCode != http.StatusOK {
		panic(fmt.Sprintf("status : %v", res.Status))
	}

	fmt.Println("status : ", res.Status)
	var data User
	err = json.NewDecoder(res.Body).Decode(&data)
	if err != nil {
		panic(err)
	}

	fmt.Println("data : ", data)
}

```

## http.Server

```golang
package main

import (
	"net/http"
	"time"
)

type HelloHandler struct{}

func (handler HelloHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello World"))
}

func main() {
	server := http.Server{
		Addr:         ":8080",
		ReadTimeout:  30 * time.Second,
		WriteTimeout: 30 * time.Second,
		IdleTimeout:  30 * time.Second,
		Handler:      HelloHandler{},
	}

	err := server.ListenAndServe()
	if err != nil {
		if err == http.ErrServerClosed {
			panic(err)
		}
	}
}
```

### ルーティング

``` golang
package main

import (
	"log"
	"net/http"
)

func generateMux(message string) (*http.ServeMux, error) {
	mux := http.NewServeMux()
	mux.HandleFunc("/greet",
		func(w http.ResponseWriter, r *http.Request) {
			w.Write([]byte(message + "\n"))
		})
	return mux, nil
}

func main() {
	person, _ := generateMux("Hello Person")
	cat, _ := generateMux("Hello Cat!!")

	mux := http.NewServeMux()
	mux.Handle("/person/", http.StripPrefix("/person", person))
	mux.Handle("/cat/", http.StripPrefix("/cat", cat))

	log.Fatal(http.ListenAndServe(":8080", mux))

	// http://localhost:8080/person/greet
	// http://localhost:8080/cat/greet
}
```

## 初めてのGo言語

- [mushahiroyuki:lgo:Github](https://github.com/mushahiroyuki/lgo)
    - インタフェース
        - インターフェースを受け取り、構造体を返す
        - [空インタフェース](https://github.com/mushahiroyuki/lgo/blob/main/example/ch07/ex0712b.go)
            - any型のこと
        - 暗黙のインタフェースによる依存性注入
        - 依存性注入コードの生成(Wire)
    - エラー処理
        - [エラーと値](https://github.com/mushahiroyuki/lgo/blob/main/example/ch08/ex0805.go)
        - [エラーのラップ](https://github.com/mushahiroyuki/lgo/blob/main/example/ch08/ex0806.go)
        - [IsとAs](https://github.com/mushahiroyuki/lgo/blob/main/example/ch08/ex0807.go)
        - [パニックとリカバー](https://github.com/mushahiroyuki/lgo/blob/main/example/ch08/ex0809.go)
        - スタックトレース
    - ゴルーチン
        - [select](https://github.com/mushahiroyuki/lgo/blob/main/example/ch10/ex1002.go)
        - [キャンセレーション関数](https://github.com/mushahiroyuki/lgo/blob/main/example/ch10/ex1008.go)
        - [バックプレッシャ](https://github.com/mushahiroyuki/lgo/blob/main/example/ch10/ex1010.go)
        - [selectにおけるcaseの無効化](https://github.com/mushahiroyuki/lgo/blob/main/example/ch10/ex1010.5.go)
        - [タイムアウト](https://github.com/mushahiroyuki/lgo/blob/main/example/ch10/ex1011.go)
        - [WaitGroupの利用](https://github.com/mushahiroyuki/lgo/blob/main/example/ch10/ex1012.go)
        - [コードを一度だけ実行](https://github.com/mushahiroyuki/lgo/blob/main/example/ch10/ex1014.go)
    - Server
        - [ミドルウェア](https://github.com/mushahiroyuki/lgo/blob/main/example/ch11/4http/http04.go)