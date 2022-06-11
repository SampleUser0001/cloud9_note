# Github API

- [Github API](#github-api)
  - [トークンを使用する](#トークンを使用する)

## トークンを使用する

トークンを作成しなくてもAPIを叩けるが、時間当たりの実行可能回数が少ない（60回/1時間）。  
トークンを生成し、トークンを使ってアクセスする。

トークンは[このページ](https://github.com/settings/tokens)から作成する。

``` bash
GITHUB_USERNAME=
GITHUB_TOKEN=
curl -i -u $GITHUB_USERNAME:$GITHUB_TOKEN https://api.github.com/users/octocat | less

# x-ratelimit-limitに使用可能な回数が表示される。
```