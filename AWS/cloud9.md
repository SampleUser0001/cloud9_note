# AWS Cloud9

- [AWS Cloud9](#aws-cloud9)
  - [owner以外のユーザがログインできるようにする](#owner以外のユーザがログインできるようにする)

## owner以外のユーザがログインできるようにする

1. ```aws cloud9 describe-environment-memberships```でcloud9の設定を取得
2. ```aws cloud9 create-environment-membership --environment-id ${environmentId} --user-arn arn:aws:sts::${アカウントID}:assumed-role/${ロール名}/${追加するユーザアカウント} --permissions read-write```で権限付与。