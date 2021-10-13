# AWS CodeCommit

AWSが提供しているgitリポジトリ。

- [AWS CodeCommit](#aws-codecommit)
  - [アクセスキーの登録](#アクセスキーの登録)
    - [参考](#参考)
  - [clone](#clone)
  - [通知](#通知)

## アクセスキーの登録

``` sh
aws configure --profile codecommit
  AWS Access Key ID [None]: （アクセスキー）
  AWS Secret Access Key [None]: （シークレットキー）
  Default region name [None]: （リージョン名）
  Default output format [None]: json

git config --global credential.helper "!aws codecommit --profile codecommit credential-helper $@"
git config --global credential.UseHttpPath true
```

### 参考

- [AWS CodeCommitからgit cloneする方法:そうなんでげす](https://www.soudegesu.com/post/aws/clone_from_codecommit/)

## clone

アクセスキーの登録をした上で実行。

``` sh
export AWS_REGION=（リージョン名）
export REPOSITORY_NAME=（リポジトリ名）
git clone https://git-codecommit.${AWS_REGION}.amazonaws.com/v1/repos/${REPOSITORY_NAME}
```

## 通知

下記の種類がある。

- SNS トピック
  - Amazon Kinesis Data Firehose
    - リアルタイムでストリーミングデータをデータストアや分析ツールに配信するサービス。
  - Amazon SQS
    - メッセージキューイングサービス
  - AWS Lambda
    - 説明省略。
- AWS Chatbot
  - Slackなどにイベントの発生を連携できる。
  - 下記は実際に試してみた例。
    - [スクリーンショット](./Screenshot_2021-10-06_15.07.23.png)

