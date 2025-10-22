# OpenAI

## codex

### 初期設定

1. [https://platform.openai.com/settings/organization/api-keys](https://platform.openai.com/settings/organization/api-keys)でAPIを払い出す
2. ~/.bashrcなどに書く
    ``` bash
    export OPENAI_API_KEY=
    ```
3. 動作確認
    ``` bash
    curl https://api.openai.com/v1/models -H "Authorization: Bearer $OPENAI_API_KEY"
    ```