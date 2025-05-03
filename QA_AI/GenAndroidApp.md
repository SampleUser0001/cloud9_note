# VS Code + GradleでのAndroid「Hello World」アプリ開発チュートリアル

- [VS Code + GradleでのAndroid「Hello World」アプリ開発チュートリアル](#vs-code--gradleでのandroidhello-worldアプリ開発チュートリアル)
  - [プロンプト](#プロンプト)
  - [前提条件のインストール](#前提条件のインストール)
    - [1. JDKのインストール](#1-jdkのインストール)
    - [2. Android SDKのインストール](#2-android-sdkのインストール)
    - [3. VS Codeのインストール](#3-vs-codeのインストール)
    - [4. VS Code拡張機能のインストール](#4-vs-code拡張機能のインストール)
    - [5. Gradleのインストール](#5-gradleのインストール)
  - [プロジェクトの作成](#プロジェクトの作成)
    - [1. 新しいAndroidプロジェクトの作成](#1-新しいandroidプロジェクトの作成)
    - [2. Androidプロジェクト構造の設定](#2-androidプロジェクト構造の設定)
    - [3. アプリモジュールの設定](#3-アプリモジュールの設定)
    - [4. `settings.gradle`ファイルの作成](#4-settingsgradleファイルの作成)
  - [アプリの実装](#アプリの実装)
    - [1. AndroidManifest.xmlの作成](#1-androidmanifestxmlの作成)
    - [2. レイアウトファイルの作成](#2-レイアウトファイルの作成)
    - [3. 文字列リソースの作成](#3-文字列リソースの作成)
    - [4. Javaクラスの作成](#4-javaクラスの作成)
  - [アプリのビルドと実行](#アプリのビルドと実行)
    - [1. gradleタスクの実行](#1-gradleタスクの実行)
    - [2. エミュレータの設定（オプション）](#2-エミュレータの設定オプション)
    - [3. アプリのインストールと実行](#3-アプリのインストールと実行)
  - [トラブルシューティング](#トラブルシューティング)
    - [よくある問題と解決策](#よくある問題と解決策)
  - [テストの追加と実行](#テストの追加と実行)
    - [1. テスト用のディレクトリ構造を作成](#1-テスト用のディレクトリ構造を作成)
    - [2. 依存関係を追加](#2-依存関係を追加)
    - [3. 単体テストの作成](#3-単体テストの作成)
    - [4. インストルメンテーションテストの作成](#4-インストルメンテーションテストの作成)
    - [5. UIテスト（Espresso）の追加](#5-uiテストespressoの追加)
    - [6. テストを実行する](#6-テストを実行する)
      - [単体テストの実行](#単体テストの実行)
      - [インストルメンテーションテストの実行（エミュレータまたはデバイスが必要）](#インストルメンテーションテストの実行エミュレータまたはデバイスが必要)
    - [7. テスト結果の確認](#7-テスト結果の確認)
    - [8. テストカバレッジの設定（オプション）](#8-テストカバレッジの設定オプション)
  - [次のステップ](#次のステップ)
  - [参考リソース](#参考リソース)

## プロンプト

``` txt
VSCode + gradleでAndroidアプリのHelloWorldチュートリアル
```

``` txt
テストも実行できるようにしてください。
```

このチュートリアルでは、Visual Studio CodeとGradleを使用してAndroidの「Hello World」アプリを作成する方法を説明します。

## 前提条件のインストール

### 1. JDKのインストール
Javaアプリケーションを開発するには、JDK（Java Development Kit）が必要です。

```bash
# macOSの場合（Homebrew使用）
brew install openjdk@11

# Ubuntuの場合
sudo apt update
sudo apt install openjdk-11-jdk

# Windowsの場合
# AdoptOpenJDKなどのウェブサイトからダウンロードしてインストール
```

JDKがインストールされたことを確認：
```bash
java -version
javac -version
```

### 2. Android SDKのインストール

Android SDKを入手する最も簡単な方法は、Android Studioをインストールすることですが、コマンドラインツールだけをインストールすることも可能です：

1. [Android Studioのダウンロードページ](https://developer.android.com/studio)からコマンドラインツールをダウンロード
2. ダウンロードしたZIPファイルを展開
3. 環境変数を設定：

```bash
# bashの場合
echo 'export ANDROID_SDK_ROOT=/path/to/android-sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin:$ANDROID_SDK_ROOT/platform-tools' >> ~/.bashrc
source ~/.bashrc
```

必要なSDKコンポーネントをインストール：
```bash
sdkmanager "platforms;android-33" "build-tools;33.0.0" "platform-tools" "extras;android;m2repository"
```

### 3. VS Codeのインストール

[公式サイト](https://code.visualstudio.com/)からダウンロードしてインストール。

### 4. VS Code拡張機能のインストール

VS Codeで以下の拡張機能をインストール：
- Extension Pack for Java
- Gradle for Java
- Android for VS Code

### 5. Gradleのインストール

```bash
# macOSの場合
brew install gradle

# Ubuntuの場合
sudo apt install gradle

# Windowsの場合
# Chocolateyを使用：choco install gradle
# または公式サイトからダウンロードして環境変数PATHに追加
```

Gradleがインストールされていることを確認：
```bash
gradle -v
```

## プロジェクトの作成

### 1. 新しいAndroidプロジェクトの作成

1. ターミナルで作業ディレクトリに移動
2. 以下のコマンドでプロジェクトを作成：

```bash
mkdir HelloWorldApp
cd HelloWorldApp
gradle init --type java-application
```

### 2. Androidプロジェクト構造の設定

プロジェクトのルートに`build.gradle`ファイルを作成または編集：

```groovy
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:7.4.2'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
```

### 3. アプリモジュールの設定

`app`ディレクトリを作成し、その中に`build.gradle`ファイルを作成：

```bash
mkdir -p app/src/main/java/com/example/helloworld
mkdir -p app/src/main/res/layout
mkdir -p app/src/main/res/values
```

`app/build.gradle`ファイルを作成：

```groovy
plugins {
    id 'com.android.application'
}

android {
    compileSdkVersion 33
    defaultConfig {
        applicationId "com.example.helloworld"
        minSdkVersion 21
        targetSdkVersion 33
        versionCode 1
        versionName "1.0"
    }
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_11
        targetCompatibility JavaVersion.VERSION_11
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.8.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
}
```

### 4. `settings.gradle`ファイルの作成

プロジェクトのルートに`settings.gradle`ファイルを作成：

```groovy
pluginManagement {
    repositories {
        gradlePluginPortal()
        google()
        mavenCentral()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = 'HelloWorldApp'
include ':app'
```

## アプリの実装

### 1. AndroidManifest.xmlの作成

`app/src/main/`ディレクトリに`AndroidManifest.xml`ファイルを作成：

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.helloworld">

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.AppCompat.Light.DarkActionBar">
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

### 2. レイアウトファイルの作成

`app/src/main/res/layout/activity_main.xml`ファイルを作成：

```xml
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
        android:text="Hello World!"
        android:textSize="24sp"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

### 3. 文字列リソースの作成

`app/src/main/res/values/strings.xml`ファイルを作成：

```xml
<resources>
    <string name="app_name">Hello World</string>
</resources>
```

### 4. Javaクラスの作成

`app/src/main/java/com/example/helloworld/MainActivity.java`ファイルを作成：

```java
package com.example.helloworld;

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

## アプリのビルドと実行

### 1. gradleタスクの実行

プロジェクトのルートディレクトリで以下のコマンドを実行してアプリをビルド：

```bash
./gradlew assembleDebug
```

### 2. エミュレータの設定（オプション）

Android Virtual Device (AVD) Managerを使用してエミュレータを設定：

```bash
avdmanager create avd -n test_device -k "system-images;android-33;google_apis;x86_64"
```

### 3. アプリのインストールと実行

実機またはエミュレータでアプリを実行：

```bash
# エミュレータを起動
emulator -avd test_device

# 別のターミナルでアプリをインストール
./gradlew installDebug
```

または、ADBを使用して直接インストール：

```bash
adb install app/build/outputs/apk/debug/app-debug.apk
```

## トラブルシューティング

### よくある問題と解決策

1. **Gradleビルドエラー**
   - Gradleのバージョンの互換性を確認
   - `./gradlew clean`を実行してから再ビルド

2. **依存関係の問題**
   - インターネット接続を確認
   - `build.gradle`ファイルでリポジトリと依存関係が正しく設定されているか確認

3. **AndroidManifest.xmlのエラー**
   - 正しい権限と設定が含まれているか確認
   - アクティビティの宣言に`android:exported="true"`が含まれているか確認

4. **エミュレータの問題**
   - HAXMがインストールされていることを確認（Intel CPUの場合）
   - システムイメージが正しくインストールされているか確認

## テストの追加と実行

Androidアプリケーションには通常、単体テスト（Unit Tests）とインストルメンテーションテスト（Instrumentation Tests）の2種類のテストを実装します。

### 1. テスト用のディレクトリ構造を作成

```bash
# 単体テスト用ディレクトリ（JVMで実行可能）
mkdir -p app/src/test/java/com/example/helloworld

# インストルメンテーションテスト用ディレクトリ（デバイスかエミュレータが必要）
mkdir -p app/src/androidTest/java/com/example/helloworld
```

### 2. 依存関係を追加

`app/build.gradle`ファイルに以下のテスト依存関係を追加します：

```groovy
dependencies {
    // 既存の依存関係...
    
    // 単体テスト用
    testImplementation 'junit:junit:4.13.2'
    testImplementation 'org.mockito:mockito-core:4.0.0'
    
    // インストルメンテーションテスト用
    androidTestImplementation 'androidx.test:runner:1.5.2'
    androidTestImplementation 'androidx.test:rules:1.5.0'
    androidTestImplementation 'androidx.test.ext:junit:1.1.5'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.5.1'
}

android {
    // 既存の設定...
    
    testOptions {
        unitTests {
            includeAndroidResources = true
        }
    }
}
```

### 3. 単体テストの作成

`app/src/test/java/com/example/helloworld/ExampleUnitTest.java`ファイルを作成：

```java
package com.example.helloworld;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 * ローカル単体テストの例
 * JVMでのみ実行されます（Androidデバイス不要）
 */
public class ExampleUnitTest {
    @Test
    public void addition_isCorrect() {
        assertEquals(4, 2 + 2);
    }
    
    // 簡単なテスト例を追加
    @Test
    public void stringComparison() {
        String hello = "Hello World";
        assertNotNull(hello);
        assertTrue(hello.contains("World"));
    }
}
```

### 4. インストルメンテーションテストの作成

`app/src/androidTest/java/com/example/helloworld/ExampleInstrumentedTest.java`ファイルを作成：

```java
package com.example.helloworld;

import android.content.Context;
import androidx.test.platform.app.InstrumentationRegistry;
import androidx.test.ext.junit.runners.AndroidJUnit4;

import org.junit.Test;
import org.junit.runner.RunWith;
import static org.junit.Assert.*;

/**
 * インストルメンテーションテストの例
 * Androidデバイスまたはエミュレータで実行する必要があります
 */
@RunWith(AndroidJUnit4.class)
public class ExampleInstrumentedTest {
    @Test
    public void useAppContext() {
        // アプリコンテキストのテスト
        Context appContext = InstrumentationRegistry.getInstrumentation().getTargetContext();
        assertEquals("com.example.helloworld", appContext.getPackageName());
    }
}
```

### 5. UIテスト（Espresso）の追加

`app/src/androidTest/java/com/example/helloworld/MainActivityTest.java`ファイルを作成：

```java
package com.example.helloworld;

import androidx.test.ext.junit.rules.ActivityScenarioRule;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import androidx.test.filters.LargeTest;

import org.junit.Rule;
import org.junit.Test;
import org.junit.runner.RunWith;

import static androidx.test.espresso.Espresso.onView;
import static androidx.test.espresso.assertion.ViewAssertions.matches;
import static androidx.test.espresso.matcher.ViewMatchers.isDisplayed;
import static androidx.test.espresso.matcher.ViewMatchers.withText;

@RunWith(AndroidJUnit4.class)
@LargeTest
public class MainActivityTest {

    @Rule
    public ActivityScenarioRule<MainActivity> activityRule = 
        new ActivityScenarioRule<>(MainActivity.class);

    @Test
    public void testHelloWorldTextIsDisplayed() {
        // "Hello World!"というテキストが表示されていることを確認
        onView(withText("Hello World!"))
            .check(matches(isDisplayed()));
    }
}
```

### 6. テストを実行する

#### 単体テストの実行

```bash
# すべての単体テストを実行
./gradlew test

# 特定のテストクラスのみ実行
./gradlew testDebugUnitTest --tests "com.example.helloworld.ExampleUnitTest"
```

#### インストルメンテーションテストの実行（エミュレータまたはデバイスが必要）

```bash
# すべてのインストルメンテーションテストを実行
./gradlew connectedAndroidTest

# または
./gradlew cAT
```

### 7. テスト結果の確認

テスト結果は以下の場所に保存されます：

- 単体テスト: `app/build/reports/tests/testDebugUnitTest/index.html`
- インストルメンテーションテスト: `app/build/reports/androidTests/connected/index.html`

VS Codeでテスト結果を確認するには、HTMLファイルを開いてプレビューするか、拡張機能「Test Explorer UI」をインストールしてテスト結果を視覚的に確認できます。

### 8. テストカバレッジの設定（オプション）

テストカバレッジを測定するには、`app/build.gradle`に以下を追加します：

```groovy
android {
    // 既存の設定...
    
    buildTypes {
        debug {
            testCoverageEnabled true
        }
    }
}
```

カバレッジレポートを生成するには：

```bash
# 単体テストのカバレッジ
./gradlew testDebugUnitTestCoverage

# インストルメンテーションテストのカバレッジ
./gradlew createDebugCoverageReport
```

## 次のステップ

基本的な「Hello World」アプリとテストの作成が完了したら、以下のことを学ぶことをお勧めします：

1. ボタンやテキスト入力などの追加のUI要素
2. イベントハンドリング（ボタンクリックなど）
3. 複数のアクティビティとインテント
4. データの保存と取得
5. AndroidのライフサイクルイベントとAPI
6. さらに高度なテスト技術（モック、スタブなど）

## 参考リソース

- [Android Developer公式ドキュメント](https://developer.android.com/docs)
- [Gradle公式ドキュメント](https://gradle.org/guides/)
- [VS CodeのJava開発ガイド](https://code.visualstudio.com/docs/java/java-tutorial)

