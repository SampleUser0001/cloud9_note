# Python

- [Python](#python)
  - [依存モジュールの一覧化](#依存モジュールの一覧化)
    - [取得](#取得)
    - [導入](#導入)

## 依存モジュールの一覧化

### 取得

ファイル名は何でもいいが、requirements.txtにするのが通例。

``` sh
pip freeze > requirements.txt
```

### 導入

``` sh
pip install -r requirements.txt
```