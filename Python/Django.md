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
  - [テンプレートの作成例(listの表示)](#テンプレートの作成例listの表示)
    - [テンプレート](#テンプレート)
    - [app/views.py](#appviewspy-1)
  - [staticファイル配置](#staticファイル配置)
  - [ファイルアップロード](#ファイルアップロード)
    - [app/forms.py](#appformspy)
    - [project/urls.py](#projecturlspy)
    - [app/vies.py](#appviespy)
    - [app/controller.py](#appcontrollerpy)
    - [app/template/index.html](#apptemplateindexhtml)
    - [app/template/success.html](#apptemplatesuccesshtml)
    - [参考](#参考-2)
  - [GetのURLの作成例](#getのurlの作成例)
    - [app/views.py](#appviewspy-2)
    - [app/urls.py](#appurlspy)
    - [参考](#参考-3)
  - [Modelを使う](#modelを使う)
    - [DB設定](#db設定)
      - [project/settings.py](#projectsettingspy-1)
    - [app/models.py](#appmodelspy)
    - [make migrations](#make-migrations)
    - [DBに登録する](#dbに登録する)
    - [DBに登録されているデータを取得する](#dbに登録されているデータを取得する)
    - [選択肢を登録/全部取得/選択/削除する](#選択肢を登録全部取得選択削除する)
      - [参考](#参考-4)
  - [404を送出する](#404を送出する)
  - [Django admin](#django-admin)
  - [AdminにModelを追加する](#adminにmodelを追加する)
    - [app/admin.py](#appadminpy)
  - [bootstrap導入](#bootstrap導入)
    - [pip install](#pip-install)
    - [project/settings.py](#projectsettingspy-2)
    - [テンプレートファイル](#テンプレートファイル)
    - [参考](#参考-5)
  - [CSRF検証でエラーになった場合](#csrf検証でエラーになった場合)
    - [参考](#参考-6)
  - [manage.py](#managepy)
    - [参考](#参考-7)

## 前提

このページでは下記で記載する。

- Djangoプロジェクト名 : project
- Djangoアプリケーション名：app

ビューの作成は、既存のものを使用したほうが良い。下記を参照。

- [Tutorial_Django:Github](https://github.com/SampleUser0001/Tutorial_Django)
- [Tutorial_Django_2:Github](https://github.com/SampleUser0001/Tutorial_Django_2)

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

``` bash
# プロジェクトとして、projectとproject配下に管理アプリとして、projectが作成される。
ls
django_venv  project  requirements.txt
(django_venv) ubuntuuser@ubuntuuser-B660M:~/environment/tmp_django $ ls project
manage.py  project
(django_venv) ubuntuuser@ubuntuuser-B660M:~/environment/tmp_django $ 

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
# app/views.py 

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
# プロジェクト管理用のファイルに、新しく作成したアプリを登録する。

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
# 作成したアプリの名前を追加する。
# ChatGPTの回答なので、間違っている可能性はあるが、必要に応じて、app.ファイル名.クラス名を記載すれば良い。
INSTALLED_APPS = [
    'app'
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

- [はじめての Django アプリ作成、その 3:Django ドキュメント](https://docs.project.com/ja/5.0/intro/tutorial03/)

## テンプレートの作成例(listの表示)

### テンプレート

``` html
<h1>Message List</h1>
{% if message_list %}
    <ul>
        {% for model in message_list %}
        <li>{{ model.message }}</li>
        {% endfor %}
    </ul>
{% else %}
<p>Message is not found.</p>
{% endif %}
<a href="add_message">Add Message</a>
```

### app/views.py

``` python
from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from .models import Message

def index(request):
    message_list = Message.get_message_list()
    template = loader.get_template('usermodel/index.html')
    context = {
        'message_list': message_list,
    }
    return HttpResponse(template.render(context, request))

def add_message(request):
    return render(request, 'usermodel/add_message.html')

```

または下記。

``` python
from django.shortcuts import render
from .models import Message

def index(request):
    message_list = Message.get_message_list()
    context = {
        'message_list': message_list,
    }
    return render(request, 'usemodel/index.html', context)

def add_message(request):
    return render(request, 'usemodel/add_message.html')

```

## staticファイル配置

cssなどの配置方法。  

- プロジェクト名
    - app
- css配置パス
    - `./project/app/static/app/css/app.css`


`./project/project/settings.py`

``` python
# settings.py

# 静的ファイルの基本パスを設定
STATIC_URL = '/static/'

# 静的ファイルを格納するディレクトリを指定
STATICFILES_DIRS = [
    BASE_DIR / 'app/static',  # ここをプロジェクトの構成に合わせて変更
]
```

テンプレートファイル


``` html
<!-- 例: Djangoテンプレート内でのCSSリンク -->
<!-- rawとendrawはJekyllのエスケープタグ。Djangoで使用する場合は記載不要。 -->
{% raw %}
{% load static %}
<link href="{% static 'app/css/app.css' %}" rel="stylesheet">
{% endraw %}
```


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

## GetのURLの作成例

### app/views.py

``` python
from django.http import HttpResponse


def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")

def detail(request, question_id):
    return HttpResponse("You're looking at question %s." % question_id)

def results(requests, question_id):
    response = "You're looking at the results of question %s."
    return HttpResponse(response % question_id)

def vote(request, question_id):
    return HttpResponse("You're voting on question %s." % question_id)
```

### app/urls.py

``` python
from django.urls import path

from .import views

urlpatterns = [
    path('', views.index, name='index'),
    path('<int:question_id>/', views.detail, name='detail'),
    path('<int:question_id/results/', views.results, name='results'),
    path('<int:question_id/vote/', views.vote, name='vote'),
]
```

### 参考

- [](https://docs.djangoproject.com/ja/4.1/intro/tutorial03/)

## Modelを使う

### DB設定

#### project/settings.py

``` python
# Database
# https://docs.djangoproject.com/en/4.1/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
```

- 使用するDBによって記載を変えること。
- コメントのURLを参照。

### app/models.py

``` python
from django.db import models

class Message(models.Model):
    message = models.CharField(max_length=256)
    pub_date = models.DateTimeField('date published')

    def __str__(self):
        '''Adminページに表示する文言を設定する'''
        return self.message
```

- [はじめての Django アプリ作成、その2:Django](https://docs.djangoproject.com/ja/4.1/intro/tutorial02/)
- [models](https://docs.djangoproject.com/ja/4.1/ref/models/instances/#django.db.models.Model)

### make migrations

``` bash
python manage.py makemigrations app
python manage.py migrate
```

### DBに登録する

``` python
from django.utils import timezone
from app.models import Message

# 登録したい値の設定
message = Message(message='hoge', pub_date=timezone.now())

# 登録
message.save()
```

### DBに登録されているデータを取得する

``` python
from app.models import Message

# 全部
Message.objects.all()

# 条件をつける
Message.objects.filter(id=1)
Message.objects.filter(message__startswith='ho')

current_year = django.utils.timezone.now().year
Message.objects.get(pub_date__year=current_year)

Message.objects.get(pk=1)
```

### 選択肢を登録/全部取得/選択/削除する

親子関係があり、子供側に選択肢をもたせて、カウントする。  
参考から引用。

``` python
import datetime

from django.db import models
from django.utils import timezone

# Create your models here.

class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')

    def __str__(self) -> str:
        return self.question_text

    def was_published_recently(self):
        return self.pub_date >= timezone.now() - datetime.timedelta(days=1)

class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)

    def __str__(self) -> str:
        return self.choice_text
```

``` python
from polls.models import Choice, Question

q = Question.objects.get(pk=1)

# 登録
q.choice_set.create(choice_text='Not much', votes=0)
q.choice_set.create(choice_text='The sky', votes=0)
c = q.choice_set.create(choice_text='Just hacking again', votes=0)

# 全部取得
q.choice_set.all()

# 順番を指定する
Question.objects.order_by('-pub_date')[:5]

# 件数取得
q.choice_set.count()

# 選択
c = q.choice_set.filter(choice_text='Just hacking again')

# 削除
c.delete()

```

#### 参考

- [はじめての Django アプリ作成、その2:Django](https://docs.djangoproject.com/ja/4.1/intro/tutorial02/)

## 404を送出する

``` python
from django.shortcuts import render, get_object_or_404

def detail(request, question_id):
    template_path = 'polls/detail.html'
    question = get_object_or_404(Question, pk=question_id)

    return render(request, template_path, {'question': question})
```


## Django admin

``` bash
python manage.py createsuperuser
# ユーザ名、メールアドレス、パスワードを入力する。
```

## AdminにModelを追加する

### app/admin.py

``` python
from django.contrib import admin

# Register your models here.

from .models import Message

admin.site.register(Message)
```

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

## manage.py

- flush
  - データベースからすべてのデータを削除し、同期化後のハンドラを再実行します。どのマイグレーションが適用されたかのテーブルはクリアされません。
- makemigrations
  - Modelを変更したときに実行する。
  - マイグレーションファイルを作成する。
- migrate
  - Modelを変更したときい実行する。
  - DBに反映する。

### 参考

- [django-admin と manage.py:django](https://docs.djangoproject.com/ja/4.1/ref/django-admin/)