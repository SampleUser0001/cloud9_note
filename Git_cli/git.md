# git

- [git](#git)
  - [.gitignoreについて](#gitignoreについて)
  - [親ブランチを取得する](#親ブランチを取得する)
  - [ステージング解除](#ステージング解除)
    - [新規](#新規)
    - [変更](#変更)
  - [変更の取り消し](#変更の取り消し)
  - [追跡していないファイルの削除](#追跡していないファイルの削除)
    - [git cleanのオプション](#git-cleanのオプション)
  - [ログをCSVに変換する](#ログをcsvに変換する)
    - [フォーマット](#フォーマット)
  - [git stash](#git-stash)
  - [差分があり、ステージングしていないファイル一覧](#差分がありステージングしていないファイル一覧)
  - [git submodule](#git-submodule)
    - [登録](#登録)
    - [読み込む](#読み込む)
    - [更新する](#更新する)
  - [git log](#git-log)
    - [更新したファイル一覧を表示する](#更新したファイル一覧を表示する)
    - [ファイル単位で更新履歴を出力する](#ファイル単位で更新履歴を出力する)
      - [ファイル単位で更新履歴を出力する:参考](#ファイル単位で更新履歴を出力する参考)
  - [git merge](#git-merge)
    - [コミットしないマージ](#コミットしないマージ)
      - [コンフリクトの確認](#コンフリクトの確認)
      - [マージの取り消し](#マージの取り消し)
  - [直前のコミットの取り消し](#直前のコミットの取り消し)
    - [直前のコミットの逆で上書き(revert)](#直前のコミットの逆で上書きrevert)
    - [履歴を削除](#履歴を削除)
  - [ファイルごとの最終更新日の取得](#ファイルごとの最終更新日の取得)
    - [参考](#参考)
  - [リモートリポジトリと紐づける](#リモートリポジトリと紐づける)
    - [Github](#github)
  - [設定](#設定)
    - [改行コード](#改行コード)

## .gitignoreについて

[https://qiita.com/inabe49/items/16ee3d9d1ce68daa9fff](https://qiita.com/inabe49/items/16ee3d9d1ce68daa9fff)

## 親ブランチを取得する

```
git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -1 | awk -F'[]~^[]' '{print $2}'
```

## ステージング解除

### 新規

``` sh
git rm --cached -r ${対象ファイル}
```

### 変更

``` sh
git reset HEAD ${対象ファイル}
```

## 変更の取り消し

``` sh
git checkout <対象パス>
```

## 追跡していないファイルの削除

``` sh
git clean <オプション>
```

### git cleanのオプション

| オプション | 意味 |
| :-- | :-- |
| -n | 対象のファイルを確認する(削除はされない) |
| -d | ディレクトリを含める |
| -f | 削除を実行する |

## ログをCSVに変換する

``` sh
git --no-pager log \
--pretty=format:"\"%ae\",\"%s\"" \
--date=short --no-merges --all --date-order > ../commits.csv
```

### フォーマット

- [Qiita:git logのフォーマットを指定する](https://qiita.com/harukasan/items/9149542584385e8dea75)

## git stash

stash 

``` sh
git stash
```

一覧

``` sh
git stash list
```

適用

``` sh
git stash apply stash@{0}
```

## 差分があり、ステージングしていないファイル一覧

``` sh
git diff --name-only
```

## git submodule

他のリポジトリをライブラリとして取り込むことができる。

### 登録

``` sh
git submodule add ${リポジトリURL}
```

### 読み込む

git cloneしただけだと、読み込まれない。

``` sh
git submodule init
```

### 更新する

``` sh
git submodule update
```

## git log

### 更新したファイル一覧を表示する

``` sh
git log --name-only
```

``` sh
git log --stat
```

### ファイル単位で更新履歴を出力する

``` sh
git log -p ${対象ファイル or 対象ディレクトリ}
```

#### ファイル単位で更新履歴を出力する:参考

- [git logでファイルの変更履歴を確認。問題のコミットを特定！:開発ブログ](https://www-creators.com/archives/1782)

## git merge

### コミットしないマージ

``` sh
git merge ${ブランチ名} --no-commit
```

#### コンフリクトの確認

``` sh
git status
```

cloud9環境の場合は、対象のファイルを開くと見た目をいい感じにして表示してくれる。

#### マージの取り消し

``` sh
git merge --abort
```

## 直前のコミットの取り消し

### 直前のコミットの逆で上書き(revert)

``` bash
git revert HEAD
```

### 履歴を削除

``` sh
git reset --hard HEAD^
```

## ファイルごとの最終更新日の取得

``` sh
git ls-files . | xargs -I@ bash -c 'echo "$(git log -1 --format="%cd" --date=format:'%Y/%m/%d_%H:%M:%S' -- @)" @'
```

### 参考

- [gitのcommit日時順にファイル一覧を表示する:$shibayu36->blog;](https://blog.shibayu36.org/entry/2018/01/16/193000)

## リモートリポジトリと紐づける

### Github

``` bash
git remote add origin git@github.com:SampleUser0001/${プロジェクト名}.git
git branch -M main
git push -u origin main
```

## 設定

### 改行コード

``` bash
git config --global core.autocrlf ${value}
```

| 値 | checkout | commit |
| :--: | :----: | :----: |
| true | LF -> CRLF | CRLF -> LF |
| input | 何もしない | CRLF -> LF |
| false | 何もしない | 何もしない |

