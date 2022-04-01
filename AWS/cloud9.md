# AWS Cloud9

- [AWS Cloud9](#aws-cloud9)
  - [owner以外のユーザがログインできるようにする](#owner以外のユーザがログインできるようにする)
  - [ログインしている環境の情報を取得する](#ログインしている環境の情報を取得する)
    - [IPアドレス](#ipアドレス)
    - [インスタンスID](#インスタンスid)
    - [参考](#参考)

## owner以外のユーザがログインできるようにする

1. ```aws cloud9 describe-environment-memberships```でcloud9の設定を取得
2. ```aws cloud9 create-environment-membership --environment-id ${environmentId} --user-arn arn:aws:sts::${アカウントID}:assumed-role/${ロール名}/${追加するユーザアカウント} --permissions read-write```で権限付与。

## ログインしている環境の情報を取得する

### IPアドレス

``` bash
curl -q http://169.254.169.254/latest/meta-data/public-ipv4
```

### インスタンスID

``` bash
curl 169.254.169.254/latest/meta-data/instance-id/
```

### 参考

- [EC2インスタンス内から情報を取得する方法:Qiita](https://qiita.com/akikinyan/items/c6be02e1d48de46fca53)