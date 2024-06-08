# Youtube API

- [Youtube API](#youtube-api)
  - [共通](#共通)
  - [動画情報取得](#動画情報取得)
    - [ドキュメントURL](#ドキュメントurl)
  - [検索する](#検索する)
    - [ドキュメントURL](#ドキュメントurl-1)
    - [生配信予定の動画情報を取得する](#生配信予定の動画情報を取得する)
    - [配信中の動画情報を取得する。](#配信中の動画情報を取得する)
    - [動画を検索する](#動画を検索する)
  - [チャンネルIDがわからない](#チャンネルidがわからない)

## 共通

``` bash
YOUTUBE_API_URL=https://www.googleapis.com/youtube/v3
YOUTUBE_API_KEY=${取得した値}

# 基本形は下記。
# FUNCTION=${使いたい機能}
curl -X GET ${YOUTUBE_API_URL}/${FUNCTION}?key=${YOUTUBE_API_KEY}
```

## 動画情報取得

``` bash
FUNCTION=videos
VIDEO_ID=${取得対象の動画ID}
```

``` bash
curl -X GET ${YOUTUBE_API_URL}/${FUNCTION}?key=${YOUTUBE_API_KEY}\&id=${VIDEO_ID}\&part=liveStreamingDetails
```

### ドキュメントURL

- [Youtube - Data API](https://developers.google.com/youtube/v3/docs/videos/list?hl=ja)

## 検索する

``` bash
FUNCTION=search
```

### ドキュメントURL

- [Search: list \| Youtube Data API](https://developers.google.com/youtube/v3/docs/search/list?hl=ja)

### 生配信予定の動画情報を取得する

`eventType`に`upcoming`を指定する。

``` bash
CHANNEL_ID=${取得対象のチャンネルID}
curl -X GET ${YOUTUBE_API_URL}/${FUNCTION}?key=${YOUTUBE_API_KEY}\&channelId=${CHANNEL_ID}\&part=id\&type=video\&eventType=upcoming
```

### 配信中の動画情報を取得する。

`eventType`に`live`を指定する。

``` bash
CHANNEL_ID=${取得対象のチャンネルID}
curl -X GET ${YOUTUBE_API_URL}/${FUNCTION}?key=${YOUTUBE_API_KEY}\&channelId=${CHANNEL_ID}\&part=id\&type=video\&eventType=live
```

### 動画を検索する

`q`オプションで検索する。

``` bash
YOUTUBE_API_KEY=${自分のAPI_KEY}
YOUTUBE_API_URL=https://www.googleapis.com/youtube/v3
FUNCTION=search
KEYWORD=シレン
CHANNEL_ID=${必要であれば指定する}

API="${YOUTUBE_API_URL}/${FUNCTION}?key=${YOUTUBE_API_KEY}&q=${KEYWORD}&part=snippet&type=video&channelId=${CHANNEL_ID}"

curl -X GET $API
```

## チャンネルIDがわからない

YouTube Data APIで検索する。  
`q`オプションと、`type=channel`で検索する。

``` bash
YOUTUBE_API_KEY=${自分のAPI_KEY}
YOUTUBE_API_URL=https://www.googleapis.com/youtube/v3
FUNCTION=search
USER_NAME=${検索したいユーザ名}
MAX_RESULTS=1

curl -X GET ${YOUTUBE_API_URL}/${FUNCTION}?key=${YOUTUBE_API_KEY}\&q=${USER_NAME}\&part=snippet\&type=channel\&maxResults=${MAX_RESULTS}
```

