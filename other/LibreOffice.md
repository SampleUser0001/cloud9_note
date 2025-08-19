# Libre Office

- [Libre Office](#libre-office)
  - [Install](#install)

## Install

1. 下記からインストーラと言語パック(翻訳されたユーザーインターフェース)をダウンロード
    - [https://ja.libreoffice.org/download/download/?type=rpm-x86_64&version=25.2.5&lang=ja](https://ja.libreoffice.org/download/download/?type=rpm-x86_64&version=25.2.5&lang=ja)
2. 解凍
3. 下記実行。

``` bash
libra_office_install.sh $install_file_home
```

``` bash
install_file_home=$1

#!/bin/bash

echo "LibreOffice 25.2.5.2 日本語版のインストールを開始します..."

# LibreOffice本体のインストール
echo "1. LibreOffice本体をインストール中..."
cd $install_file_home/LibreOffice_25.2.5.2_Linux_x86-64_deb/DEBS
sudo dpkg -i *.deb

# 依存関係の解決
echo "2. 依存関係を解決中..."
sudo apt-get install -f -y

# Alienのインストール（RPM→DEB変換用）
echo "3. Alienをインストール中..."
sudo apt-get install alien -y

# 日本語言語パックの変換とインストール
echo "4. 日本語言語パックをインストール中..."
cd $install_file_home/LibreOffice_25.2.5.2_Linux_x86-64_rpm_langpack_ja/RPMS
sudo alien -d *.rpm
sudo dpkg -i *.deb

echo "インストール完了！LibreOfficeを起動して日本語が使用できることを確認してください。"
```
