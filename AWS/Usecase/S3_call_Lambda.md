# S3に配置したhtmlファイルからAWS Lambdaを呼ぶ

- [S3に配置したhtmlファイルからAWS Lambdaを呼ぶ](#s3に配置したhtmlファイルからaws-lambdaを呼ぶ)
  - [ステップ1: CORSの設定](#ステップ1-corsの設定)
  - [ステップ2: API Gatewayを使用する](#ステップ2-api-gatewayを使用する)
  - [ステップ3: HTMLファイルの更新](#ステップ3-htmlファイルの更新)
  - [ステップ4: セキュリティの確保](#ステップ4-セキュリティの確保)

AWS Lambda関数をS3に配置したHTMLファイルから呼び出すには、いくつかのステップを踏む必要があります。ここでは、セキュリティを意識した方法でこれを実現するための一般的な手順を説明します。

## ステップ1: CORSの設定

最初に、S3バケットでCORS（Cross-Origin Resource Sharing）を設定して、HTMLページがLambda関数にリクエストを送信できるようにする必要があります。CORS設定は、S3バケットのパーミッション設定に追加します。これにより、異なるドメインからのリクエストを許可できます。

## ステップ2: API Gatewayを使用する

Lambda関数を直接ウェブから呼び出すことはできません。そのため、API Gatewayを介してLambda関数にアクセスするエンドポイントを作成します。

1. **API Gatewayの作成:** API Gatewayを開き、「新しいAPI」を選択してLambda関数用のAPIを作成します。
2. **リソースとメソッドの設定:** 新しいリソースを作成し、それにHTTPメソッド（例: GET, POST）を関連付けます。メソッドの設定で、Lambda関数を統合タイプとして選択し、対象のLambda関数を指定します。
3. **CORSの有効化:** API GatewayでCORSを有効にし、必要なHTTPメソッドとヘッダーを許可します。
4. **デプロイ:** APIをデプロイし、エンドポイントURLを取得します。

## ステップ3: HTMLファイルの更新

HTMLファイル内でJavaScriptを使用して、API Gateway経由でLambda関数を呼び出すコードを記述します。`fetch`や`XMLHttpRequest`を使って、API Gatewayのエンドポイントにリクエストを送信します。

```javascript
fetch('API_GATEWAY_ENDPOINT_URL', {
  method: 'POST', // または 'GET'
  body: JSON.stringify(data), // リクエストにデータを含める場合
  headers: {
    'Content-Type': 'application/json'
  }
})
.then(response => response.json())
.then(data => console.log(data))
.catch((error) => console.error('Error:', error));
```

## ステップ4: セキュリティの確保

- **IAMロールとポリシー:** Lambda関数とAPI Gatewayに適切なIAMロールとポリシーを設定して、必要なAWSリソースへのアクセスを制限します。
- **APIキーの使用:** API GatewayでAPIキーを要求するように設定し、APIキーを持つクライアントのみがエンドポイントにアクセスできるようにします。
- **レート制限とクォータの設定:** API Gatewayでレート制限とクォータを設定し、DoS攻撃などの悪意のある使用を防ぎます。

これらのステップを踏むことで、S3に配置したHTMLファイルからセキュリティを意識してAWS Lambda関数を呼び出すことができます。