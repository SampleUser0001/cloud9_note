# AWS Lambda

- [AWS Lambda](#aws-lambda)
  - [cloud9に開発環境を作成する](#cloud9に開発環境を作成する)
    - [準備](#準備)
    - [AWS Lambdaからソースを取得する](#aws-lambdaからソースを取得する)
    - [CodeCommitにソースを登録する](#codecommitにソースを登録する)
    - [Run Local](#run-local)
    - [Deploy](#deploy)

## cloud9に開発環境を作成する

### 準備

- cloud9は構築済み。
- AWS SETTINGS -> AWS -> AWS Resources -> AWS ToolkitをOffにする。

### AWS Lambdaからソースを取得する

1. 右のタブ -> AWS Resources -> Remote Functions -> 取得したいAWS Lambda関数を右クリック -> Import
2. Importをクリック

### CodeCommitにソースを登録する

``` sh
cd ${プロジェクトディレクトリ}
git init
git branch -m main
git config --global init.defaultBranch main
git add .
git commit -m "init commit"
git remote add origin https://git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/${プロジェクト名}
git push
```

### Run Local

Local Functions -> 実行したいLambda関数を選択 -> 上の実行マークの隣のプルダウンをクリック -> Run Localをクリック

### Deploy

Local Functions -> デプロイしたいLambda関数を右クリック -> Deploy

