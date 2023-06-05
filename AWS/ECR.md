# AWS ECR

AWSが提供しているDockerリポジトリ。

- [AWS ECR](#aws-ecr)
  - [リポジトリ作成](#リポジトリ作成)
  - [プライベートレジストリの認証](#プライベートレジストリの認証)
  - [イメージに別名をつける](#イメージに別名をつける)
  - [pushする](#pushする)
  - [Memo](#memo)

## リポジトリ作成

1. 検索窓に「Elastic Container Repository」と入力し、検索結果のサービスから同名のサービスをクリック。
2. 画面右上の「リポジトリの作成」ボタンを押下。
3. リポジトリ名の入力欄に任意の文字列を入力。
  - その他の設定も併せて入力。
4. 画面下部の「リポジトリの作成」ボタンを押下。

## プライベートレジストリの認証

``` sh
export AWS_REGION=（対象リージョン）
export AWS_ACCOUNT_ID=（アカウントID）
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
```

## イメージに別名をつける

``` sh
docker tag <イメージID> <AWS_ID>.dkr.ecr.<リージョン名>.amazonaws.com/<イメージ別名>:<タグ>
```

## pushする

``` sh
docker push <AWS_ID>.dkr.ecr.<リージョンID>.amazonaws.com/<イメージ別名>:<タグ>
```

## Memo

- AWS CodeBuildを使用してビルドする場合、Dockerfile内からCodeBuildの環境変数を参照することはできない。