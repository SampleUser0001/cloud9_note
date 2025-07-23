# 動画から曲を取得するAPI

## 回答

はい、動画（あるいは動画から抽出した音声）を解析して「この曲は何か？」を返してくれる外部 API はいくつか存在します。代表例と特徴をまとめると次のとおりです。

### 1. ACRCloud

* **用途**: 15 秒程度の音声や動画ファイル／URLを送ると、8,500 万曲以上の指紋データベースから照合して曲名・アーティスト・ISRC などを返します。動画 URL（YouTube など）も直接指定可能。([ACRCloud][1], [docs.acrcloud.com][2])
* **無料枠 / 料金**: 無料トライアル（月200 リクエスト）→従量課金。
* **実装例（ざっくり）**

  ```bash
  curl -X POST -F "sample=@snippet.mp4" \
       -F "access_key=YOUR_KEY" \
       -F "data_type=fingerprint" \
       https://identify-eu-west-1.acrcloud.com/v1/identify
  ```

  戻り JSON の `"metadata.music[0].title"` が曲名になります。

### 2. AudD

* **用途**: 音声ファイル、ストリーム、長尺動画も対応。80 万曲ではなく“8,000 万曲超”の DB を謳い、YouTube／Spotify リンクや歌詞も返せるのが特徴。([audd.io][3], [docs.audd.io][4])
* **無料枠 / 料金**: 1 日あたり 10 リクエストのフリープラン、以降は月額または従量課金。
* **実装例**

  ```bash
  curl -F "url=https://example.com/sample.mp4" \
       -F "api_token=YOUR_TOKEN" \
       https://api.audd.io/
  ```

### 3. ShazamKit（Apple）

* **用途**: iOS／Android／Web のネイティブ SDK。アプリ内で録音した音、あるいは自前で用意したカスタムカタログ（動画・ポッドキャストなど）からマッチング可能。Shazam 本体と同じ楽曲カタログにアクセス。([Apple Developer][5], [Shazam][6])
* **料金**: 無料で使用可（Apple ID で登録）。ただし iOS 14 以降 / Android 8.1 以降が対象。
* **注意**: サーバー API ではなくクライアント SDK。バックエンドで一括処理したい場合は不向きです。

### 4. Gracenote MusicID

* **用途**: 業務向け大規模配信・メディア企業で採用。動画内の BGM も検出可能。API 利用は法人契約が前提。([Gracenote][7], [documentation.gracenote.com][8])
* **料金**: 個別見積もり（数万〜数十万円／月が一般的）。

### 5. その他

| 名前                        | 特徴                                                                        | 備考 |
| ------------------------- | ------------------------------------------------------------------------- | -- |
| **Houndify (SoundHound)** | 音声認識＋「何の曲か」検索の両方に対応。現状は曲認識 API の公開ドキュメントが少なく、営業問い合わせが必要。([SoundHound][9]) |    |
| **YouTube Content ID**    | 著作権判定用で公開 API では曲名までは返さない。                                                |    |
| **オープンソース (dejavu など)**   | 自前で DB を用意すれば動くが、楽曲指紋を網羅するのは現実的には困難。                                      |    |

---

## 選び方のポイント

1. **入力形式**

   * 動画 URL を直接渡せる → ACRCloud / AudD
   * クライアント SDK でリアルタイム認識 → ShazamKit
2. **レスポンスに含まれるメタデータ**

   * 歌詞・Spotify/Apple Music へのリンクが欲しい → AudD
   * ISRC・アルバム名まで必要 → ACRCloud / Gracenote
3. **料金とリクエスト頻度**

   * 開発検証なら無料枠の広い ACRCloud が手軽。
   * 商用大量トラフィックなら単価×認識数で試算し、トータルコストを比較。
4. **実装負荷**

   * 既に iOS/Android アプリを持っていて端末側で完結したい → ShazamKit
   * バックエンドでバッチ処理や YouTube の既存動画を解析 → ACRCloud / AudD

---

### まとめ

* **手軽に試す**なら **ACRCloud** か **AudD**。どちらも REST API で動画 URL または音声データを送るだけ。
* **Apple デバイス中心のアプリ**なら **ShazamKit** が無料で高精度。
* **法人向けの大規模・高保証サービス**が必要なら **Gracenote MusicID** を検討。

目的（リアルタイム vs バッチ、料金、必要メタデータ）に合わせて選択してください。どのサービスも無料トライアルがあるので、まずは短いサンプル動画で精度を比較すると良いでしょう。

[1]: https://www.acrcloud.com/?utm_source=chatgpt.com "ACRCloud - Audio Recognition Services For Doers"
[2]: https://docs.acrcloud.com/reference/identification-api?utm_source=chatgpt.com "Identification API - ACRCloud"
[3]: https://audd.io/?utm_source=chatgpt.com "AudD Music Recognition API"
[4]: https://docs.audd.io/?utm_source=chatgpt.com "AudD Music Recognition API Docs"
[5]: https://developer.apple.com/shazamkit/?utm_source=chatgpt.com "ShazamKit - Apple Developer"
[6]: https://www.shazam.com/en-us/shazamkit?utm_source=chatgpt.com "Music Discovery, Charts & Song Lyrics - Shazam"
[7]: https://gracenote.com/?utm_source=chatgpt.com "Gracenote | Media and Entertainment Metadata Solutions"
[8]: https://documentation.gracenote.com/on-api/html/Content/on-api-schema-docs/on-api-dev-guide.pdf?utm_source=chatgpt.com "[PDF] On API - Gracenote"
[9]: https://www.soundhound.com/?utm_source=chatgpt.com "SoundHound AI | Technology for a voice-enabled world"
