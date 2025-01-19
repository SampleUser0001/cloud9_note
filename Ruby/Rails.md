# Ruby on Rails

- [Ruby on Rails](#ruby-on-rails)
  - [install](#install)
  - [init](#init)
    - [sqliteでエラーになった場合](#sqliteでエラーになった場合)
  - [起動](#起動)
    - [任意のIPアドレスから接続する](#任意のipアドレスから接続する)
  - [参考](#参考)
  - [コントローラーの生成](#コントローラーの生成)
    - [実行結果](#実行結果)
    - [コントローラー](#コントローラー)
    - [ビューテンプレート](#ビューテンプレート)
    - [ルーター](#ルーター)
  - [アプリケーションの作成(Scaffold)](#アプリケーションの作成scaffold)
    - [モデル](#モデル)
    - [追加されるルート](#追加されるルート)
    - [マイグレーション](#マイグレーション)
  - [リンクの貼り方](#リンクの貼り方)
  - [erbファイルの編集例](#erbファイルの編集例)
  - [部分テンプレート](#部分テンプレート)
    - [呼ぶ側](#呼ぶ側)
    - [呼ばれる側](#呼ばれる側)
  - [Active Recode](#active-recode)
    - [Modelの作成(generate model)](#modelの作成generate-model)
    - [DB定義](#db定義)
  - [マイグレーション概要](#マイグレーション概要)
  - [シード(seed)](#シードseed)
  - [バリデーション](#バリデーション)
    - [実装例](#実装例)
  - [フォームオブジェクト](#フォームオブジェクト)
    - [実装例](#実装例-1)
  - [railsコマンド](#railsコマンド)
    - [パス一覧を取得する](#パス一覧を取得する)
    - [Modelが持っている変数を表示する](#modelが持っている変数を表示する)

## install

``` bash
gem install rails
```

## init

``` bash
# .gitファイルが作成されるので、リモートリポジトリの生成は後でやる。
rails new ${プロジェクト名}
```

### sqliteでエラーになった場合

エラーメッセージに出ているが・・・

``` bash
sudo apt-get install libsqlite3-dev
```

## 起動

``` bash
rails s
```

### 任意のIPアドレスから接続する

``` bash
rails s -b 0.0.0.0
```

## 参考

- [Ruby on Rails](https://rubyonrails.org/)
  - 公式

## コントローラーの生成

``` bash
rails g controller greetings index
```

- g : generator
- index : メソッド名。複数指定できる。

### 実行結果

``` txt
      create  app/controllers/greetings_controller.rb
       route  get 'greetings/index'
      invoke  erb
      create    app/views/greetings
      create    app/views/greetings/index.html.erb
      invoke  test_unit
      create    test/controllers/greetings_controller_test.rb
      invoke  helper
      create    app/helpers/greetings_helper.rb
      invoke    test_unit
```

### コントローラー

`app/controllers/greetings_controller.rb`

``` ruby
class GreetingsController < ApplicationController
  def index
  end
end
```

### ビューテンプレート

`app/views/greetings/index.html.erb`

``` ruby
<h1>Greetings#index</h1>
<p>Find me in app/views/greetings/index.html.erb</p>
```

### ルーター

`config/routes.rb`

``` ruby
Rails.application.routes.draw do
  get 'greetings/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
```

## アプリケーションの作成(Scaffold)

コントローラだけではなく、ModelやDB定義もまとめて生成してくれる。

``` bash
rails g scaffold book title:string description:text
```

- book : アプリケーション名
- Model定義
    - title:string
    - description:text

### モデル

`app/models/book.rb`

``` ruby
class Book < ApplicationRecord
end
```

### 追加されるルート

``` txt
       books GET    /books(.:format)             books#index
             POST   /books(.:format)             books#create
    new_book GET    /books/new(.:format)         books#new
   edit_book GET    /books/:id/edit(.:format)    books#edit
        book GET    /books/:id(.:format)         books#show
             PATCH  /books/:id(.:format)         books#update
             PUT    /books/:id(.:format)         books#update
             DELETE /books/:id(.:format)         books#destroy
```

### マイグレーション

DB作成を行う。  
`db`ディレクトリ配下のrbが実行される。

``` bash
ruby db:migrate
```

## リンクの貼り方

``` html
<%= link_to 'Show', book %>
```

`'Show'`が表示文字列、`book`がURL。

## erbファイルの編集例

``` html
{% raw %}

<p style="color: green"><%= notice %></p>

<h1>Books</h1>

<table>
  <thead>
    <tr>
      <th>Title</th>
      <th>Description</th>
      <th calspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @books.each do |book| %>
    <tr>
      <td><%= book.title %></td>
      <td><%= book.description %></td>
      <td><%= link_to 'Show', book %></td>
      <td><%= link_to 'Edit', edit_book_path(book) %></td>
      <td><%= link_to 'Destroy', book, method: :destroy, data: {confirm: 'Are you sure?'} %></td>
    </tr>
    <% end %>
  </tbody>
</table>
</div>
<p>
<%= link_to "New book", new_book_path %>
</p>

{% endraw %}
```

## 部分テンプレート

### 呼ぶ側

``` txt
{% raw %}
<p style="color: green"><%= notice %></p>

<h1>Books</h1>

<table>
  <thead>
    <tr>
      <th>Title</th>
      <th>Description</th>
      <th calspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <!-- この1行だけで呼べる。@books.eachは配列 -->
    <%= render partial: "item", collection: @books.each , as: :book %>
  </tbody>
</table>
</div>
<p>
<%= link_to "New book", new_book_path %>
</p>
{% endraw %}
```

### 呼ばれる側

`app/views/books/_item.html.erb`  
ファイル名に`_`が必要。

``` html
{% raw %}
<tr>
  <td><%= book.title %></td>
  <td><%= book.description %></td>
  <td><%= link_to 'Show', book %></td>
  <td><%= link_to 'Edit', edit_book_path(book) %></td>
  <td><%= link_to 'Destroy', book, method: :destroy, data: {confirm: 'Are you sure?'} %></td>
</tr>
{% endraw %}
```

## Active Recode

RailsのMVCモデルの「M」。  
ORMの機能を持つ。  
[アプリケーションの作成(Scaffold)](#アプリケーションの作成scaffold)の際にも作成される。

``` mermaid
classDiagram

    class Book

    class ApplicationRecord

    class ActiveRecord 
    class Base 
        ActiveRecord *-- Base : Contains
    
    ApplicationRecord --|> Base
    Book --|> ApplicationRecord
```

### Modelの作成(generate model)

``` bash
rails g model ${Model} ${変数名}:${型名} ...
```

rbファイルだけが生成される。DB定義の更新には[マイグレーション](#マイグレーション)が必要。

### DB定義

`db.schema.rb`に作成される。

## マイグレーション概要

`db/migrate`配下のファイルを実行する。  
主なコマンドは`rails db:migreate`だが、`rails db:${その他のコマンド}`で色々できる。

## シード(seed)

予めDBに登録しておきたいマスタなどのデータ。  
`db/seeds.rb`に記載する。

## バリデーション

Modelに追加する。

### 実装例

`app/models/${モデル名}.rb`

``` ruby
class Book < ApplicationRecord
    # titleが空の場合、エラーとする。
    validates :title, presence: true
    # titleが重複している場合、エラーとする。
    validates :title, uniqueness: true
    # titleが空かつdescriptionが入力されている場合はエラーとする。
    validates :description, absence: true , unless: :title?
    # descriptionが100文字以上の場合、エラーとする。
    validates :description, length: { maximum: 100 }
end
```

## フォームオブジェクト

バリデーションはModel（DBの登録に使用するクラス、ApplicationRecordを継承している）に記載する。  
特定のモデルに限定しないか、データベースの登録と関係ないチェックはフォームオブジェクトを使用する。

### 実装例

``` bash
# ファイルは一般的にapp/forms配下に配置
mkdir app/forms
touch app/forms/acceptance.rb
```

`app/forms/acceptance.rb`

``` ruby 
# いずれ書く
```

## railsコマンド

### パス一覧を取得する

``` bash
rails routes
```

### Modelが持っている変数を表示する

railsコンソールを使用する。

``` bash
rails console
```

``` ruby
# 名前だけほしい
Book.column_names
```

``` ruby
# 型もほしい
${Model名}.columns.each do |column|
    puts "#{column.name}: #{column.type}"
end
```