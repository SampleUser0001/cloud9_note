# EFS

- [EFS](#efs)
  - [AWS外の環境でamazon-efs-utilsをビルド＋インストールする](#aws外の環境でamazon-efs-utilsをビルドインストールする)
    - [参考](#参考)
  - [EFSヘルパーを使ってマウントする](#efsヘルパーを使ってマウントする)

## AWS外の環境でamazon-efs-utilsをビルド＋インストールする

``` bash
sudo apt-get -y install git binutils

git clone https://github.com/aws/efs-utils
cd efs-utils
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb

sudo nano /etc/amazon/efs/efs-utils.conf
```

``` conf
# コメントアウトされているので、外して修正する。
#The region of the file system when mounting from on-premises or cross region.
region = ap-northeast-1
```

### 参考

- [Amazon EFS クライアントの手動インストール](https://docs.aws.amazon.com/ja_jp/efs/latest/ug/installing-amazon-efs-utils.html)

## EFSヘルパーを使ってマウントする

``` bash
sudo yum install amazon-efs-utils
mkdir /mnt/efs

mount -t efs ${file_system_id} /mnt/efs
```
