# Selenium(Java)

- [Selenium(Java)](#seleniumjava)
  - [ドライバを最新にする](#ドライバを最新にする)
    - [Mavenから](#mavenから)
    - [ChromeDriverを導入する](#chromedriverを導入する)

## ドライバを最新にする

うまく動いてくれる方を選択する。

### Mavenから

```xml
<!-- Selenium WebDriver -->
<dependency>
    <groupId>org.seleniumhq.selenium</groupId>
    <artifactId>selenium-java</artifactId>
    <version>4.15.0</version> <!-- 最新バージョンを確認 -->
</dependency>
<!-- ChromeDriver -->
<!-- https://mvnrepository.com/artifact/io.github.bonigarcia/webdrivermanager -->
<dependency>
    <groupId>io.github.bonigarcia</groupId>
    <artifactId>webdrivermanager</artifactId>
    <version>5.6.2</version> <!-- 最新バージョンを確認 -->
</dependency>
```

### ChromeDriverを導入する

当初は[このページ](https://chromedriver.chromium.org/downloads)だったようだが、Ver.115以降は[こっちのページ](https://googlechromelabs.github.io/chrome-for-testing/)からダウンロードする。

``` bash
zip_url=

mkdir /tmp/ChromeDriver
cd /tmp/ChromeDriver
wget $zip_url

zip_path=$(ls)

unzip $zip_path

# 解凍して作成されたディレクトリをコピーする。ディレクトリ名とバージョンは確認する。
sudo cp chrome-linux64 /usr/local/bin/chrome-linux64-119.0.6045.105

sudo ln -s /usr/local/bin/chrome-linux64-119.0.6045.105 /usr/local/bin/chromedriver

# /tmp/ChromeDriverを削除
```
