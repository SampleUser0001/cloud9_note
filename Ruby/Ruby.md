# Ruby

- [Ruby](#ruby)
  - [チュートリアル](#チュートリアル)
  - [配列](#配列)
    - [存在しない添字](#存在しない添字)
    - [値の追加](#値の追加)
    - [値を末尾に追加](#値を末尾に追加)
    - [配列から値を削除](#配列から値を削除)
    - [多重代入](#多重代入)
    - [商と余りを配列で取得する](#商と余りを配列で取得する)
  - [繰り返し](#繰り返し)
    - [基本(each)](#基本each)
    - [新しい配列を生成する(map/collect)](#新しい配列を生成するmapcollect)
    - [条件を満たす要素を取得する(select/find\_all)](#条件を満たす要素を取得するselectfind_all)
    - [条件を満たさない要素を取得する(reject)](#条件を満たさない要素を取得するreject)
    - [条件を満たす要素のうち、最初に見つかった要素を返す(find/detect)](#条件を満たす要素のうち最初に見つかった要素を返すfinddetect)
    - [合計値を取得する(sum)](#合計値を取得するsum)
    - [文字列を連結する(join)](#文字列を連結するjoin)
    - [条件を満たす要素を削除する(delete\_if)](#条件を満たす要素を削除するdelete_if)
      - [do-endを使わないループ](#do-endを使わないループ)
    - [\&とシンボルを使う](#とシンボルを使う)
  - [Range](#range)
    - [部分配列の取得](#部分配列の取得)
    - [配列の生成](#配列の生成)
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

### 多重代入

``` ruby
a, b = [1, 2]
printf("a : %d\n", a)
printf("b : %d\n", b)

p '----'

c, d = [1]
printf("c : %d\n", c)
printf("d : %s\n", d) # nil

p '----'

e, f = [100, 200, 300]
printf("e : %d\n", e)
printf("f : %d\n", f)

```

``` txt
a : 1
b : 2
"----"
c : 1
d : 
"----"
e : 100
f : 200
```

### 商と余りを配列で取得する

``` ruby
div_mod = 14.divmod(3)
printf("商 : %d\n", div_mod[0])
printf("余り : %d\n", div_mod[1])
```

``` txt
商 : 4
余り : 2
```

## 繰り返し

### 基本(each)

``` ruby
numbers = [1, 2, 3, 4]
sum = 0

numbers.each do |n|
    sum += n
end

puts sum
```

``` txt
10
```

### 新しい配列を生成する(map/collect)

``` ruby
numbers = [1, 2, 3, 4, 5]
new_numbers = numbers.map{ |n| n * 10}

print(new_numbers , "\n")
```

``` txt
[10, 20, 30, 40, 50]
```

### 条件を満たす要素を取得する(select/find_all)

```ruby
numbers = [1, 2, 3, 4, 5]
new_numbers = numbers.select{ |n| n.even? }

print(new_numbers , "\n")
```

``` txt
[2, 4]
```

### 条件を満たさない要素を取得する(reject)

``` ruby
numbers = [1, 2, 3, 4, 5]
new_numbers = numbers.reject{ |n| n.even? }

print(new_numbers , "\n")
```

``` txt
[1, 3, 5]
```

### 条件を満たす要素のうち、最初に見つかった要素を返す(find/detect)

``` ruby
numbers = [1, 2, 3, 4, 5]
p numbers.find{ |n| n.even? }
```

``` txt
2
```

### 合計値を取得する(sum)

``` ruby
numbers = [1, 2, 3, 4, 5]
p numbers.sum
p numbers.sum{ |n| n * 2 }
p numbers.sum(100)

chars = ['hoge', 'piyo', 'fuga']
p chars.sum(",")
```

``` txt
15
30
115
",hogepiyofuga"
```

### 文字列を連結する(join)

``` ruby
chars = ['hoge', 'piyo', 'fuga']
p chars.join(',')
```

``` txt
"hoge7,piyo,fuga"
```

### 条件を満たす要素を削除する(delete_if)

``` ruby
a = [1, 2, 3, 1, 2, 3]

a.delete_if do |n|
    # 奇数を削除
    n.odd?
end

print a , "\n"
```

``` txt
[2, 2]
```

#### do-endを使わないループ

``` ruby
numbers = [1, 2, 3, 4]
sum = 0
numbers.each { |n| sum += n }
p sum
```

``` txt
10
```

### &とシンボルを使う

``` ruby
languages = ['ruby', 'java', 'python']
print(languages.map{ |lang| lang.upcase } , "\n")
print(languages.map( &:upcase ) , "\n")
```

``` txt
["RUBY", "JAVA", "PYTHON"]
["RUBY", "JAVA", "PYTHON"]
```

## Range

2種類ある。

``` ruby
def p_range(value)
    range_double = 1..5
    range_triple = 1...5
    printf("%s.include?(%1.1f) : %5s , %s.include?(%1.1f) : %5s\n",
        range_double, value, range_double.include?(value) ,
        range_triple, value, range_triple.include?(value))
end

p_range(0)
p_range(1)
p_range(4.9)
p_range(5)
p_range(6)
```

``` txt
1..5.include?(0.0) : false , 1...5.include?(0.0) : false
1..5.include?(1.0) :  true , 1...5.include?(1.0) :  true
1..5.include?(4.9) :  true , 1...5.include?(4.9) :  true
1..5.include?(5.0) :  true , 1...5.include?(5.0) : false
1..5.include?(6.0) : false , 1...5.include?(6.0) : false
```

### 部分配列の取得

``` ruby
a = [1,2,3,4,5]
# 添字3を含む
print(a[1..3], "\n")
```

``` txt
[2, 3, 4]
```

### 配列の生成

``` ruby
# 普通のRange
print(1..5.to_i , "\n")

# Rangeを使った配列の生成
print((1..5).to_a, "\n")
print((1...5).to_a, "\n")
```

``` txt
1..5
[1, 2, 3, 4, 5]
[1, 2, 3, 4]
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