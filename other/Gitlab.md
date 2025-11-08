# Gitlab

- [Gitlab](#gitlab)
  - [docker-composeを使用して構築する](#docker-composeを使用して構築する)
    - [参考](#参考)
  - [CI/CDを動かす場合](#cicdを動かす場合)
    - [コンテナ作成](#コンテナ作成)
    - [Runner登録](#runner登録)
    - [CI/CD(.gitlab-ci.yml)](#cicdgitlab-ciyml)
  - [コミット時の表示時刻をJSTにする](#コミット時の表示時刻をjstにする)
  - [バックアップ例](#バックアップ例)
  - [ChatGPTに聞いた](#chatgptに聞いた)

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
6. rootパスワードファイルを取得する。24時間後の最初の再設定実行時に自動的に削除される。
    - `sudo docker cp ${container_id} cp:/etc/gitlab/initial_root_password .`
7. [http://localhost:8929/](http://localhost:8929/)

### 参考

- [Install GitLab in a Docker container:Gitlab](https://docs.gitlab.com/ee/install/docker/installation.html)

## CI/CDを動かす場合

Gitlab本体と別に、Runner（ビルドを実行する環境）が必要。  
Java + Mavenを例にとって記載。

### コンテナ作成

`hostname`はURLを求められたときに参照するので、把握しておく。

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
  gitlab-runner:
    build:
      context: .
      dockerfile: Dockerfile_runner
    volumes:
     - '/srv/gitlab-runner/config:/etc/gitlab-runner'
     - '/var/run/docker.sock:/var/run/docker.sock'
    env_file:
      - runner.env
    depends_on:
      - gitlab
```

``` Dockerfile
# Use the GitLab Enterprise Edition base image
# FROM gitlab/gitlab-ee:17.1.6-ee.0
FROM gitlab/gitlab-runner:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget gnupg2 openjdk-17-jdk sudo

# Install Maven
WORKDIR /tmp
ARG MAVEN_VERSION="3.9.9"
RUN wget https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -xzvf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/apache-maven

# Set environment variables
# ENV JAVA_HOME=/usr/lib/jvm/adoptopenjdk-17-hotspot

# Runnerはrootで登録するが、ビルドはgitlab-runnerユーザで実行される。
# ${HOME}/.profileがないので、${HOME}/.bashrcに記載しても呼び出されない。
COPY runner.env /home/gitlab-runner/.profile
RUN chown gitlab-runner:gitlab-runner /home/gitlab-runner/.profile

# Verify installations
# RUN java -version && mvn -version

# ENTRYPOINT ["/usr/bin/dumb-init" "/entrypoint"]
# CMD ["run" "--user=gitlab-runner" "--working-directory=/home/gitlab-runner"]
```

- `runner.env`

``` bash 
export MAVEN_HOME=/opt/apache-maven
export MVN_HOME=/opt/apache-maven
export PATH=$PATH:$MVN_HOME/bin
```

### Runner登録

``` bash
docker compose exec -it gitlab-runner /bin/bash
```

``` bash
# ユーザがroot担っていることを確認した上で、
gitlab-runner register

# URL : http://gitlab.example.com:8929/

# Token
# プロジェクト -> 設定 -> CI/CD -> Runner -> プロジェクトRunnerのハンバーガーメニュー -> 登録トークン

# タグ：.gitlab-ci.ymlのtagsと比較される。
# Maven, development
# 等、カンマ区切りで指定する。

# description
# 任意の説明文
```

### CI/CD(.gitlab-ci.yml)

``` yaml
stages:
  - build
  - test
  - package

build:
  stage: build
  tags:
    - Maven
    - development
  script:
    - echo $USER
    - mvn clean compile

test:
  stage: test
  tags:
    - Maven
    - development
  script:
    - mvn test

package:
  stage: package
  tags:
    - Maven
    - development
  script:
    - mvn package
  artifacts:
    paths:
      - target/*.jar
```

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

## バックアップ例

Dockerで起動したGitlabのバックアップ例。  
関係ファイルは`/srv/gitlab`配下にある想定。  
`sudo`をつけて実行すること。(つけない場合、`/srv/gitlab`にアクセスできない。)

``` bash
#!/bin/bash

tmpdir=$(mktemp -d)

cp -r /srv/gitlab/config $tmpdir
cp -r /srv/gitlab/data $tmpdir

now=`date '+%Y%m%d_%H%M%S'`
zip -r gitlab-$now.zip $tmpdir 
```

## ChatGPTに聞いた

- [Gitlab_byChatGPT](./Gitlab_byChatGPT.md)