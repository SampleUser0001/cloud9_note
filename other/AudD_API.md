# AudD API

- [AudD API](#audd-api)
  - [導入](#導入)
  - [実行例](#実行例)

## 導入

1. [公式サイト](https://dashboard.audd.io/)にログイン
2. Token取得

## 実行例

``` bash
#!/bin/bash

rm -f song.mp3
yt-dlp --extract-audio --audio-format mp3 $1 -o song.mp3

source .env
curl -X POST https://api.audd.io/ \
  -F api_token="$audd_token" \
  -F file=@song.mp3 \
  -F return="lyrics,spotify,apple_music"    
```

日本の歌が取れない？  
[この辺](https://www.youtube.com/watch?v=LIlZCmETvsY)はnull。  
[こっち](https://www.youtube.com/watch?v=yXQViqx6GMY)は取れた。  
