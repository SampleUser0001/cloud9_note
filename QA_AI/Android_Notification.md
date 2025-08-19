# Androidの通知の実装

- [Androidの通知の実装](#androidの通知の実装)
  - [質問](#質問)
  - [回答](#回答)
    - [仕組み・ポイント](#仕組みポイント)
    - [複数種類の通知を区別したい場合](#複数種類の通知を区別したい場合)
    - [Manifest での親 Activity 設定（任意）](#manifest-での親-activity-設定任意)


## 質問

``` txt
Androidで通知タップ時に表示するActivityを指定したいのですがどう書いたら良い？
```

## 回答

以下のように **Intent → PendingIntent → NotificationCompat.Builder#setContentIntent()** の順で組み立てれば、通知タップ時に起動する Activity を自由に指定できます。
（例では `ResultActivity` を開く想定。Java / AndroidX 依存）

```java
private void showSampleNotification(Context context) {
    // 1) 起動させたい Activity へのインテント
    Intent intent = new Intent(context, ResultActivity.class)
            // 既存タスクをクリアして新規タスクを作る場合
            .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);

    // 2) 戻るボタンで適切に戻れるバックスタックを構築
    PendingIntent pendingIntent = TaskStackBuilder.create(context)
            .addNextIntentWithParentStack(intent)            // 親階層 (AndroidManifest.xml の <meta-data android:name="android.support.PARENT_ACTIVITY" …>) を自動生成
            .getPendingIntent(
                    0,
                    PendingIntent.FLAG_UPDATE_CURRENT       // 同一 requestCode の PendingIntent があれば差し替え
                    | PendingIntent.FLAG_IMMUTABLE          // API 23+ では必須推奨
            );

    // 3) 通知を組み立て
    Notification notification = new NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_stat_notify)
            .setContentTitle("処理が完了しました")
            .setContentText("タップして結果を表示")
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)                            // タップで通知を消す
            .setContentIntent(pendingIntent)                // ← ここがポイント
            .build();

    // 4) 表示
    NotificationManagerCompat.from(context).notify(NOTI_ID_RESULT, notification);
}
```

### 仕組み・ポイント

| 手順                               | 役割                      | 補足                                                                                                        |
| -------------------------------- | ----------------------- | --------------------------------------------------------------------------------------------------------- |
| ① **Intent**                     | 起動先 Activity のクラスを指定    | `setFlags()` でタスクの挙動を制御。既存インスタンスを再利用したいときは `Intent.FLAG_ACTIVITY_SINGLE_TOP` 等に変更可                        |
| ② **PendingIntent**              | 通知経由で OS に起動を委ねる「実行予約」  | Android 12(API 31) 以降は `FLAG_IMMUTABLE` / `FLAG_MUTABLE` の指定が必須。バックスタックを自動生成したい場合は `TaskStackBuilder` が安全 |
| ③ **Builder#setContentIntent()** | 通知と PendingIntent をひも付け | 併せて `setAutoCancel(true)` を入れるとタップ時に通知が消える                                                                |
| ④ **notify()**                   | 通知表示                    | `CHANNEL_ID` は事前に `NotificationChannel` を作成しておく                                                           |

### 複数種類の通知を区別したい場合

* `notify(UNIQUE_ID, notification)` の **ID** を用途ごとに変える
* `PendingIntent.getActivity(context, /*requestCode*/ UNIQUE_CODE, …)` の `requestCode` も通知ごとに変える
  → 同一 `requestCode` だと `FLAG_UPDATE_CURRENT` で置き換わるので注意

### Manifest での親 Activity 設定（任意）

バックキーで期待どおりに戻るには `<activity android:name=".ResultActivity">` に

```xml
<meta-data
    android:name="android.support.PARENT_ACTIVITY"
    android:value=".MainActivity"/>
```

を付与するか、`addNextIntent(intent)` だけで済む場合は省略可能です。

これで通知をタップしたときに **ResultActivity** が起動し、履歴キーでも自然に戻れる挙動が実現できます。
