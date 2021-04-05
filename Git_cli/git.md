# git

- [git](#git)
  - [.gitignoreについて](#gitignoreについて)
  - [親ブランチを取得する](#親ブランチを取得する)
  - [ステージング解除](#ステージング解除)
  - [変更の取り消し](#変更の取り消し)
  - [追跡していないファイルの削除](#追跡していないファイルの削除)
    - [git cleanのオプション](#git-cleanのオプション)
  - [ログをCSVに変換する](#ログをcsvに変換する)
    - [フォーマット](#フォーマット)
  - [git stash](#git-stash)

## .gitignoreについて

[https://qiita.com/inabe49/items/16ee3d9d1ce68daa9fff](https://qiita.com/inabe49/items/16ee3d9d1ce68daa9fff)

## 親ブランチを取得する

```
git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -1 | awk -F'[]~^[]' '{print $2}'
```

## ステージング解除

``` sh
git reset HEAD <対象ファイル>
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
