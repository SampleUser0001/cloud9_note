# Golang

- [Golang](#golang)
  - [モジュールの作成](#モジュールの作成)
  - [go install](#go-install)
  - [フォーマッタ](#フォーマッタ)
  - [lint(staticcheck)](#lintstaticcheck)
  - [package mainでエラーになる](#package-mainでエラーになる)
    - [参考](#参考)

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