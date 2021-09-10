# AWS CodeCommit

- [AWS CodeCommit](#aws-codecommit)
  - [アクセスキーの登録](#アクセスキーの登録)
    - [参考](#参考)
  - [clone](#clone)

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