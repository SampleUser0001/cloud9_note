# その他

- [その他](#その他)
  - [aws cli history](#aws-cli-history)
    - [codepipeline](#codepipeline)
      - [パイプライン一覧取得](#パイプライン一覧取得)
      - [全パイプラインの情報出力](#全パイプラインの情報出力)
      - [参考](#参考)
  - [Github以外](#github以外)

## aws cli history

### codepipeline

#### パイプライン一覧取得

``` sh
aws codepipeline list-pipelines
```

#### 全パイプラインの情報出力

``` sh 
#!/bin/bash
while read data ; do
  aws codepipeline -get-pipeline --name ${data} > ${data}.json
done << END
`aws codepipeline list-pipelines | jq -r '.[] | .[] | .name'`
```

#### 参考

- [パイプラインの詳細と履歴を表示する (CLI):AWS ユーザーガイド](https://docs.aws.amazon.com/ja_jp/codepipeline/latest/userguide/pipelines-view-cli.html)

## Github以外

- 自動テストの結果をレポートグループとして出力する
  - AWS CodeCommitの「Java_for_Test」を参照。