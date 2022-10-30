# EC2

- [EC2](#ec2)
  - [timezoneを変更する](#timezoneを変更する)
    - [参考](#参考)

## timezoneを変更する

``` bash
timedatectl list-timezones | grep 'Tokyo'
sudo timedatectl set-timezone Asia/Tokyo
```

### 参考

- [Amazon Linux での タイムゾーンの変更:公式](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/set-time.html#change_time_zone)