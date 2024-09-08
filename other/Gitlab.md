# Gitlab

- [Gitlab](#gitlab)
  - [docker-composeを使用して構築する](#docker-composeを使用して構築する)
    - [参考](#参考)
  - [コミット時の表示時刻をJSTにする](#コミット時の表示時刻をjstにする)

## docker-composeを使用して構築する

1. sshポートを変更する
    1. `sudo nano /etc/ssh/sshd_config`
    2. `Port = 2424`
    3. `sudo systemctl restart ssh`
2. volume(ディレクトリ作成)

    ``` bash
    sudo mkdir -p /srv/gitlab
    ```
3. 環境変数設定

    ``` bash
    export GITLAB_HOME=/srv/gitlab
    ```

4. docker-compose.yml作成
    - 設定例は下記。
        - GitlabのバージョンはDocker Hubで確認。

        ``` yml
        version: '3.6'
        services:
        gitlab:
            image: gitlab/gitlab-ee:17.1.6-ee.0
            container_name: gitlab
            restart: always
            hostname: 'gitlab.example.com'
            environment:
            GITLAB_OMNIBUS_CONFIG: |
                external_url 'http://gitlab.example.com:8929'
                gitlab_rails['gitlab_shell_ssh_port'] = 2424
            ports:
            - '8929:8929'
            - '443:443'
            - '2424:22'
            volumes:
            - '$GITLAB_HOME/config:/etc/gitlab'
            - '$GITLAB_HOME/logs:/var/log/gitlab'
            - '$GITLAB_HOME/data:/var/opt/gitlab'
            shm_size: '256m'
        ```

5. `docker compose up -d`
6. [http://localhost:8929/](http://localhost:8929/)

### 参考

- [Install GitLab in a Docker container:Gitlab](https://docs.gitlab.com/ee/install/docker/installation.html)

## コミット時の表示時刻をJSTにする

1. /etc/gitlab/gitlab.rbを修正する

修正前

``` ruby
# gitlab_rails['time_zone'] = 'UTC'
```

修正後

``` ruby
gitlab_rails['time_zone'] = 'Asia/Tokyo'
```

2. 下記を実行する

``` sh
gitlab-ctl reconfigure
```
