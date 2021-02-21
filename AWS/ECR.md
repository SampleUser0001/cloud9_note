# AWS ECR

- [AWS ECR](#aws-ecr)
  - [手順](#手順)
    - [イメージに別名をつける](#イメージに別名をつける)
    - [pushする](#pushする)

## 手順

### イメージに別名をつける

コマンド
```
docker tag <イメージID> <AWS_ID>.dkr.ecr.<リージョン名>.amazonaws.com/<イメージ別名>:<タグ>
```

実行例
```
docker tag f35b35b609c1 803549425051.dkr.ecr.ap-northeast-1.amazonaws.com/mq-server:latest     
```

### pushする
コマンド
```
docker push <AWS_ID>.dkr.ecr.<リージョンID>.amazonaws.com/<イメージ別名>:<タグ>
```

実行例
```
docker push 803549425051.dkr.ecr.ap-northeast-1.amazonaws.com/mq-server:latest
```
