# Amazon EventBridge

- [Amazon EventBridge](#amazon-eventbridge)
  - [aws cli](#aws-cli)
    - [put-rule](#put-rule)
      - [schedule-expression](#schedule-expression)
    - [put-targets](#put-targets)
    - [list-targets-by-rule](#list-targets-by-rule)
    - [remove-targets](#remove-targets)
  - [参考](#参考)

## aws cli

### put-rule

実行ルールを設定する。

| オプション | 効果 |
| :--------- | :--- |
| name                | イベント名 |
| schedule-expression | cron指定する。 |

#### schedule-expression

``` bash
# 「午前9時に」「何もしない」EventBridgeが作成される。
aws events put-rule \
    --name "DailyAutomationRule" \
    --schedule-expression "cron(0 9 * * ? *)"
```

### put-targets

実行対象(ターゲット)を設定する。

``` bash
# DailyAutomationRuleにLambdaを実行するように設定する。
aws events put-targets \
    --rule "DailyAutomationRule" \
    --cli-input-json input.json
```

input.jsonの中身  
```Input```はstringにする必要がある。
``` json
{
    "Targets": [
        {
            "Id" : "<任意の一意の値>",
            "Arn" : "arn:aws:lambda:<リージョン>:<アカウントID>:function:<Lambda関数名>",
            "Input" : "{\"queryStringParameters\": { \"name\" : \"EventBridge\" }}"
        }
    ]
}
```

### list-targets-by-rule

ターゲットを取得する。

``` bash
aws events list-targets-by-rule \
    --rule "${EventBridge名}"
```

### remove-targets

ターゲットを削除する。

``` bash
# idはlist-targets-by-ruleで確認する。
aws events remove-targets \
    --rule "${EventBridge名}" \
    --ids "${id_1}" "${id_2}" ... \
```

## 参考

- [EventBridge を使用したトリガーによるオートメーションの実行](https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/automation-cwe-target.html)
- [Amazon EventBridge のイベントパターン](https://docs.aws.amazon.com/ja_jp/eventbridge/latest/userguide/eb-event-patterns.html)
- [events : AWS CLI Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/events/index.html#cli-aws-events)
