# CSS

- [CSS](#css)
  - [基本](#基本)
    - [idで指定する](#idで指定する)
    - [classで指定する](#classで指定する)
    - [タグで指定する](#タグで指定する)
  - [タグ全体にフレームワークのクラスを設定する](#タグ全体にフレームワークのクラスを設定する)

## 基本

### idで指定する

``` html
<table id="headertable">
    <td>hoge</td>
    <td>piyo</td>
    <td>fuga</td>
</table>
```

``` css
#headertable td {
    width: 16.666%
}
```

### classで指定する

``` html
<table class="headertable">
    <td>hoge</td>
    <td>piyo</td>
    <td>fuga</td>
</table>
```

``` css
.headertable td {
    width: 16.666%
}
```

### タグで指定する

``` html
<table>
    <td>hoge</td>
    <td>piyo</td>
    <td>fuga</td>
</table>
```

``` css
td {
    width: 16.666%
}
```


## タグ全体にフレームワークのクラスを設定する

`@apply`を使用する。
``` css
div {
  @apply container mx-auto mt-10;
}

h1 {
  @apply mb-4 text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl;
}
```
