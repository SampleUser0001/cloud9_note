# ElastiCache

- [ElastiCache](#elasticache)
	- [ノードに接続する](#ノードに接続する)
		- [セキュリティグループの設定](#セキュリティグループの設定)
			- [設定する値](#設定する値)
		- [redis-cliインストール](#redis-cliインストール)
		- [接続](#接続)
		- [redis-cliコマンド](#redis-cliコマンド)
		- [参考](#参考)

## ノードに接続する

### セキュリティグループの設定

クラスターに設定されているSecurityGroupのインバウンドを設定する。

``` sh
# SecurityGroupの確認
aws elasticache describe-cache-clusters --cache-cluster-id ${対象のcluster名} | jq -r '.CacheClusters[].SecurityGroups'
```

#### 設定する値

- タイプ
    - カスタムTCP
- ポート
	- (デフォルトであれば)6379
- ソース
	- 接続元EC2インスタンスのセキュリティグループID

### redis-cliインストール

事前にgccをインストールしておく。

``` sh
cd /opt
sudo wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make distclean
make

# 必要に応じてエイリアスを通しておく。
alias redis-cli=/opt/redis-stable/src/redis-cli
```

### 接続

```
export redis_host=${ElastiCacheのホスト名}
redis-cli -c -h mycachecluster.eaogs8.0001.usw2.cache.amazonaws.com -p 6379
```

### redis-cliコマンド

``` sh
> set hoge 'hoge'
OK
```

``` sh
> get hoge
"hoge"
> get hoge
"hoge"
```

### 参考

- [](https://docs.aws.amazon.com/ja_jp/AmazonElastiCache/latest/red-ug/nodes-connecting.html)