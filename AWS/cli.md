# aws cli

- [aws cli](#aws-cli)
  - [S3](#s3)
    - [正規表現を使う](#正規表現を使う)
    - [recursiveオプションの挙動](#recursiveオプションの挙動)
      - [S3 → local](#s3--local)

## S3

### 正規表現を使う

``` bash
aws s3 rm s3://${バケット名}/${パス}/ --exclude '*' --include '${処理対象の正規表現}' --recursive --dryrun
```

- ```--dryrun```で確認したほうが良い。
- 再帰処理される。
  - ```--recursive```オプションの影響だが、削除すると動かない。

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
