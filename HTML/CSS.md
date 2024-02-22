# CSS

- [CSS](#css)
  - [タグ全体にフレームワークのクラスを設定する](#タグ全体にフレームワークのクラスを設定する)

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
