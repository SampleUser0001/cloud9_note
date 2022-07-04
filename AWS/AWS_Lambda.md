# AWS Lambda

- [AWS Lambda](#aws-lambda)
  - [cloud9に開発環境を作成する](#cloud9に開発環境を作成する)
    - [準備](#準備)
    - [AWS Lambdaからソースを取得する](#aws-lambdaからソースを取得する)
    - [CodeCommitにソースを登録する](#codecommitにソースを登録する)
    - [Run Local](#run-local)
    - [Deploy](#deploy)
  - [CodeCommitのプルリクエストにコメントを記載する](#codecommitのプルリクエストにコメントを記載する)
  - [serverless framework](#serverless-framework)
    - [コマンド](#コマンド)
      - [初期化](#初期化)
      - [デプロイ](#デプロイ)
      - [削除](#削除)
    - [設定](#設定)
      - [参考](#参考)
    - [参考](#参考-1)
  - [ホスト側のaws cli設定をコンテナに持ち込んで、boto3する](#ホスト側のaws-cli設定をコンテナに持ち込んでboto3する)
  - [Function URLs](#function-urls)
    - [new](#new)
      - [Lambda](#lambda)
      - [.env](#env)
      - [sh](#sh)
      - [実行](#実行)
    - [old](#old)
      - [ソース](#ソース)
      - [テスト用イベントJSON](#テスト用イベントjson)
      - [実行](#実行-1)
  - [CORSエラーの対応をする](#corsエラーの対応をする)
    - [参考](#参考-2)

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

## CodeCommitのプルリクエストにコメントを記載する

``` python
import boto3
from datetime import datetime as dt

def lambda_handler(event, context):
    content = [dt.now().strftime('%Y/%m/%d %H:%M:%S'), 'hoge','piyo']
    boto3.client('codecommit').post_comment_for_pull_request(
        pullRequestId='13',
        repositoryName='CodeBuild_Environment',
        beforeCommitId='385416ed5c736e73920993f1d0eb6eb7ef2d2cb0',
        afterCommitId='8768709c4620f7c858515a3aeb31bdf65a3f6035',
        content='  \n'.join(content)
    )
```

## serverless framework

AWS Lambdaをリリースするフレームワーク

### コマンド

#### 初期化

``` sh
serverless create --template aws-python3 --name ${プロジェクト名} --path ${ディレクトリ名}
```

#### デプロイ

``` sh
sls deploy -v --stage ${ステージング名}
```

#### 削除

``` sh
sls remove -v 
```

### 設定

profileを設定する場合は、credentialsに記載する。

#### 参考

- [Serverless FrameworkでProfileが存在しないというエラーの対処法:DevelopersIO](https://dev.classmethod.jp/articles/serverless-framework-profil-edoes-not-exist/)

### 参考

- [ServerlessSampleLambdaProject:SampleUser0001:Github](https://github.com/SampleUser0001/ServerlessSampleLambdaProject)

## ホスト側のaws cli設定をコンテナに持ち込んで、boto3する

~/.awsをコンテナに持ち込めばOK。  
.gitignoreに.awsを記載すること。

``` sh
# docker-compose.ymlと同じディレクトリで実行する。
ln -s ~/.aws .aws
```

パスは実行ユーザに依存。

docker-compose.yml

``` yml
services:
  python:
    volumes:
      - .aws:/root/.aws
```

## Function URLs

### new

#### Lambda

``` python
import json

KEY = 'name'

def lambda_handler(event, context):

    param = event.get('queryStringParameters')

    if KEY in param:
        message = 'Hello {}!'.format(param[KEY])
    else:
        message = 'Who are you?'

    return {
        'statusCode': 200,
        'body': message
    }  

    # Deploy Test Comment
      

```

#### .env

``` .env
API_URL=https://${採番された値}.lambda-url.ap-northeast-1.on.aws
```

#### sh

``` bash
#!/bin/bash

source .env

curl -X GET $API_URL?name=World
```

#### 実行

``` bash
$ bash call_lambda_function.sh 
Hello World!
```

### old

#### ソース

``` python
import json

def lambda_handler(event, context):

    request = event['body']
    loaded = json.loads(request)
    keys = list(loaded.keys())
    values = list(loaded.values())

    returnBody = { keys[0] : values[0] }

    return {
        'statusCode': 200,
        'body': json.dumps(returnBody)
    }
```

#### テスト用イベントJSON

``` json
{
  "body": "{\"example\":\"value\"}"
}
```

#### 実行

``` bash
# URLはLambdaのページから確認する。
export FUNCTION_URL=
export FUNCTION_ARGS='{"example":"test"}'
curl -X GET -H "Content-Type: application/json" -d ${FUNCTION_ARGS} ${FUNCTION_URL}
```

``` json
{"example": "test"}
```

## CORSエラーの対応をする

戻り値のヘッダに```Access-Control-Allow-Headers```, ```Access-Control-Allow-Origin```をつける。

``` python
    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Origin': 'http://ittimfn-public-lambda.s3-website-ap-northeast-1.amazonaws.com',
            'Access-Control-Allow-Methods': 'GET'
        },
        'body': message
    }  

```

### 参考

- [REST API リソースの CORS を有効にする](https://docs.aws.amazon.com/ja_jp/apigateway/latest/developerguide/how-to-cors.html)
- [なんとなく CORS がわかる...はもう終わりにする。:Qiita](https://qiita.com/att55/items/2154a8aad8bf1409db2b)