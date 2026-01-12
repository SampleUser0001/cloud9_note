# HTML

- [HTML](#html)
  - [disableとreadonlyの違い](#disableとreadonlyの違い)
  - [formの基本](#formの基本)
  - [プルダウンに非表示の選択肢を作成する](#プルダウンに非表示の選択肢を作成する)

## disableとreadonlyの違い

- readonly
    - 読み込みできる
    - 送信される
- disable
    - 読み込みできない
    - 送信されない

## formの基本

``` html
<form action="/submit" method="post">
    <label>名前: <input type="text" name="username"></label><br>
    <label>メール: <input type="email" name="email"></label><br>
    <button type="submit">送信</button>

    <!-- こちらでも良い。こちらのほうが古く、軽量。 -->
    <input type="submit" value="送信">
</form>
```

## プルダウンに非表示の選択肢を作成する

- [index.html:Select_Hidden_Option](https://github.com/SampleUser0001/Select_Hidden_Option/blob/main/front/index.html)