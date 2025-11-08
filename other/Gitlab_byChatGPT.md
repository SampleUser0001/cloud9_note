# GitLab / GitLab Runner 初期セットアップ手順

最新の GitLab 18.5.1 と Alpine ベースの GitLab Runner を、完全にクリーンな状態から構築した手順をまとめています。  
既存データを残したい場合は、作業前に `/srv/gitlab` および `/srv/gitlab-runner/config` をバックアップしてください。

---

## 1. 既存リソースの停止とデータ初期化

```bash
# コンテナとネットワークを完全に削除
docker compose down -v

# /srv 以下をクリーンにする（必要ならsudoで実行）
docker run --rm -v /srv:/srv alpine sh -c '\
  rm -rf /srv/gitlab /srv/gitlab-runner/config && \
  mkdir -p /srv/gitlab/config /srv/gitlab/data /srv/gitlab/logs /srv/gitlab-runner/config'
```

---

## 2. GitLab 18.5.1 の起動

```bash
docker compose up -d gitlab
```

`docker inspect gitlab --format '{{.State.Health.Status}}'` が `healthy` になるまで待つ。  
初期 root パスワードは以下で確認し、初回ログイン後に必ず変更してください。

```bash
docker exec gitlab cat /etc/gitlab/initial_root_password
```

---

## 3. Runner イメージのビルド

`Dockerfile_runner` は `gitlab/gitlab-runner:alpine` をベースに、以下を追加しています。

- `apk add --no-cache bash wget gnupg openjdk17 sudo`
- Maven 3.9.11 を `/opt/apache-maven` に展開
- `runner.env` を `/home/gitlab-runner/.profile` に配置

ビルドとタグ付け:

```bash
docker build --no-cache -t gitlab-gitlab-runner -f Dockerfile_runner .
```

---

## 4. Runner の登録

1. GitLab から登録トークンを取得  
   ```bash
   docker exec gitlab /bin/bash -lc "gitlab-rails runner 'puts Gitlab::CurrentSettings.current_application_settings.runners_registration_token'"
   ```
2. Runner 設定ディレクトリの所有権を Runner ユーザー (UID 100/GID 65533) に合わせる  
   ```bash
   docker run --rm -v /srv/gitlab-runner/config:/config alpine chown -R 100:65533 /config
   ```
3. `gitlab_default` ネットワーク上で登録コマンドを実行  
   ```bash
   docker run --rm --network gitlab_default \
     -v /srv/gitlab-runner/config:/etc/gitlab-runner \
     gitlab/gitlab-runner:alpine register \
     --non-interactive \
     --url http://gitlab.example.com:8929/ \
     --registration-token <TOKEN> \
     --executor shell \
     --description "Alpine Shell Runner" \
     --tag-list shell \
     --run-untagged \
     --locked=false \
     --access-level not_protected
   ```

---

## 5. サービスの起動と確認

```bash
docker compose up -d
docker compose ps
docker logs gitlab-gitlab-runner-1 --tail 50
```

- Runner ログに `403 Forbidden` などのエラーが出ていないことを確認
- `request_concurrency` に関する警告が出る場合は `/srv/gitlab-runner/config/config.toml` で値を増やして調整

---

## 6. 補足

- GitLab の管理設定は `/srv/gitlab/config/gitlab.rb` を編集し、`docker compose restart gitlab` で反映します。
- Runner 設定 (`/srv/gitlab-runner/config/config.toml`) を編集した場合も、`docker compose up -d gitlab-runner` で再読み込みします。
- `docker exec gitlab cat /etc/gitlab/initial_root_password` にあるパスワードファイルは 24 時間後の再構成で自動削除されるため、取得後すぐに安全な場所へ記録し更新してください。
