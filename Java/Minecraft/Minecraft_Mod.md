# Minecraft Mod

- [Minecraft Mod](#minecraft-mod)
  - [環境構築](#環境構築)
    - [参考](#参考)
  - [説明文の変更](#説明文の変更)
  - [ローカルで動作確認する](#ローカルで動作確認する)
  - [ビルド](#ビルド)

## 環境構築

1. [forgeダウンロードページ](https://files.minecraftforge.net/net/minecraftforge/forge/)から`mdk.zip`をダウンロードする
    1. Download Recommended - Mdkをクリック。
    2. 右上の`SKIP`をクリック。
2. `mdk.zip`を任意のディレクトリにコピー -> 解凍。
3. mdkディレクトリを任意のディレクトリ名に修正する。（以降、プロジェクトホームディレクトリとして扱う。）
4. `cd ${MDK_PROJECT_HOME}`
5. `./gradlew genVSCodeRuns`
6. `./build.gradle`を編集。
    - `version`
    - `group`
    - `base.archivesName`
7. `./gradlew eclipse`

### 参考

- [Minecraft Forge : 公式ドキュメント](https://docs.minecraftforge.net/en/1.20.x/gettingstarted/)

## 説明文の変更

`./gradle.properties`の`mod_xxx`を修正する。

## ローカルで動作確認する

``` bash
./gradlew runClient
```

## ビルド

``` bash
./gradlew build .

# build/libs/[base.archivesName]-[version].jarが生成される。
```
