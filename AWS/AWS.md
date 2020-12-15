# AWS

## AWS CloudFront

### S3 + CloudFrontで、S3へのアクセスを遮断する

1. S3バケットを作成する
2. 「ブロックパブリックアクセス (バケット設定)」の「パブリックアクセスをすべて ブロック」をオフにする。
3. 「バケットポリシー」に下記を設定する。
    - S3のオブジェクトにアクセスできるようにする設定。
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::<バケット名>/*"
        }
    ]
}
```
4. CloudFrontで「Create Distribution」を押下。
5. 下記設定。
    - Origin Domain Name：対象のS3バケット名
    - 必要に応じて、HTTPプロトコル、許可するメソッドを指定する。
6. Statusが「Deployed」になるまで待つ。
7. IDクリック → Origins and Origin Groups タブ → 作成済みの「Origins」を選択して「Edit」押下。
8. 下記設定。
    - Restrict Bucket Access：Yes
    - Origin Access Identity：Create a New Identity
        - どちらでもいいが…
    - Grant Read Permissions on Bucket：Yes, Update Bucket Policy
9. S3のバケットポリシーから「"Sid": "PublicReadGetObject"」を削除する。
10. CloudFrontのStatusが「Deployed」になるまで待つ。
