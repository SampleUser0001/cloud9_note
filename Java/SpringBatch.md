# Spring Batch

- [Spring Batch](#spring-batch)
  - [概要](#概要)
  - [参考](#参考)

## 概要

- JobLaunchar
    - ジョブを呼び出す
- Job
    - ジョブ本体
    - 1 Job / 1 バッチ
    - N Step / 1 Job
- JobParameter
    - Job実行時のパラメータ
- Step
    - バッチの最小単位
    - Chunkモデル
        - 読み込み(ItemReader)、加工(ItemProcessor)、書き込み(ItemWriter)で構成される。これらに分割できない場合は実行できない。
    - Taskletモデル
        - 任意の処理を書く
- JobRepository
    - ジョブの実行状況や実行結果を保持する。

## 参考

- [Overview](https://docs.spring.io/spring-batch/reference/)
    - 公式
- [まずは実践、Spring Boot Batchの動かし方 : Qiita](https://qiita.com/kawakawaryuryu/items/4b3f5cc7574b7bd6b625)