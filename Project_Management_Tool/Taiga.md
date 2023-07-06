# Taiga

- [Taiga](#taiga)
  - [init](#init)
    - [起動](#起動)
    - [URL](#url)
    - [日本語化](#日本語化)
    - [参考](#参考)

## init 

### 起動

Docker前提。

``` bash
git clone https://github.com/kaleidos-ventures/taiga-docker.git
cd taiga-docker
git checkout -b stable origin/stable

# 起動
./launch-all.sh

# 管理ユーザ作成
./taiga-manage.sh createsuperuser
# ユーザ名、メールアドレス、パスワード、パスワード（確認用）を聞かれる。
```

### URL

[http://localhost:9000](http://localhost:9000)

### 日本語化

1. 右上 -> Account Settings -> USERSETTINGS
2. Language -> 日本語
3. Save

### 参考

- [オープンソースのプロジェクト管理ツール「Taiga」を試してみた : DevelopersIO](https://dev.classmethod.jp/articles/try-project-management-tool-taiga/)