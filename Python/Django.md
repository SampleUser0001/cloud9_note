# Django

- [Django](#django)
  - [CSRF検証でエラーになった場合](#csrf検証でエラーになった場合)
    - [参考](#参考)

## CSRF検証でエラーになった場合

```mysite/settings.py```に下記を追記する。

``` python
CSRF_TRUSTED_ORIGINS = ['https://3a5caa305fbe48f8b96fbf040031a010.vfs.cloud9.ap-northeast-1.amazonaws.com']
```

### 参考

- [Djangoで特定のドメインで発生したエラーについて:book-reviews.blog](https://book-reviews.blog/specific-domain-errors-on-Django/)

