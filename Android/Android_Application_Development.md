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
  - [プロジェクトの基本構成](#プロジェクトの基本構成)
    - [コマンド](#コマンド)
    - [ディレクトリ構成](#ディレクトリ構成)
    - [build.gradle](#buildgradle)
    - [settings.gradle](#settingsgradle)
    - [gradle.properties](#gradleproperties)
    - [gradle/wrapper/gradle-wrapper.properties](#gradlewrappergradle-wrapperproperties)
    - [app/build.gradle](#appbuildgradle)
    - [app/src/main/AndroidManifest.xml](#appsrcmainandroidmanifestxml)
    - [app/src/main/res/layout/activity\_main.xml](#appsrcmainreslayoutactivity_mainxml)
    - [app/src/main/res/values/strings.xml](#appsrcmainresvaluesstringsxml)
    - [app/src/java/${package}/MainActivity.java](#appsrcjavapackagemainactivityjava)
  - [Android StudioなしでコマンドラインからAndroidエミュレータを起動する](#android-studioなしでコマンドラインからandroidエミュレータを起動する)
    - [前提](#前提)
    - [コマンド](#コマンド-1)
  - [エミュレータにアプリをインストールする](#エミュレータにアプリをインストールする)
  - [エミュレータからログを取得してホストに送る](#エミュレータからログを取得してホストに送る)
  - [エミュレータから電話をかける](#エミュレータから電話をかける)
  - [エミュレータに電話をかける](#エミュレータに電話をかける)
    - [非通知でかける](#非通知でかける)
  - [Android端末の開発者モードを有効化する](#android端末の開発者モードを有効化する)
  - [ログ取得](#ログ取得)
  - [SQLite + inflater + オリジナルViewのサンプル](#sqlite--inflater--オリジナルviewのサンプル)

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

## Android端末が接続されていることを確認する

Android端末を接続しているにもかかわらず、うまく認識していないときに参照する。  

Android Studioを起動していると、`ps aux | grep adb`を実行すると、PIDが度々更新されるのが確認できる。  
その場合はAndroid Studioを停止する。

### USB

``` bash
lsusb
```

### adb確認

``` bash
# デバイスの確認
adb devices

# 停止/開始
adb kill-server && adb start-server
# 実行すると、Android側で切断/接続を検出する。接続モードの問い合わせが行われるので、画面から操作する。
```

## プロジェクトの基本構成

### コマンド

``` bash
gradle init --type java-application
```

### ディレクトリ構成

``` txt
my-android-app/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/
│   │   │   │   └── パッケージ名/
│   │   │   ├── res/
│   │   │   │   ├── layout/
│   │   │   │   ├── values/
│   │   │   │   └── drawable/
│   │   │   └── AndroidManifest.xml
│   │   └── test/
│   │       └── java/
│   │            └── パッケージ名/
│   └── build.gradle
├── build.gradle
├── settings.gradle
└── gradle.properties
```

### build.gradle

``` groovy
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.9.0'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()  
    }

    tasks.withType(JavaCompile).configureEach {
        options.fork = true
        options.forkOptions.executable = '/usr/lib/jvm/jdk-17.0.6+10/bin/javac'
    }
}
```

### settings.gradle

``` groovy
rootProject.name = 'android_helloworld'
include ':app'

```

### gradle.properties

``` ini
# Project-wide Gradle settings.
org.gradle.java.home=/usr/lib/jvm/jdk-17.0.6+10
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.useAndroidX=true
android.nonTransitiveRClass=true
```

### gradle/wrapper/gradle-wrapper.properties

gradleのバージョンが合わない場合はここを修正する。

``` ini
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.11.1-all.zip
networkTimeout=10000
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
```

### app/build.gradle

``` groovy
/*
 * This file was generated by the Gradle 'init' task.
 *
 * This generated file contains a sample Java application project to get you started.
 * For more details take a look at the 'Building Java & JVM projects' chapter in the Gradle
 * User Manual available at https://docs.gradle.org/7.6/userguide/building_java_projects.html
 */

plugins {
    id 'com.android.application'
}

android {
    namespace 'ittimfn.android.helloworld'
    compileSdk 35

    defaultConfig {
        applicationId "ittimfn.android.helloworld"
        minSdk 21
        targetSdk 35
        versionCode 1
        versionName "1.0"

        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }
}

dependencies {

    implementation 'androidx.appcompat:appcompat:1.7.0'
    implementation 'com.google.android.material:material:1.12.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.2.1'

    // JUnit5
    testImplementation 'org.junit.jupiter:junit-jupiter-api:5.12.1'
    testRuntimeOnly 'org.junit.jupiter:junit-jupiter-engine:5.12.1'
    testImplementation 'org.junit.platform:junit-platform-launcher:1.12.1'
    
    testImplementation 'org.hamcrest:hamcrest:3.0'
    androidTestImplementation 'androidx.test.ext:junit:1.2.1'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.6.1'    

}

// JUnit5のテストを実行するための設定
tasks.withType(Test) {
    useJUnitPlatform()
    testLogging {
        events "passed", "skipped", "failed"
    }
    
    // テストは常に実行されるようにする（ファイルに変更がなくても実行）
    outputs.upToDateWhen { false }
}

```

### app/src/main/AndroidManifest.xml

``` xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="ittimfn.android.helloworld">

    <!-- アイコンを追加したい場合は下記を追加。-->
    <!-- android:icon="@mipmap/ic_launcher" -->
    <!-- android:roundIcon="@mipmap/ic_launcher" -->
    <application
        android:allowBackup="true"
        android:label="@string/app_name"
        android:supportsRtl="true"
        android:theme="@style/Theme.AppCompat">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>

```

### app/src/main/res/layout/activity_main.xml

``` xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="@string/hello_world"
        android:textSize="24sp"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

### app/src/main/res/values/strings.xml

``` xml
<resources>
    <string name="app_name">Hello World</string>
    <string name="hello_world">Hello World!</string>
</resources>
```

### app/src/java/${package}/MainActivity.java

``` java
package ittimfn.android.helloworld;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
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


## エミュレータにアプリをインストールする

``` bash
# 拡張子 apkのファイルがAndroidアプリ。
# エミュレータが起動している状態で実行する。
adb install ./app/build/outputs/apk/debug/app-debug.apk
```

``` bash
# app-debug.apkをビルドする
./gradlew assembleDebug
# app-debug.apkをインストールする
./gradlew installDebug
```

## エミュレータからログを取得してホストに送る

1. エミュレータメニューの一番下
2. Bug report
3. Bug report dataをチェック
4. エラーになる操作を行う
5. Save Reportボタンを押下

## エミュレータから電話をかける

本物に対しても使える。

``` bash
# 発信先
tel_no=123
adb shell am start -a android.intent.action.CALL -d tel:$tel_no
```

## エミュレータに電話をかける

エミュレータにしか使えない。

``` bash
# 発信元
tel_no=123
adb emu gsm call $tel_no
```

### 非通知でかける

``` bash
# 直接指定するとかけられない。変数に代入する必要がある。
tel_no=#67080053
adb emu gsm call $tel_no
```

## Android端末の開発者モードを有効化する

1. 設定 -> デバイス情報 -> ビルド番号を7回タップ
2. 設定 -> システム -> 開発者向けオプションを有効化

## ログ取得

``` bash
adb logcat > logfile.txt

# ActivityManagerとMyAppのログのみを取得
adb logcat ActivityManager:I MyApp:D *:S > filtered_log.txt

# おすすめ
adb logcat -c
adb logcat -v long *:E
```

## SQLite + inflater + オリジナルViewのサンプル

- [https://github.com/SampleUser0001/Android_SQLite](https://github.com/SampleUser0001/Android_SQLite)