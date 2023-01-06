# Ruby

- [Ruby](#ruby)
  - [チュートリアル](#チュートリアル)
  - [配列](#配列)
    - [存在しない添字](#存在しない添字)
    - [値の追加](#値の追加)
    - [値を末尾に追加](#値を末尾に追加)
    - [配列から値を削除](#配列から値を削除)
  - [フォーマットの指定](#フォーマットの指定)
  - [\&\& の挙動](#-の挙動)
  - [unless](#unless)
  - [デフォルト引数](#デフォルト引数)
  - [1行メソッド](#1行メソッド)
  - [既存のライブラリを読み込む(require)](#既存のライブラリを読み込むrequire)
  - [自作のライブラリを読み込む(require\_relative)](#自作のライブラリを読み込むrequire_relative)
  - [自動テスト(Minitest)](#自動テストminitest)

## チュートリアル

- [Tutorial_Ruby](https://sampleuser0001.github.io/Tutorial_Ruby/)
  - [リポジトリ](https://github.com/SampleUser0001/Tutorial_Ruby)
- [Professional_Ruby](https://github.com/SampleUser0001/Professional_Ruby)

## 配列

### 存在しない添字

``` ruby
a = [1, 2, 3]
# 下記はnil（エラーにならない。）
puts a[100]
```

### 値の追加

``` ruby
a = [1, 2, 3]

a[4] = 100

puts a
```

``` txt
1
2
3

100
```

### 値を末尾に追加

``` ruby
a = [1, 2, 3]

a << 4

puts a
```

``` txt
1
2
3
4
```

### 配列から値を削除

``` ruby
a = [1, 2, 3]
a.delete_at(1)

printf("a : %s\n", a)
printf("a.length : %d\n", a.length)
```

``` txt
a : [1, 3]
a.length : 2
```

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

## 自動テスト(Minitest)

```
.
├── README.md
├── app.rb
├── lib
│   └── fizz_buzz.rb
└── test
    └── fizz_buzz_test.rb
```

``` ruby
def fizz_buzz(size) 
    for i in 1..size do
        puts fizz_buzz_value(i)
    end
end

def fizz_buzz_value(i)
    if i % 15 == 0 
        'Fizz Buzz'
    elsif i % 5 == 0
        'Buzz'
    elsif i % 3 == 0
        'Fizz'
    else
        i.to_s
    end
end

```

``` ruby
require 'minitest/autorun'
require_relative '../lib/fizz_buzz'

class FizzBuzzTest < Minitest::Test
    def test_fizz_buzz_value
        assert_equal '1' , fizz_buzz_value(1)
        assert_equal '2' , fizz_buzz_value(2)
        assert_equal 'Fizz' , fizz_buzz_value(3)
        assert_equal '4' , fizz_buzz_value(4)
        assert_equal 'Buzz' , fizz_buzz_value(5)
        assert_equal 'Fizz Buzz' , fizz_buzz_value(15)
        
    end
end
```