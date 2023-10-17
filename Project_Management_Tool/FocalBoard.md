# FocalBoard

- [FocalBoard](#focalboard)
  - [docker-compose.yml](#docker-composeyml)
  - [layout archive](#layout-archive)

## docker-compose.yml

``` yml
version: '3'
services:
  focalboard:
    image: mattermost/focalboard:latest
    container_name: focalboard
    ports: 
      - "8000:8000"
    environment:
      FOCALBOARD_API_ENABLED: "true"
```

ログイン時は最初にユーザ作成を行う。

## layout archive

[download](./focalboard_archive/archive-2023-10-17.boardarchive)