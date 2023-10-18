# WeKan

- [WeKan](#wekan)
  - [docker-compose.yml](#docker-composeyml)
    - [参考](#参考)

## docker-compose.yml

ユーザはログイン画面から作成する。

``` yml
version: "2"
services:
  wekandb:
    image: mongo:4.4
    container_name: wekan-db
    restart: always
    command: mongod --logpath /dev/null --oplogSize 128 --quiet
    networks:
      - wekan-tier
    expose:
      - 27017
    volumes:
      - wekan-db:/data/db
      - wekan-db-dump:/dump
  wekan:
    image: wekanteam/wekan
    container_name: wekan-app
    restart: always
    networks:
      - wekan-tier
    ports:
      - 80:8080
    environment:
      - MONGO_URL=mongodb://wekandb:27017/wekan
      - ROOT_URL=http://localhost #   <=== using only at same laptop/desktop where Wekan is installed
      - MAIL_URL=smtp://<mail_url>:25/?ignoreTLS=true&tls={rejectUnauthorized:false}
      - MAIL_FROM=Wekan Notifications <noreply.wekan@mydomain.com>
      - WITH_API=true
      - RICHER_CARD_COMMENT_EDITOR=false
      - CARD_OPENED_WEBHOOK_ENABLED=false
      - BIGEVENTS_PATTERN=NONE
      - BROWSER_POLICY_ENABLED=true
    depends_on:
      - wekandb
volumes:
  wekan-db:
    driver: local
  wekan-db-dump:
    driver: local
networks:
  wekan-tier:
    driver: bridge
```

### 参考

[カンバンボード「wekan」をdockerでサクッと構築:SyachikuLOG](https://syachiku.net/%E3%82%AB%E3%83%B3%E3%83%90%E3%83%B3%E3%83%9C%E3%83%BC%E3%83%89%E3%80%8Cwekan%E3%80%8D%E3%82%92docker%E3%81%A7%E3%82%B5%E3%82%AF%E3%83%83%E3%81%A8%E6%A7%8B%E7%AF%89/)