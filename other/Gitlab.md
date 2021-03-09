# Gitlab

- [Gitlab](#gitlab)
  - [コミット時の表示時刻をJSTにする](#コミット時の表示時刻をjstにする)

## コミット時の表示時刻をJSTにする

1. /etc/gitlab/gitlab.rbを修正する

修正前

``` ruby
# gitlab_rails['time_zone'] = 'UTC'
```

修正後

``` ruby
gitlab_rails['time_zone'] = 'Asia/Tokyo'
```

2. 下記を実行する

``` sh
gitlab-ctl reconfigure
```
