# AWS ECR

- [AWS ECR](#aws-ecr)
  - [手順](#手順)
    - [イメージに別名をつける](#イメージに別名をつける)
    - [pushする](#pushする)

## 手順

### プライベートレジストリの認証

``` sh
export AWS_REGION=（対象リージョン）
export AWS_ACCOUNT_ID=（アカウントID）
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
```

### イメージに別名をつける

``` sh
docker tag <イメージID> <AWS_ID>.dkr.ecr.<リージョン名>.amazonaws.com/<イメージ別名>:<タグ>
```

### pushする

``` sh
docker push <AWS_ID>.dkr.ecr.<リージョンID>.amazonaws.com/<イメージ別名>:<タグ>
```

