# Vegeta on Docker

## 基本のコマンド

``` sh
docker run --rm -i peterevans/vegeta sh -c "echo 'GET http://hogehoge.jp/' | vegeta attack -rate=10 -duration=30s | tee results.bin | vegeta report"
```

## 参考

- [DockerHub:peterevans/vegeta](https://hub.docker.com/r/peterevans/vegeta)
