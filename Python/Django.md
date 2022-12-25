# Django

- [Django](#django)
  - [init](#init)
    - [参考](#参考)
  - [起動](#起動)
  - [アプリケーションの作成](#アプリケーションの作成)
    - [ビュー作成(仮)](#ビュー作成仮)
    - [URLパス設定](#urlパス設定)
  - [CSRF検証でエラーになった場合](#csrf検証でエラーになった場合)
    - [参考](#参考-1)

## init

Pythonバージョンとの整合性が存在する。「とりあえず最新」とかやると失敗する。  
ここでは下記で導入する。

- Python 3.8.14
- sqlite 3.39.4
- Django 4.1.4

``` bash
# バージョン確認
python --version
sqlite3 --version

# ディレクトリ作成
django_project_name=django_project
mkdir ${django_project_name}

cd ${django_project_name}

# venv作成
python -m venv django_venv

# venv起動
source django_venv/bin/activate

# djangoインストール
python -m pip install Django
python -m django --version

# プロジェクト作成
django-admin startproject ${django_project_name}
```

``` bash
# 何かをpip installしたら行う。
pip freeze > requirements.txt
```

### 参考

- [さぁ始めましょう:django ドキュメント](https://docs.djangoproject.com/ja/4.1/intro/)

## 起動

``` bash
cd ${django_project_name}
source django_venv/bin/activate
pip install -r requirements.txt

python manage.py runserver
```

``` bash
# 外からアクセスできるようにする場合は下記。
python manage.py runserver 0.0.0.0:8000
```

## アプリケーションの作成

``` bash
python manage.py startapp ${app_name}
```

### ビュー作成(仮)

``` python
# ${app_name}/view.py 

from django.http import HttpResponse

def index(request):
    return HttpResponse('Hello World.")

```

### URLパス設定

``` python
# ${app_name}/urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
]
```

``` python
# django_project/urls.py

# 追記
from django.urls import include, path

urlpatterns = [
    path('app_name/', include('app_name.urls')),
    path('admin/', admin.site.urls),
]

```

## CSRF検証でエラーになった場合

mysite/settings.py に下記を追記する。

``` python
CSRF_TRUSTED_ORIGINS = ['https://3a5caa305fbe48f8b96fbf040031a010.vfs.cloud9.ap-northeast-1.amazonaws.com']
```

### 参考

- [Djangoで特定のドメインで発生したエラーについて:book-reviews.blog](https://book-reviews.blog/specific-domain-errors-on-Django/)

