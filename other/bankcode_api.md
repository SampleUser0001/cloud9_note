# 金融機関コード API

- [金融機関コード API](#金融機関コード-api)
  - [通常](#通常)
  - [銀行名取得](#銀行名取得)
  - [支店名取得](#支店名取得)

## 通常

``` bash
apikey=
bankcode=0001
# 銀行名
curl -H "apikey: $apikey" https://apis.bankcode-jp.com/v3/banks/?filter=code==$bankcode

# 支店
branchcode=001
curl -H "apikey: $apikey" https://apis.bankcode-jp.com/v3/banks/$bankcode/branches/?filter=code==$branchcode
```

## 銀行名取得

``` bash
apikey=
bankcode=0001
curl -H "apikey: $apikey" -s https://apis.bankcode-jp.com/v3/banks/?filter=code==$bankcode | jq -r ".banks[] | .name"
```

## 支店名取得

``` bash
apikey=
bankcode=0001
branchcode=001
curl -H "apikey: $apikey" -s https://apis.bankcode-jp.com/v3/banks/$bankcode/branches/?filter=code==$branchcode | jq -r ".branches[] | .name"
```
