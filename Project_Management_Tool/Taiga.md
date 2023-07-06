# Taiga

- [Taiga](#taiga)
  - [init](#init)
    - [URL](#url)
    - [参考](#参考)

## init 

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

(http://localhost:9000)[http://localhost:9000]

### 参考

- [オープンソースのプロジェクト管理ツール「Taiga」を試してみた : DevelopersIO](https://dev.classmethod.jp/articles/try-project-management-tool-taiga/)