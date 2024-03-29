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
