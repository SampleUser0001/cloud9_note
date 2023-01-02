# IBM MQ

- [IBM MQ](#ibm-mq)
  - [起動](#起動)
    - [参考](#参考)

## 起動

docker composeが使えること。

``` yml
version: '3'
services:
  mq:
    image: ibmcom/mq
    ports: 
      - 1414:1414
      - 9443:9443
    environment:
      - LICENSE=accept
      - LANG=ja
      - MQ_QMGR_NAME=QM1
      - LOG_FORMAT=json
      - MQ_ENABLE_METRICS=true
```

### 参考

- [mq-container:ibm-messaging:Github](https://github.com/ibm-messaging/mq-container/blob/master/docs/usage.md)
- [mq:dockerhub](https://hub.docker.com/r/ibmcom/mq)