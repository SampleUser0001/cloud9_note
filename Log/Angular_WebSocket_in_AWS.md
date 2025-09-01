# Angular + WebSocketをAWSで動かす

- [Angular + WebSocketをAWSで動かす](#angular--websocketをawsで動かす)
  - [概要](#概要)
  - [設定](#設定)
    - [Client](#client)
    - [Server](#server)
  - [やってみた結果](#やってみた結果)
    - [参考](#参考)

## 概要

- Client
    - [https://github.com/SampleUser0001/Angular_WebSocket_Client](https://github.com/SampleUser0001/Angular_WebSocket_Client)
    - AWS Amplifyで動かす
- Server
    - [https://github.com/SampleUser0001/Angular_WebSocket_Server](https://github.com/SampleUser0001/Angular_WebSocket_Server)
    - AWS App Runnerで動かす

## 設定

### Client

- `SERVER_URL` : AWS App Runnerで払い出されたURLのプロトコルを`wss://`に変更した値

### Server

特に何も

## やってみた結果

AWS App RunnerがWebSocketに対応していない。  
設定自体はあまり難しくない。  
Serverだけ消した。

### 参考

- [AWS App RunnerがWebSocketに対応していなかった : 浅井ブログ](https://acai-blog.com/articles/16)
- [AWS App Runner 振り返り 2023～決別・ECSを使うぞ～ : koudenpaのブログ](https://koudenpa.hatenablog.com/entry/2023/12/04/000000)