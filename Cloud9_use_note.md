# Cloud9 Use Note
Cloud9を使うときに一緒に持っていきたいメモ

- [Cloud9 Use Note](#cloud9-use-note)
  - [ドキュメントホーム](#ドキュメントホーム)
  - [git](#git)
  - [ディスク使用量チェック](#ディスク使用量チェック)
    - [コマンド](#コマンド)
    - [ディレクトリごとの使用量確認](#ディレクトリごとの使用量確認)
  - [ant](#ant)
    - [サンプルダウンロード](#サンプルダウンロード)
  - [Docker](#docker)
  - [AWS](#aws)
    - [グローバルIP取得](#グローバルip取得)
    - [S3](#s3)
      - [例のページ](#例のページ)
  - [WSL2](#wsl2)
    - [使用可能なメモリを増やす](#使用可能なメモリを増やす)
      - [参考](#参考)
  - [その他](#その他)

## ドキュメントホーム
[https://docs.aws.amazon.com/cloud9/index.html](https://docs.aws.amazon.com/cloud9/index.html)

## git

[git.md](./Git_cli/git.md)

## ディスク使用量チェック
https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ebs-describing-volumes.html

### コマンド
```
df -hT /dev/xvda1
```

### ディレクトリごとの使用量確認
```
du -ms <対象ディレクトリ>　| sort -nr | less
```

## ant

### サンプルダウンロード
```
git pull https://github.com/SampleUser0001/ant_Sample.git
```

## Docker

[Docker.md](./Docker/Docker.md)

## AWS

### グローバルIP取得

```
curl http://169.254.169.254/latest/meta-data/public-ipv4
```

### S3

#### 例のページ

down
```
aws s3 cp s3://ittimfn-public/index.html .
```

up
```
aws s3 cp ./index.html s3://ittimfn-public/index.html
```

## WSL2

### 使用可能なメモリを増やす

Windows側から設定する。

1. ```%UserProfile%\.wslconfig```を開く。
2. memoryの値を修正する。
3. PowerShellで下記を実行する。
   - ```wsl --shutdown```


#### 参考

- [Qiita:WSL2のメモリ割り当て量を変えたい](https://qiita.com/Ischca/items/121d91eb3b1a0a1cd8a8)

## その他

- [Githubの認証方法をプライベートトークンに変更する](./other/Github_authentication_token.md)
