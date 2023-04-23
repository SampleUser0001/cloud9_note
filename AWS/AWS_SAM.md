# AWS Serverless Applicatino Model(AWS SAM)

AWS Serverless Application Model (AWS SAM) は、AWS でサーバーレスアプリケーションを構築するために使用できるオープンソースのフレームワークです。

- [AWS Serverless Applicatino Model(AWS SAM)](#aws-serverless-applicatino-modelaws-sam)
  - [コマンド](#コマンド)
    - [プロジェクト作成](#プロジェクト作成)
    - [ビルド](#ビルド)
    - [ローカル実行](#ローカル実行)
    - [デプロイ](#デプロイ)
      - [権限](#権限)
    - [参考](#参考)
  - [公式](#公式)

## コマンド

### プロジェクト作成

``` bash
sam init
```

### ビルド

``` bash
sam build
```

### ローカル実行

``` bash
sam local start-api
```

### デプロイ

``` bash
# デプロイ権限が必要。
sam deploy --guided
```

#### 権限

- AWSCloudFormationFullAccess
- AWSLambda_FullAccess
- IAMFullAccess
- AmazonAPIGatewayAdministrator

### 参考

- [チュートリアル](https://docs.aws.amazon.com/ja_jp/serverless-application-model/latest/developerguide/serverless-getting-started-hello-world.html)
- [AWS SAM を使用するための IAM ポリシー:のべラボ.blog](https://nobelabo.hatenablog.com/entry/2022/07/31/142738)

## 公式

- [デベロッパーガイド](https://docs.aws.amazon.com/ja_jp/serverless-application-model/latest/developerguide/what-is-sam.html)