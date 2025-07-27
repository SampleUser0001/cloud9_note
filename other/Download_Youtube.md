# Youtubeから動画をダウンロードする

- [Youtubeから動画をダウンロードする](#youtubeから動画をダウンロードする)
  - [コマンド](#コマンド)

## コマンド

``` bash
#!/bin/bash

rm -f song.mp3
yt-dlp --extract-audio --audio-format mp3 $1 -o song.mp3
```
