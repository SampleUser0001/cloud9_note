# Android アプリ開発

- [Android アプリ開発](#android-アプリ開発)
  - [開発環境構築](#開発環境構築)
    - [日本語化](#日本語化)
    - [参考](#参考)
  - [起動](#起動)

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
