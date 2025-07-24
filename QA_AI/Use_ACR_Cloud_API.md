はい、ACR Cloud の API（主に「Identification API」）の使い方をご紹介します。大きく以下の手順で利用します。

---

- [1. 準備](#1-準備)
- [2. リクエスト先と HTTP メソッド](#2-リクエスト先と-http-メソッド)
- [3. リクエストパラメータ](#3-リクエストパラメータ)
- [4. リクエストの署名方法](#4-リクエストの署名方法)
- [5. サンプルコード](#5-サンプルコード)
  - [Python（`requests` 利用例）](#pythonrequests-利用例)
  - [Java（Apache Commons Codec 利用例）](#javaapache-commons-codec-利用例)
- [6. レスポンス例](#6-レスポンス例)
- [7. 参考リンク](#7-参考リンク)
- [File Scanning API で YouTube URL を渡す手順](#file-scanning-api-で-youtube-url-を渡す手順)
  - [ポイントまとめ](#ポイントまとめ)


## 1. 準備

1. **アカウント登録・プロジェクト作成**
   ACR Cloud コンソール（`https://console.acrcloud.com`）にサインアップし、新規プロジェクトを作成します。
2. **ホスト／Access Key／Access Secret の取得**
   プロジェクト詳細画面で、リージョンごとのホスト（例：`identify-eu-west-1.acrcloud.com`）と、`access_key`、`access_secret` を控えておきます。 ([docs.acrcloud.com][1])

---

## 2. リクエスト先と HTTP メソッド

* **エンドポイント**

  ```
  POST https://<HOST>/v1/identify  
  ```

  例：`https://identify-eu-west-1.acrcloud.com/v1/identify` ([docs.acrcloud.com][1])
* **Content-Type**
  `multipart/form-data`

---

## 3. リクエストパラメータ

| パラメータ名              | 型      | 説明                                 |
| ------------------- | ------ | ---------------------------------- |
| `sample`            | file   | 音声ファイル（15秒以内を推奨）または SDK で生成した指紋データ |
| `access_key`        | string | 取得した Access Key                    |
| `data_type`         | string | `audio` または `fingerprint`          |
| `signature_version` | string | `1`                                |
| `timestamp`         | number | UNIX エポック秒                         |
| `sample_bytes`      | number | ファイルサイズ（バイト）                       |
| `signature`         | string | 下記「署名方法」で生成                        |

---

## 4. リクエストの署名方法

リクエストの改ざん防止・認証のため、以下の文字列を HMAC-SHA1＋Base64 で署名します。

```
string_to_sign =
    HTTP_METHOD + "\n" +
    HTTP_URI    + "\n" +
    access_key  + "\n" +
    data_type   + "\n" +
    signature_version + "\n" +
    timestamp
```

* `HTTP_METHOD`：`POST`
* `HTTP_URI`  ：`/v1/identify`
* `access_key`：コンソールで取得したキー
* `data_type`：`audio` もしくは `fingerprint`
* `signature_version`：`1`
* `timestamp`：UNIX エポック秒（例：`1625256000`）

```python
import time, hmac, hashlib, base64

http_method = "POST"
http_uri    = "/v1/identify"
access_key  = "YOUR_ACCESS_KEY"
access_secret = "YOUR_ACCESS_SECRET"
data_type   = "audio"
signature_version = "1"
timestamp   = str(int(time.time()))

string_to_sign = "\n".join([
    http_method,
    http_uri,
    access_key,
    data_type,
    signature_version,
    timestamp
])
signature = base64.b64encode(
    hmac.new(access_secret.encode(),
             string_to_sign.encode(),
             digestmod=hashlib.sha1).digest()
).decode()
```

（上記サンプルは公式 Python デモより抜粋） ([docs.acrcloud.com][1])

---

## 5. サンプルコード

### Python（`requests` 利用例）

```python
import requests

# 先ほどの署名生成処理を終えた上で…
files = {
    'sample': ('sample.mp3', open('sample.mp3','rb'), 'audio/mpeg')
}
data = {
    'access_key': access_key,
    'sample_bytes': os.path.getsize('sample.mp3'),
    'timestamp': timestamp,
    'signature': signature,
    'data_type': data_type,
    'signature_version': signature_version
}

resp = requests.post(f"https://{host}/v1/identify",
                     files=files, data=data)
print(resp.json())
```

### Java（Apache Commons Codec 利用例）

```java
// 省略: HMAC-SHA1 と Base64 エンコード部分は公式サンプルを参照
URL url = new URL("https://" + host + "/v1/identify");
HttpURLConnection conn = (HttpURLConnection)url.openConnection();
conn.setRequestMethod("POST");
conn.setDoOutput(true);
conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
// …フォームデータの書き込み…
```

（詳細は公式サンプルを参照） ([docs.acrcloud.com][1]) ([GitHub][2])

---

## 6. レスポンス例

```json
{
  "status": {
    "msg": "Success",
    "code": 0,
    "version": "1.0"
  },
  "metadata": {
    "music": [
      {
        "title": "Shape of You",
        "artists": [ {"name": "Ed Sheeran"} ],
        "album": {"name": "÷ (Divide)"},
        // …
      }
    ]
  }
}
```

---

## 7. 参考リンク

* Identification API リファレンス（公式）
  [https://docs.acrcloud.com/reference/identification-api](https://docs.acrcloud.com/reference/identification-api) ([docs.acrcloud.com][1])
* GitHub: Web API サンプル集
  [https://github.com/acrcloud/webapi\_example](https://github.com/acrcloud/webapi_example) ([GitHub][2])

---

上記をベースに、ご利用言語やユースケース（音声認識、指紋認識、カスタムコンテンツ認識など）に応じて実装してみてください。何か詰まった点があればまたご質問ください！

[1]: https://docs.acrcloud.com/reference/identification-api "Identification API | ACRCloud"
[2]: https://github.com/acrcloud/webapi_example?utm_source=chatgpt.com "acrcloud/webapi_example - GitHub"


----

はい。ACR Cloud の Identification API（／v1/identify）はローカルで取得した音声サンプル（ファイルや指紋データ）しか受け付けないため、YouTube の URL そのものを渡すことはできません。代わりに「File Scanning API」を使うと、YouTube を含むプラットフォームの URL を直接アップロードして識別できます。

---

## File Scanning API で YouTube URL を渡す手順

1. **FS コンテナを作成**

   ```http
   POST https://api-v2.acrcloud.com/api/fs-containers
   Authorization: Bearer <YourAccessToken>
   Content-Type: application/json

   {
     "name":       "my-youtube-container",
     "region":     "eu-west-1",
     "buckets":    [1234, "ACRCloud Music"],
     "audio_type": "recorded",
     "engine":     1,
     "policy":     {"type":"traverse","interval":0,"rec_length":10}
   }
   ```

   これでコンテナ ID（例: `cid = 10005`）が返ってきます。 ([docs.acrcloud.com][1])

2. **YouTube URL をアップロード**

   ```bash
   curl -X POST "https://api-eu-west-1.acrcloud.com/api/fs-containers/10005/files" \
     -H "Accept: application/json" \
     -H "Authorization: Bearer <YourAccessToken>" \
     -H "Content-Type: application/json" \
     -d '{
           "data_type":"platforms",
           "url":"https://www.youtube.com/watch?v=d_xYl5hpiRs"
         }'
   ```

   * `data_type` に `"platforms"` を指定
   * `url` に YouTube 動画の URL を入れる ([docs.acrcloud.com][2])

3. **結果の取得**
   アップロード後は非同期処理となるので、ステータスが Ready（`state=1`）になるまでポーリングし、完了後に結果を取得します。

   ```http
   GET https://api-eu-west-1.acrcloud.com/api/fs-containers/10005/files?page=1&with_result=1
   Authorization: Bearer <YourAccessToken>
   ```

   レスポンス中の `"uri":"youtube:video:<動画ID>"` や `"results"` フィールドから識別結果を参照できます ([docs.acrcloud.com][2])。

---

### ポイントまとめ

* **Identification API**（`/v1/identify`）：手元の音声ファイルや SDK で生成した指紋データを直接投げる用途向け。
* **File Scanning API**：YouTube、Twitter、TikTok などのプラットフォーム URL や HTTP/FTP URL をそのまま投げられる。

YouTube URL を使いたい場合は File Scanning API をご利用ください。Reviewer’s tip: 実装言語（Python や Java、cURL など）のサンプルは公式ドキュメントをご参照ください。

[1]: https://docs.acrcloud.com/reference/console-api/file-scanning "File Scanning | ACRCloud"
[2]: https://docs.acrcloud.com/reference/console-api/file-scanning/file-scanning "FsFiles | ACRCloud"
