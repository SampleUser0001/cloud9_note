# Androidで同じ電話番号のはずなのに片方しか取得できない

- [Androidで同じ電話番号のはずなのに片方しか取得できない](#androidで同じ電話番号のはずなのに片方しか取得できない)
  - [回答](#回答)

## 回答

Androidの電話番号検索（たとえば

```java
Uri lookupUri = Uri.withAppendedPath(
    ContactsContract.PhoneLookup.CONTENT_FILTER_URI,
    Uri.encode(phoneNumber)
);
Cursor c = getContentResolver().query(lookupUri, …);
```

を使った場合）の内部挙動は、以下のようになっています。

1. **入力番号がE.164形式（「+81…」）か否かで検索対象カラムが変わる**

   * `+818012345678` のように「+（国番号付き）」と認識される番号を渡すと、実装上は **`normalized_number`** カラムだけを完全一致検索します。
   * 一方、先頭が `0` の「08012345678」のような国内形式を渡すと、`normalized_number` カラムへの一致検索に加え、末尾数桁（デフォルト7桁）でのサフィックス一致検索（`LIKE '%…'`）も行います。
     このロジックは ContactsProvider のソース中 `appendPhoneLookupSelection` メソッドで定義されています([Android Gooblesource][1])。

2. **そのため、異なるフォーマットで保存された番号はお互いにヒットしない**

   * **「08012345678」で検索** → 生番号（numberカラム）／サフィックス一致 or normalized\_number（一致）で、080登録のレコードにマッチ（+81登録のレコードはサフィックス一致しても、実装上 raw 検索はスキップされる場合あり）
   * **「+818012345678」で検索** → normalized\_number カラムのみを検索し、+81登録のレコードにマッチ（080登録のレコードは raw number にしか保存されておらず normalized\_number が空または別扱いになる場合あり）
     この動作はバグとも言われており、PhoneLookup フィルタが入力の “正規化済み判定” によって検索対象を切り替えてしまうためです([Stack Overflow][2])。

---

**まとめ**

* Android標準の PhoneLookup フィルタは、入力番号を自動で両方のフォーマットに揃えて比較するわけではなく、あくまで「入力がE.164風か国内フォーマットか」で検索範囲を変える仕様になっています。
* その結果、同一電話番号にもかかわらず「080…形式で検索すれば080登録のみ」「+81…形式で検索すれば+81登録のみ」が取得され、もう一方は取得できない、という現象が起きます。

[1]: https://android.googlesource.com/platform/packages/providers/ContactsProvider/%2B/master/src/com/android/providers/contacts/ContactsDatabaseHelper.java?utm_source=chatgpt.com "src/com/android/providers/contacts/ContactsDatabaseHelper.java"
[2]: https://stackoverflow.com/questions/21967727/phonelookup-content-filter-uri-returns-twice-the-same-contact?utm_source=chatgpt.com "PhoneLookup.CONTENT_FILTER_URI returns twice the same contact"
