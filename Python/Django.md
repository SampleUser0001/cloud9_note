# Django

- [Django](#django)
  - [前提](#前提)
  - [init](#init)
    - [参考](#参考)
  - [起動](#起動)
  - [アプリケーションの作成](#アプリケーションの作成)
    - [ビュー作成(仮)](#ビュー作成仮)
    - [URLパス設定](#urlパス設定)
    - [project/settings.py](#projectsettingspy)
  - [テンプレート作成](#テンプレート作成)
    - [app/views.py](#appviewspy)
      - [参考](#参考-1)
  - [ファイルアップロード](#ファイルアップロード)
    - [app/forms.py](#appformspy)
    - [project/urls.py](#projecturlspy)
    - [app/vies.py](#appviespy)
    - [app/controller.py](#appcontrollerpy)
    - [app/template/index.html](#apptemplateindexhtml)
    - [app/template/success.html](#apptemplatesuccesshtml)
    - [参考](#参考-2)
  - [bootstrap導入](#bootstrap導入)
    - [pip install](#pip-install)
    - [project/settings.py](#projectsettingspy-1)
    - [テンプレートファイル](#テンプレートファイル)
    - [参考](#参考-3)
  - [CSRF検証でエラーになった場合](#csrf検証でエラーになった場合)
    - [参考](#参考-4)

## 前提

このページでは下記で記載する。

- Djangoプロジェクト名 : project
- Djangoアプリケーション名：app

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
project=project
mkdir project

cd project

# venv作成
python -m venv django_venv

# venv起動
source django_venv/bin/activate

# djangoインストール
python -m pip install Django
python -m django --version

# プロジェクト作成
django-admin startproject project
```

``` bash
# 何かをpip install/uninstallしたら行う。
pip freeze > requirements.txt
```

### 参考

- [さぁ始めましょう:django ドキュメント](https://docs.project.com/ja/4.1/intro/)

## 起動

``` bash
cd project
source django_venv/bin/activate
pip install -r requirements.txt

cd project
python manage.py runserver
```

``` bash
# 外からアクセスできるようにする場合は下記。
python manage.py runserver 0.0.0.0:8000
```

## アプリケーションの作成

``` bash
python manage.py startapp app
```

### ビュー作成(仮)

``` python
# app/view.py 

from django.http import HttpResponse

def index(request):
    return HttpResponse('Hello World.')

```

### URLパス設定

``` bash
touch app/urls.py
```

``` python
# app/urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
]
```

``` python
# project/urls.py

# 追記
from django.urls import include, path

urlpatterns = [
    path('app/', include('app.urls')),
    path('admin/', admin.site.urls),
]

```

### project/settings.py

``` python
# 下記を追加
INSTALLED_APPS = [
    'アプリケーション名.apps.クラス名'
]
```

## テンプレート作成

``` bash
# app=
mkdir app/templates/app
# htmlfile=
touch app/templates/app/${htmlfile}
```

``` html
<!-- 任意の内容を書く。 -->
<!-- この項目では触れない。 -->
```

### app/views.py

``` python
from django.shortcuts import render

def index(request):
    return render(request, 'app/index.html')
```

#### 参考

- [はじめての Django アプリ作成、その 3:Django ドキュメント](https://docs.project.com/ja/4.1/intro/tutorial03/)

## ファイルアップロード

``` bash
touch project/app/forms.py
```

### app/forms.py

``` python
from django import forms

class UploadFileForm(forms.Form):
    title = forms.CharField(max_length=50)
    file = forms.FileField()
```

### project/urls.py

``` python
from django.contrib import admin
from django.urls import include, path
import fileupload.views as fileupload

urlpatterns = [ 
    path('fileupload/success/', fileupload.success),
    path('fileupload/', include('fileupload.urls')),    
    path('admin/', admin.site.urls),
]
```

### app/vies.py

``` python
from django.http import HttpResponseRedirect
from django.shortcuts import render
from .forms import UploadFileForm
from django.http import HttpResponse

# Imaginary function to handle an uploaded file.
from .controller import handle_uploaded_file

# import logging
# logger = logging.getLogger('development')

def success(request):
    return render(request, 'fileupload/success.html')

def index(request):
    if request.method == 'POST':
        # POSTの場合はUploadされたファイルを処理して、fileupload/successにリダイレクトする。
        form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid():
            file_obj = request.FILES['file']
            logger.info(file_obj.name)
            handle_uploaded_file(file_obj)
            return HttpResponseRedirect('/fileupload/success/')
    else:
        # POST以外の場合はUploadフォームを作成して、index.htmlを表示する。
        form = UploadFileForm()
    return render(request, 'fileupload/index.html', {'form': form})

```

### app/controller.py

``` python
def handle_uploaded_file(f):
    pass
    # print(f)
    # with open('some/file/name.txt', 'wb+') as destination:
    #     for chunk in f.chunks():
    #         destination.write(chunk)
```

### app/template/index.html

``` html
<h1>File upload</h1>

<form method="POST" enctype="multipart/form-data">
    <!-- ファイルの送信元を保証する -->
    <!-- バックスラッシュは不要。(Githubのビルドでエラーになるため追加。) -->
    {\% csrf_token \%}

    <!-- views.index内で生成されるUploadFileFormクラスのオブジェクトをレンダリングできるフォーマットに変換する。 -->
    <!-- バックスラッシュは不要。(Githubのビルドでエラーになるため追加。) -->
    \{\{ form.as_p \}\}

    <button type="submit">Upload</button>
</form>
```

### app/template/success.html

``` html
<p>Success!</p>
<a href="/fileupload/">Go to index.</a>
```

### 参考

- [ファイルのアップロード:django](https://docs.project.com/ja/4.1/topics/http/file-uploads/)
- [Django でファイルをアップロード:Qiita](https://qiita.com/ekzemplaro/items/07abd9a941bcd0eb5834)

## bootstrap導入

### pip install

``` bash
# venv起動済みであることを確認してから実行。
pip install django-bootstrap5
```

### project/settings.py

``` python
# 追加
INSTALLED_APPS = [
    'django_bootstrap5',
]
```

### テンプレートファイル

``` html
<!-- 1行目に記載 -->
<!-- バックスラッシュは不要。(Githubの都合で記載。) -->
\{\% load django_bootstrap5 \%\}

<head>
    \{\% bootstrap_css \%\}
    \{\% bootstrap_javascript \%\}
</head>
```

**デフォルトで適用できるbootstrap_formがあるので、調査して使うこと。**

### 参考

- [【Django】Bootstrap5の利用方法：django-bootstrap5:OFFICE54](https://office54.net/python/django/django-bootstrap5-css)

## CSRF検証でエラーになった場合

project/settings.py に下記を追記する。

``` python
CSRF_TRUSTED_ORIGINS = ['https://3a5caa305fbe48f8b96fbf040031a010.vfs.cloud9.ap-northeast-1.amazonaws.com']
```

### 参考

- [Djangoで特定のドメインで発生したエラーについて:book-reviews.blog](https://book-reviews.blog/specific-domain-errors-on-Django/)

