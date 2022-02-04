# CodeBuild

- [CodeBuild](#codebuild)
  - [環境変数をcliで更新する](#環境変数をcliで更新する)
    - [参考](#参考)

## 環境変数をcliで更新する

1. ```aws codebuild batch-get-projects --names ${project_name} > ${project_name}.json```
2. ```${project_name}.json```から、nameと変更対象の項目以外をすべて削除
3. ```${project_name}.json```に、追加/変更したい項目を記載
4. ```aws codebuild update-project --name ${project_name} --cli-input-json file://${project_name}.json```を実行。
	- プロジェクトの設定が取得できれば成功。 

### 参考

- [ビルドプロジェクトの設定の変更 (AWS CLI):AWSドキュメント](https://docs.aws.amazon.com/ja_jp/codebuild/latest/userguide/change-project-cli.html)
- [update-project:codebuild:AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/codebuild/update-project.html)