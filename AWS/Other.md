# その他

- [その他](#その他)
  - [VPC(Virtural Private Cloud)](#vpcvirtural-private-cloud)
    - [参考](#参考)
  - [セキュリティグループ](#セキュリティグループ)
    - [セキュリティグループルール](#セキュリティグループルール)
  - [aws cli history](#aws-cli-history)
    - [CodeBuild](#codebuild)
      - [CodeBuild情報取得](#codebuild情報取得)
      - [未整理](#未整理)
    - [CodePipeline](#codepipeline)
      - [パイプライン一覧取得](#パイプライン一覧取得)
      - [全パイプラインの情報出力](#全パイプラインの情報出力)
      - [参考](#参考-1)
    - [ECS](#ecs)
      - [未整理](#未整理-1)
    - [SecretsManager](#secretsmanager)
  - [Github以外](#github以外)

## VPC(Virtural Private Cloud)

AWS内のネットワーク。  
セキュリティグループを保持できる。  
VPCとインスタンス/サービスを紐付けて使用できる。

### 参考

- [Amazon VPC とは?:AWS](https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/what-is-amazon-vpc.html)
- [[AWS] VPC、サブネット、セキュリティグループまとめ:Qiita](https://qiita.com/melonattacker/items/145dd8763883cb922400)

## セキュリティグループ

インスタンス単位の通信制御で使用する。  
セキュリティグループルールの集合として使用する。

### セキュリティグループルール

下記を定義している。

- インバウンド/アウトバウンド
- IP
- ポート

## aws cli history

### CodeBuild

#### CodeBuild情報取得

``` sh
aws codebuild batch-get-projects --name ${CodeBuildName}
```

#### 未整理

``` bash
aws codebuild list-projects
aws codebuild list-builds-for-project --project-name ${プロジェクト名}
```

### CodePipeline

#### パイプライン一覧取得

``` sh
aws codepipeline list-pipelines
```

#### 全パイプラインの情報出力

``` sh 
#!/bin/bash
while read data ; do
  aws codepipeline get-pipeline --name ${data} > ${data}.json
done << END
`aws codepipeline list-pipelines | jq -r '.[] | .[] | .name'`
```

#### 参考

- [パイプラインの詳細と履歴を表示する (CLI):AWS ユーザーガイド](https://docs.aws.amazon.com/ja_jp/codepipeline/latest/userguide/pipelines-view-cli.html)

### ECS

#### 未整理

``` bash
aws ecs list-clusters
aws ecs describe-clusters --cluster ${クラスター名}
aws ecs describe-task-definition --task-definition ${タスク名}
```

### SecretsManager

``` bash
aws secretsmanager get-secret-value --secret-id ${arn名}
aws secretsmanager list-secrets
```

## Github以外

- 自動テストの結果をレポートグループとして出力する
  - AWS CodeCommitの「Java_for_Test」を参照。