# git

- [git](#git)
  - [.gitignoreについて](#gitignoreについて)
  - [ブランチ作成元のブランチ名を取得する](#ブランチ作成元のブランチ名を取得する)
  - [ブランチ作成元のコミットIDを取得する](#ブランチ作成元のコミットidを取得する)
    - [参考](#参考)
  - [マージ時に発生する差分の取得](#マージ時に発生する差分の取得)
    - [参考](#参考-1)
  - [ステージング解除](#ステージング解除)
    - [新規](#新規)
    - [変更](#変更)
  - [変更の取り消し](#変更の取り消し)
  - [cherry-pick](#cherry-pick)
  - [追跡していないファイルの削除](#追跡していないファイルの削除)
    - [git cleanのオプション](#git-cleanのオプション)
  - [作成元ブランチの変更を取り込む](#作成元ブランチの変更を取り込む)
  - [git rebaseを使って複数コミットをsquashする](#git-rebaseを使って複数コミットをsquashする)
  - [ログをCSVに変換する](#ログをcsvに変換する)
    - [フォーマット](#フォーマット)
  - [git stash](#git-stash)
  - [差分があり、ステージングしていないファイル一覧](#差分がありステージングしていないファイル一覧)
  - [サーバにないが、ローカルにあるリモートブランチを削除する](#サーバにないがローカルにあるリモートブランチを削除する)
  - [git submodule](#git-submodule)
    - [登録](#登録)
    - [読み込む](#読み込む)
    - [更新する](#更新する)
  - [git log](#git-log)
    - [更新したファイル一覧を表示する](#更新したファイル一覧を表示する)
    - [ファイル単位で更新履歴を出力する](#ファイル単位で更新履歴を出力する)
      - [ファイル単位で更新履歴を出力する:参考](#ファイル単位で更新履歴を出力する参考)
  - [git merge](#git-merge)
    - [fast-forward](#fast-forward)
    - [non-fast-forward](#non-fast-forward)
    - [コミットしないマージ](#コミットしないマージ)
      - [コンフリクトの確認](#コンフリクトの確認)
      - [マージの取り消し](#マージの取り消し)
    - [rebase と mergeの違い](#rebase-と-mergeの違い)
  - [直前のコミットの取り消し](#直前のコミットの取り消し)
    - [直前のコミットの逆で上書き(revert)](#直前のコミットの逆で上書きrevert)
    - [履歴を削除](#履歴を削除)
  - [他のブランチ/コミットのファイルを取得する(git show)](#他のブランチコミットのファイルを取得するgit-show)
  - [ファイルごとの最終更新日の取得](#ファイルごとの最終更新日の取得)
    - [参考](#参考-2)
  - [リモートリポジトリと紐づける](#リモートリポジトリと紐づける)
    - [Github](#github)
  - [設定](#設定)
    - [改行コード](#改行コード)
  - [コンソールにブランチ名を表示する](#コンソールにブランチ名を表示する)
  - [接続先URLを確認する](#接続先urlを確認する)
  - [gitコマンドを実行するディレクトリを指定する](#gitコマンドを実行するディレクトリを指定する)
  - [tagをつける](#tagをつける)
  - [コミットログのタイムゾーン設定](#コミットログのタイムゾーン設定)
  - [git log since時にタイムゾーンを意識する](#git-log-since時にタイムゾーンを意識する)
  - [パスワードを保存する](#パスワードを保存する)

## .gitignoreについて

[https://qiita.com/inabe49/items/16ee3d9d1ce68daa9fff](https://qiita.com/inabe49/items/16ee3d9d1ce68daa9fff)

## ブランチ作成元のブランチ名を取得する

``` bash
git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -1 | awk -F'[]~^[]' '{print $2}'
```

※作成元でsquashしていると取得できない？`git show-branch`で確認する。

## ブランチ作成元のコミットIDを取得する

``` bash
git show-branch --sha1-name | tail -n 1 | grep -v "$(git rev-parse --abbrev-ref HEAD)" | awk -F'[]~^[]' '{print $2}'
```

※作成元でsquashしていると取得できない？`git show-branch`で確認する。

### 参考

- [muumin/gist:55eaca26f0f73cf7cb1e983f8757765c](https://gist.github.com/muumin/55eaca26f0f73cf7cb1e983f8757765c)

## マージ時に発生する差分の取得

``` bash
source_branch=
target_branch=
git diff --name-status ${target_branch}...${source_branch}
```

### 参考

- [git 差分を見る:Qiita](https://qiita.com/ikenji/items/42248085c4f4b55660d6)

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

## cherry-pick

別ブランチの特定のコミットだけを取り込む。  
ファイル変更が発生しているコミットでないと指定できない。

``` sh
# 対象のコミットを探す
git log --name-status

# 対象のコミットIDを指定する。複数指定できる。
git cherry-pick ${commit_id_01} ${commit_id_02}
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

## 作成元ブランチの変更を取り込む

``` bash
git rebase ${branch}
```

## git rebaseを使って複数コミットをsquashする

1. file1,file2作成
2. file3作成
3. file1削除  

3つまとめて、file1をなかったことにしたい。

``` txt
commit 4623fd071700a748b645afb84f9bb226eb65559f (HEAD -> main)
Author: SampleUser0001 <ittimfn+github@gmail.com>
Date:   Thu Jul 13 00:45:18 2023 +0900

    rm file1

D       file1

commit b4ebab3559c365c024df48521ecda95ed22f073f
Author: SampleUser0001 <ittimfn+github@gmail.com>
Date:   Thu Jul 13 00:44:48 2023 +0900

    second

A       file3

commit fb08e045a624168dde9efd71e744e26b1ec35583
Author: SampleUser0001 <ittimfn+github@gmail.com>
Date:   Thu Jul 13 00:44:29 2023 +0900

    first

A       file1
A       file2

```

``` bash
git log --oneline
4623fd0 (HEAD -> main) rm file1
b4ebab3 second
fb08e04 first
```

``` bash
git rebase -i fb08e04
```

``` bash
pick b4ebab3 second
pick 4623fd0 rm file1

# Rebase fb08e04..4623fd0 onto fb08e04 (2 commands)
#
# Commands:
# (省略)
# pickをsquashにするとまとめられる。すべてをsquashにはできない。
```

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

## サーバにないが、ローカルにあるリモートブランチを削除する

``` sh
git fetch -p
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

### fast-forward

- `git merge --ff`コマンド。
    - `--ff`オプションはなくてOK。
- マージ時点でブランチ作成後に作成されたコミットがある場合、並び替えが発生する。
    - マージ先ブランチの後ろに、マージ元ブランチのコミットが追加される。
    - 他のブランチなどからマージされたコミットがある場合は、その後ろにつく。
        - 時系列的に間似合った場合でも、後ろにつく。
- コミットIDはマージ前後で同じ。
- non-fast-forwardと異なり、マージポイントが作成されない。
    - マージした痕跡が見つからなくなる。

### non-fast-forward

- `git merge --no-ff ${source_branch}`コマンド。
- マージポイントが作成される。
- マージ時点でブランチ作成後に作成されたコミットがある場合、時系列で並ぶ。
   - feature/a, feature/bブランチがあり、下記順にコミット＋マージした場合、
       - feature/a : A1
       - feature/b : B1
       - feature/b -> develop(squash)
       - feature/a : A2
       - feature/a -> develop(non-fast-forward)
       - develop
           - A1, B1, A2の順に並ぶ。

### コミットしないマージ

``` sh
git merge ${ブランチ名} --no-commit
```

#### コンフリクトの確認

``` sh
# dry-runはない。実際にマージしてみる。
git merge --no-commit ${source_branch}

# もとに戻す
git merge --abort

# ???
git status
```

cloud9環境の場合は、対象のファイルを開くと見た目をいい感じにして表示してくれる。

#### マージの取り消し

``` sh
git merge --abort
```

### rebase と mergeの違い

- 前提 : mergeはオプション指定なし。（fast-forwardする。）
- rebase
    - 現在のブランチの後ろにコミットが付与される。
- merge
    - コミットされた順番通りに並び替えが発生する。

## 直前のコミットの取り消し

### 直前のコミットの逆で上書き(revert)

``` bash
git revert HEAD
```

### 履歴を削除

``` sh
git reset --hard HEAD^
```

## 他のブランチ/コミットのファイルを取得する(git show)

``` bash
git show ${branch}:${path} > ${export_path}
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

## コンソールにブランチ名を表示する

``` bash
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)" 2>/dev/null) $ '
```

## 接続先URLを確認する

``` bash
git remote -v
```

## gitコマンドを実行するディレクトリを指定する

``` bash
git -C ${path} ${git_command}
```

## tagをつける

``` bash
git tag -a ${tag} -m ${message}
```

## コミットログのタイムゾーン設定

ローカルのタイムゾーンを設定する。

``` bash
git config --global log.date local
```

## git log since時にタイムゾーンを意識する

``` bash
git log --since="2023-10-05T00:00:00+09:00"
```

## パスワードを保存する

- [Linux#パスワードを保存する(.netrc)](../Linux/Linux.md#パスワードを保存する(.netrc))
