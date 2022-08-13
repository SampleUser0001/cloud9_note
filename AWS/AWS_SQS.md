# AWS SQS

- [AWS SQS](#aws-sqs)
  - [概要](#概要)
    - [Note](#note)
  - [登録](#登録)
  - [取得](#取得)
  - [削除](#削除)

## 概要

- 登録したときに発生すること
  - AWS SQSから値が取得できるようになる。
  - メッセージは「利用可能なメッセージ」でカウントする。
- 取得したときに発生すること
  - 他のコンシューマーからは見えなくなる。
  - 可視性タイムアウトのカウントが開始する。
  - メッセージが「利用可能なメッセージ」から「処理中のメッセージ」に移行する。

### Note

- メッセージはreceive-messageしても消えない。
    - 削除は下記。
        1. メッセージ保持期間を経過する。
        2. 取得してから可視性タイムアウトが経過するまでの間にdelete-messageを呼ぶ。
              - 削除するときはReceiptHandleを使う。
              - ReceiptHandleは
- FIFOはmessage-group-id間でのみ守られる。

## 登録

``` bash
aws sqs send-message --queue-url "${SQS_QUEUE_URL}" --message-body "$(date)" --message-group-id "${message_group_id}" 
```

## 取得

``` bash
aws sqs receive-message --queue-url "${SQS_QUEUE_URL}" --attribute-names MessageGroupID="${message_group_id}" --max-number-of-messages 10 | jq -r '.Messages | .[] | [.MessageId, .Body] | @csv '
```

## 削除

``` bash
# MessageIdではなく、ReceiptHandleを使う。
ReceiptHandle=$(aws sqs receive-message --queue-url "${SQS_QUEUE_URL}" --attribute-names MessageGroupID=$message_group_id --max-number-of-messages 10 | jq -r '.Messages[] | .ReceiptHandle')

aws sqs delete-message --queue-url "${SQS_QUEUE_URL}" --receipt-handle "${ReceiptHandle}"
```