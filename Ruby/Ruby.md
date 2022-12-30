# Ruby

- [Ruby](#ruby)
  - [チュートリアル](#チュートリアル)
  - [フォーマットの指定](#フォーマットの指定)
  - [\&\& の挙動](#-の挙動)
  - [unless](#unless)
  - [デフォルト引数](#デフォルト引数)
  - [1行メソッド](#1行メソッド)
  - [既存のライブラリを読み込む(require)](#既存のライブラリを読み込むrequire)
  - [自作のライブラリを読み込む(require\_relative)](#自作のライブラリを読み込むrequire_relative)

## チュートリアル

- [Tutorial_Ruby](https://sampleuser0001.github.io/Tutorial_Ruby/)
  - [リポジトリ](https://github.com/SampleUser0001/Tutorial_Ruby)

## フォーマットの指定

``` rb
puts sprintf('%0.3f', 1.2)
```

## && の挙動

``` rb
# true/falseが決まった時点で式としては完了扱いになる。
puts 1&&2
puts 1&&2&&3
```

``` bash
$ ruby true_false.rb 
2
3
```

## unless

not equalsを扱う。

``` ruby
b = true

if b
    puts 'hoge'
end

unless b
    # こちらは出力されない。
    puts 'piyo'
end
```

``` txt
hoge
```

## デフォルト引数

第2引数にだけ値を渡すことはできない？

``` ruby
def print(word = 'hoge', ignore = 'ignore')
    puts word
    puts ignore
    puts 
end

print
print('aaa')
print(ignore='piyo')
print(word=word, ignore='piyo')
```

``` txt
hoge
ignore

aaa
ignore

piyo
ignore


piyo

```

## 1行メソッド

「エンドレスメソッド」と呼ばれる。  
3.0で追加された構文。

``` ruby
def hoge = return 'hogehoge'
def piyo = 'piyopiyo'

# これはsyntax error。メソッド名と「=」の間に半角スペースが必要
# def fuga= 'fuga'

def foo(a=1) = a*a

puts hoge
puts piyo
puts foo(5)
```

``` txt
hogehoge
piyopiyo
25
```

## 既存のライブラリを読み込む(require)

``` ruby
require 'date'

puts Date.today
```

``` txt
2022-12-30
```

## 自作のライブラリを読み込む(require_relative)

model.rb

``` ruby
class DataModel
    attr_reader :data

    def initialize(data = 'default')
        @data = data
    end
end
```

app.rb

``` ruby
require_relative 'model'

model = DataModel.new('value')
puts model.data
```

``` txt
value
```