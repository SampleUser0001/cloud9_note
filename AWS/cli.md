# aws cli

- [aws cli](#aws-cli)
  - [s3](#s3)
    - [recursiveオプションの挙動](#recursiveオプションの挙動)
      - [S3 → local](#s3--local)

## s3

### recursiveオプションの挙動

#### S3 → local

S3ディレクトリが下記のとき、

``` txt
s3://${バケット名}/d1/d2
```

下記コマンドを実行すると、

``` sh
aws s3 cp s3://${バケット名}/d1 . --recursive
```

d2ディレクトリがローカルに作成される。

これも同じ挙動。

``` sh
aws s3 cp s3://${バケット名}/d1/ . --recursive
```
