# Android アプリ開発

- [Android アプリ開発](#android-アプリ開発)
  - [開発環境構築](#開発環境構築)
    - [日本語化](#日本語化)
    - [参考](#参考)
  - [起動](#起動)
  - [adbコマンド](#adbコマンド)
    - [Ubuntuで実機を認識させるための設定](#ubuntuで実機を認識させるための設定)
    - [実機での実行](#実機での実行)
  - [KVM設定（エミュレータ高速化）](#kvm設定エミュレータ高速化)
    - [Android端末が接続されていることを確認する](#android端末が接続されていることを確認する)
      - [USB](#usb)
      - [adb確認](#adb確認)
  - [Android StudioなしでコマンドラインからAndroidエミュレータを起動する](#android-studioなしでコマンドラインからandroidエミュレータを起動する)
    - [前提](#前提)
    - [コマンド](#コマンド)
  - [Android端末の開発者モードを有効化する](#android端末の開発者モードを有効化する)

## 開発環境構築

(VSCodeは諦めて)Android Studioを導入する。

1. ダウンロード
2. 下記実行。
    ``` bash
    # ファイル配置
    sudo cp ${ダウンロードしたファイル} /usr/local

    # 解凍
    cd /usr/local
    sudo zxvf ${ダウンロードしたファイル} 

    # 初回起動
    cd /usr/local/android-studio/bin
    bash studio.sh

    ```

3. PATHに追加
    - `~/.bashrc`に下記を追記
        ``` bash
        # Android Studio
        export ANDROID_STUDIO_HOME="/usr/local/android-studio"
        export PATH="$PATH:$ANDROID_STUDIO_HOME/bin"
        ```

### 日本語化

1. Android Studioのバージョンを確認
    1. 起動
    2. 左下のOptions Menu -> About
2. [JetBrains Language Pack for Android Studio](https://plugins.jetbrains.com/plugin/13964-japanese-language-pack------/versions)から、一致するバージョンの言語パックをダウンロード
3. 下記実行
    ``` bash
    sudo cp ${ダウンロードしたファイル} $ANDROID_STUDIO_HOME/plugins
    cd $ANDROID_STUDIO_HOME/plugins
    sudo unzip ${ダウンロードしたファイル}
    sudo rm ${ダウンロードしたファイル}
    ```
4. Android Studio -> Plugins -> 歯車アイコン -> Install Plugin from Disk
5. `/usr/local/android-studio/plugins/ja.${ダウンロードしたバージョン}/lib/ja.${ダウンロードしたバージョン}.jar`
6. Android Studio再起動
7. Customize -> Language and Legionで日本語を選択
8. Android Studio再起動

### 参考

- [Android Studio](https://developer.android.com/studio?hl=ja)

## 起動

``` bash
studio
```

## adbコマンド

### Ubuntuで実機を認識させるための設定

- ターミナルで以下のコマンドを実行して、udevルールを作成します

```bash
sudo apt install android-tools-adb
cd /etc/udev/rules.d/
sudo touch 51-android.rules
sudo chmod a+r 51-android.rules
```

- エディタで51-android.rulesを開き、以下の内容を追加します（VENDORIDは端末によって異なります）：

``` txt
SUBSYSTEM=="usb", ATTR{idVendor}=="VENDORID", MODE="0666", GROUP="plugdev"
```

（VENDORIDは、`lsusb`コマンドで確認できます。例：Googleデバイスは「18d1」）

- udevルールを再読み込みします

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

### 実機での実行

- 端末のUSBデバッグを有効にします（設定→開発者オプション→USBデバッグ）
- USBケーブルで端末をPCに接続します
- ターミナルで`adb devices`を実行して、デバイスが認識されていることを確認します
- Android Studioのデバイス選択ドロップダウンから実機を選択します
- 緑色の再生ボタン（▶）をクリックしてアプリをインストールします

## KVM設定（エミュレータ高速化）

``` bash
# インストール
sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils

sudo adduser $USER kvm
sudo adduser $USER libvirt

# ログアウト/ログインする
```

``` bash 
# インストールされているか確認
kvm-on
```

### Android端末が接続されていることを確認する

Android端末を接続しているにもかかわらず、うまく認識していないときに参照する。  

Android Studioを起動していると、`ps aux | grep adb`を実行すると、PIDが度々更新されるのが確認できる。  
その場合はAndroid Studioを停止する。

#### USB

``` bash
lsusb
```

#### adb確認

``` bash
# デバイスの確認
adb devices

# 停止/開始
adb kill-server && adb start-server
# 実行すると、Android側で切断/接続を検出する。接続モードの問い合わせが行われるので、画面から操作する。
```

## Android StudioなしでコマンドラインからAndroidエミュレータを起動する

### 前提

1. adbインストール済み
2. Android Studioコマンドラインツールインストール済み

### コマンド

``` bash
# 使用可能なエミュレータを表示
emulator -list-avds

# エミュレータ起動
emulator -avd $エミュレータ名
```

## Android端末の開発者モードを有効化する

1. 設定 -> デバイス情報 -> ビルド番号を7回タップ
2. 設定 -> システム -> 開発者向けオプションを有効化
