# phpDocumentor

PHP Docドキュメントを生成できる。

## インストール

Laravelの場合最初から使用可能？(未確認)

``` sh
mkdir dev
cd dev
# 依存関係が変わるかもしれんが。
composer require --with-all-dependencies --dev phpdocumentor/phpdocumentor
```

## 実行

``` sh
phpdoc run -d ${取得対象} -t ${ドキュメント出力先} --template=clean
```

### サンプル

- [Practice_Laravel-document-index](https://sampleuser0001.github.io/Practice_Laravel/practice-laravel/document/index.html)

## 参考

- [phpDocumentorでドキュメント自動生成してみた:Wedding Park CREATORS](https://engineers.weddingpark.co.jp/phpdocumentor-document-automatic-generation/)
  [PHP Documentorを使う:Qiita](https://qiita.com/zaburo/items/ebd0b0d55f8abf41f001)