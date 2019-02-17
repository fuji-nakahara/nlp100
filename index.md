# 言語処理100本ノック

- [言語処理100本ノック 2015](http://www.cl.ecei.tohoku.ac.jp/nlp100/)
- [fuji-nakahara/nlp100](https://github.com/fuji-nakahara/nlp100)

## 第1章: 準備運動
### 00

> 文字列"stressed"の文字を逆に（末尾から先頭に向かって）並べた文字列を得よ．

```ruby
str = 'stressed'
res = str.reverse
puts res
```

```
desserts
```



### 01

> 「パタトクカシーー」という文字列の1,3,5,7文字目を取り出して連結した文字列を得よ．

```ruby
str = 'パタトクカシーー'
res = str.chars.values_at(0, 2, 4, 6).join
puts res
```

```
パトカー
```



### 02

> 「パトカー」＋「タクシー」の文字を先頭から交互に連結して文字列「パタトクカシーー」を得よ．

```ruby
s1  = 'パトカー'
s2  = 'タクシー'
res = [s1, s2].map(&:chars).transpose.join
puts res
```

```
パタトクカシーー
```



### 03

> "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."
> という文を単語に分解し，各単語の（アルファベットの）文字数を先頭から出現順に並べたリストを作成せよ．

```ruby
sentence = 'Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics.'
res      = sentence.split.map { |word| word[/[[:alpha:]]*/].size }
p res
```

```
[3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9]
```



### 04

> "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."
> という文を単語に分解し，1, 5, 6, 7, 8, 9, 15, 16, 19番目の単語は先頭の1文字，それ以外の単語は先頭に2文字を取り出し，
> 取り出した文字列から単語の位置（先頭から何番目の単語か）への連想配列（辞書型もしくはマップ型）を作成せよ．

```ruby
sentence = 'Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can.'
res      = sentence.split.map.with_index(1) do |word, i|
  str = if [1, 5, 6, 7, 8, 9, 15, 16, 19].include?(i)
          word[0]
        else
          word[0..1]
        end
  [str, i]
end.to_h
puts res
```

```
{"H"=>1, "He"=>2, "Li"=>3, "Be"=>4, "B"=>5, "C"=>6, "N"=>7, "O"=>8, "F"=>9, "Ne"=>10, "Na"=>11, "Mi"=>12, "Al"=>13, "Si"=>14, "P"=>15, "S"=>16, "Cl"=>17, "Ar"=>18, "K"=>19, "Ca"=>20}
```



### 05

> 与えられたシーケンス（文字列やリストなど）からn-gramを作る関数を作成せよ．
> この関数を用い，"I am an NLPer"という文から単語bi-gram，文字bi-gramを得よ．

```ruby
def n_gram(arr, n: 2)
  arr.each_cons(n).to_a
end

sentence = 'I am an NLPer'

puts "単語bi-gram: #{n_gram(sentence.split)}"
puts "文字bi-gram: #{n_gram(sentence.chars)}"
```

```
単語bi-gram: [["I", "am"], ["am", "an"], ["an", "NLPer"]]
文字bi-gram: [["I", " "], [" ", "a"], ["a", "m"], ["m", " "], [" ", "a"], ["a", "n"], ["n", " "], [" ", "N"], ["N", "L"], ["L", "P"], ["P", "e"], ["e", "r"]]
```



### 06

> "paraparaparadise"と"paragraph"に含まれる文字bi-gramの集合を，それぞれ, XとYとして求め，XとYの和集合，積集合，差集合を求めよ．
> さらに，'se'というbi-gramがXおよびYに含まれるかどうかを調べよ．

```ruby
def bi_gram(str)
  str.chars.each_cons(2).map(&:join)
end

x = bi_gram('paraparaparadise')
y = bi_gram('paragraph')

puts "和集合: #{x | y}"
puts "積集合: #{x & y}"
puts "差集合: #{x - y}"
puts "'se'というbi-gramがXに含まれるか: #{x.include?('se')}"
puts "'se'というbi-gramがYに含まれるか: #{y.include?('se')}"
```

```
和集合: ["pa", "ar", "ra", "ap", "ad", "di", "is", "se", "ag", "gr", "ph"]
積集合: ["pa", "ar", "ra", "ap"]
差集合: ["ad", "di", "is", "se"]
'se'というbi-gramがXに含まれるか: true
'se'というbi-gramがYに含まれるか: false
```



### 07

> 引数x, y, zを受け取り「x時のyはz」という文字列を返す関数を実装せよ．
> さらに，x=12, y="気温", z=22.4として，実行結果を確認せよ．

```ruby
def template(x:, y:, z:)
  "#{x}時の#{y}は#{z}"
end

puts template(x: 12, y: '気温', z: '22.4')
```

```
12時の気温は22.4
```



### 08

> 与えられた文字列の各文字を，以下の仕様で変換する関数cipherを実装せよ．
>
> - 英小文字ならば(219 - 文字コード)の文字に置換
> - その他の文字はそのまま出力
>
> この関数を用い，英語のメッセージを暗号化・復号化せよ．

```ruby
str = ARGV[0] || 'message'

def cipher(str)
  str.chars.map do |char|
    if char.match?(/[[:lower:]]/)
      (219 - char.ord).chr
    else
      char
    end
  end.join
end

puts "暗号化: #{cipher(str)}"
puts "復号化: #{cipher(cipher(str))}"
```

```
暗号化: nvhhztv
復号化: message
```



### 09

> スペースで区切られた単語列に対して，各単語の先頭と末尾の文字は残し，それ以外の文字の順序をランダムに並び替えるプログラムを作成せよ．
> ただし，長さが４以下の単語は並び替えないこととする．
> 適当な英語の文（例えば"I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind ."）を与え，その実行結果を確認せよ．

```ruby
sentence = ARGV[0] || "I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind ."
res      = sentence.split(' ').map do |word|
  next word if word.size <= 4
  word[0] + word[1..-2].chars.shuffle.join + word[-1]
end.join(' ')
puts res
```

```
I cuonl'dt bvieele that I colud altulacy uentrsadnd what I was rdeanig : the penemanhol pweor of the hmuan mind .
```



## 第2章: UNIXコマンドの基礎
### 10

> 行数をカウントせよ．
> 確認にはwcコマンドを用いよ．

```ruby
file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = File.readlines(file_path).size

raise 'Failed!' if res != `wc -l #{file_path}`.split[0].to_i

puts res
```

```
24
```



### 11

> タブ1文字につきスペース1文字に置換せよ．
> 確認にはsedコマンド，trコマンド，もしくはexpandコマンドを用いよ．

```ruby
file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = File.read(file_path).tr("\t", ' ')

raise 'Failed!' if res != `tr '\t' ' ' < #{file_path}`

puts res
```

```
高知県 江川崎 41 2013-08-12
埼玉県 熊谷 40.9 2007-08-16
岐阜県 多治見 40.9 2007-08-16
山形県 山形 40.8 1933-07-25
山梨県 甲府 40.7 2013-08-10
和歌山県 かつらぎ 40.6 1994-08-08
静岡県 天竜 40.6 1994-08-04
山梨県 勝沼 40.5 2013-08-10
埼玉県 越谷 40.4 2007-08-16
群馬県 館林 40.3 2007-08-16
群馬県 上里見 40.3 1998-07-04
愛知県 愛西 40.3 1994-08-05
千葉県 牛久 40.2 2004-07-20
静岡県 佐久間 40.2 2001-07-24
愛媛県 宇和島 40.2 1927-07-22
山形県 酒田 40.1 1978-08-03
岐阜県 美濃 40 2007-08-16
群馬県 前橋 40 2001-07-24
千葉県 茂原 39.9 2013-08-11
埼玉県 鳩山 39.9 1997-07-05
大阪府 豊中 39.9 1994-08-08
山梨県 大月 39.9 1990-07-19
山形県 鶴岡 39.9 1978-08-03
愛知県 名古屋 39.9 1942-08-02
```



### 12

> 各行の1列目だけを抜き出したものをcol1.txtに，2列目だけを抜き出したものをcol2.txtとしてファイルに保存せよ．
> 確認にはcutコマンドを用いよ．

```ruby
require 'csv'

data_path = File.expand_path('../data/hightemp.txt', __dir__)

col1_path = File.expand_path('../output/col1.txt', __dir__)
col2_path = File.expand_path('../output/col2.txt', __dir__)

col1 = []
col2 = []
CSV.foreach(data_path, col_sep: "\t") do |row|
  col1 << row[0]
  col2 << row[1]
end

raise 'Failed!' if col1 != `cut -f 1 #{data_path}`.lines(chomp: true) || col2 != `cut -f 2 #{data_path}`.lines(chomp: true)

File.open(col1_path, 'w') { |f| f.puts col1 }
File.open(col2_path, 'w') { |f| f.puts col2 }
puts 'See output/col1.txt and output/col2.txt'
```

```
See output/col1.txt and output/col2.txt
```

- [col1.txt](col1.txt)
- [col2.txt](col2.txt)

### 13

> 12で作ったcol1.txtとcol2.txtを結合し，元のファイルの1列目と2列目をタブ区切りで並べたテキストファイルを作成せよ．
> 確認にはpasteコマンドを用いよ．

```ruby
require 'csv'

col1_path = File.expand_path('../output/col1.txt', __dir__)
col2_path = File.expand_path('../output/col2.txt', __dir__)

output_path = File.expand_path('../output/13.txt', __dir__)

col1 = File.readlines(col1_path, chomp: true)
col2 = File.readlines(col2_path, chomp: true)

res = [col1, col2].transpose.map { |row| row.join("\t") }

raise 'Failed!' if res != `paste #{col1_path} #{col2_path}`.lines(chomp: true)

File.open(output_path, 'w') { |f| f.puts res }
puts 'See output/13.txt'
```

```
See output/13.txt
```

- [13.txt](13.txt)

### 14

> 自然数Nをコマンドライン引数などの手段で受け取り，入力のうち先頭のN行だけを表示せよ．
> 確認にはheadコマンドを用いよ．

```ruby
n = ARGV[0]&.to_i || 10

file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = File.foreach(file_path).first(n).join

raise 'Failed!' if res != `head -n #{n} #{file_path}`

puts res
```

```
高知県	江川崎	41	2013-08-12
埼玉県	熊谷	40.9	2007-08-16
岐阜県	多治見	40.9	2007-08-16
山形県	山形	40.8	1933-07-25
山梨県	甲府	40.7	2013-08-10
和歌山県	かつらぎ	40.6	1994-08-08
静岡県	天竜	40.6	1994-08-04
山梨県	勝沼	40.5	2013-08-10
埼玉県	越谷	40.4	2007-08-16
群馬県	館林	40.3	2007-08-16
```



### 15

> 自然数Nをコマンドライン引数などの手段で受け取り，入力のうち末尾のN行だけを表示せよ．
> 確認にはtailコマンドを用いよ．

```ruby
n = ARGV[0]&.to_i || 10

file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = File.foreach(file_path).reverse_each.first(n).reverse.join

raise 'Failed!' if res != `tail -n #{n} #{file_path}`

puts res
```

```
愛媛県	宇和島	40.2	1927-07-22
山形県	酒田	40.1	1978-08-03
岐阜県	美濃	40	2007-08-16
群馬県	前橋	40	2001-07-24
千葉県	茂原	39.9	2013-08-11
埼玉県	鳩山	39.9	1997-07-05
大阪府	豊中	39.9	1994-08-08
山梨県	大月	39.9	1990-07-19
山形県	鶴岡	39.9	1978-08-03
愛知県	名古屋	39.9	1942-08-02
```



### 16

> 自然数Nをコマンドライン引数などの手段で受け取り，入力のファイルを行単位でN分割せよ．
> 同様の処理をsplitコマンドで実現せよ．

```ruby
require 'tmpdir'

n = ARGV[0]&.to_i || 3

file_path = File.expand_path('../data/hightemp.txt', __dir__)

lines      = File.readlines(file_path)
line_count = (lines.size / n.to_f).ceil
results    = lines.each_slice(line_count).map(&:join)

Dir.mktmpdir do |dir|
  system "cd #{dir} && split -l #{line_count} #{file_path}"
  answers = Dir.children(dir).sort.map { |path| File.read(File.join(dir, path)) }
  raise 'Failed!' if results.zip(answers).any? { |res, ans| res != ans }
end

results.each.with_index(1) do |res, i|
  puts i, res, ''
end
```

```
1
高知県	江川崎	41	2013-08-12
埼玉県	熊谷	40.9	2007-08-16
岐阜県	多治見	40.9	2007-08-16
山形県	山形	40.8	1933-07-25
山梨県	甲府	40.7	2013-08-10
和歌山県	かつらぎ	40.6	1994-08-08
静岡県	天竜	40.6	1994-08-04
山梨県	勝沼	40.5	2013-08-10

2
埼玉県	越谷	40.4	2007-08-16
群馬県	館林	40.3	2007-08-16
群馬県	上里見	40.3	1998-07-04
愛知県	愛西	40.3	1994-08-05
千葉県	牛久	40.2	2004-07-20
静岡県	佐久間	40.2	2001-07-24
愛媛県	宇和島	40.2	1927-07-22
山形県	酒田	40.1	1978-08-03

3
岐阜県	美濃	40	2007-08-16
群馬県	前橋	40	2001-07-24
千葉県	茂原	39.9	2013-08-11
埼玉県	鳩山	39.9	1997-07-05
大阪府	豊中	39.9	1994-08-08
山梨県	大月	39.9	1990-07-19
山形県	鶴岡	39.9	1978-08-03
愛知県	名古屋	39.9	1942-08-02

```



### 17

> 1列目の文字列の種類（異なる文字列の集合）を求めよ．
> 確認にはsort, uniqコマンドを用いよ．

```ruby
require 'csv'

file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = CSV.read(file_path, col_sep: "\t").map { |row| row[0] }.uniq.sort

raise 'Failed!' if res != `cut -f 1 #{file_path} | sort | uniq`.lines(chomp: true).sort

puts res
```

```
千葉県
和歌山県
埼玉県
大阪府
山形県
山梨県
岐阜県
愛媛県
愛知県
群馬県
静岡県
高知県
```



### 18

> 各行を3コラム目の数値の逆順で整列せよ（注意: 各行の内容は変更せずに並び替えよ）．
> 確認にはsortコマンドを用いよ（この問題はコマンドで実行した時の結果と合わなくてもよい）．

```ruby
require 'csv'

file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = CSV.read(file_path, col_sep: "\t").sort_by { |row| -row[2].to_f }.map { |row| row.join("\t") }

# raise 'Failed' if res != `sort -k 3 -r #{file_path}`.lines(chomp: true)

puts res
```

```
高知県	江川崎	41	2013-08-12
埼玉県	熊谷	40.9	2007-08-16
岐阜県	多治見	40.9	2007-08-16
山形県	山形	40.8	1933-07-25
山梨県	甲府	40.7	2013-08-10
静岡県	天竜	40.6	1994-08-04
和歌山県	かつらぎ	40.6	1994-08-08
山梨県	勝沼	40.5	2013-08-10
埼玉県	越谷	40.4	2007-08-16
群馬県	館林	40.3	2007-08-16
群馬県	上里見	40.3	1998-07-04
愛知県	愛西	40.3	1994-08-05
千葉県	牛久	40.2	2004-07-20
静岡県	佐久間	40.2	2001-07-24
愛媛県	宇和島	40.2	1927-07-22
山形県	酒田	40.1	1978-08-03
群馬県	前橋	40	2001-07-24
岐阜県	美濃	40	2007-08-16
大阪府	豊中	39.9	1994-08-08
山梨県	大月	39.9	1990-07-19
山形県	鶴岡	39.9	1978-08-03
愛知県	名古屋	39.9	1942-08-02
千葉県	茂原	39.9	2013-08-11
埼玉県	鳩山	39.9	1997-07-05
```



### 19

> 各行の1列目の文字列の出現頻度を求め，その高い順に並べて表示せよ．
> 確認にはcut, uniq, sortコマンドを用いよ．

```ruby
require 'csv'

file_path = File.expand_path('../data/hightemp.txt', __dir__)

col1 = CSV.read(file_path, col_sep: "\t").map { |row| row[0] }
res  = col1.each_with_object(Hash.new(0)) { |str, hash| hash[str] += 1 }.sort_by { |_, val| -val }.to_h

answer = `cut -f 1 #{file_path} | sort | uniq -c | sort -r`
raise 'Failed' if res != answer.lines(chomp: true).map(&:split).map { |count, val| [val, count.to_i] }.to_h

puts res
```

```
{"群馬県"=>3, "山形県"=>3, "山梨県"=>3, "埼玉県"=>3, "静岡県"=>2, "千葉県"=>2, "岐阜県"=>2, "愛知県"=>2, "大阪府"=>1, "和歌山県"=>1, "愛媛県"=>1, "高知県"=>1}
```



## 第3章: 正規表現
### 20

> Wikipedia記事のJSONファイルを読み込み，「イギリス」に関する記事本文を表示せよ．
> 問題21-29では，ここで抽出した記事本文に対して実行せよ．

```ruby
require 'json'
require 'zlib'

file_path = File.expand_path('../data/jawiki-country.json.gz', __dir__)

res = ''
Zlib::GzipReader.open(file_path) do |gz|
  gz.each do |line|
    article = JSON.parse(line)
    break res = article['text'] if article['title'] == 'イギリス'
  end
end

puts res.lines.first(5), '...', res.lines.last(5) if $PROGRAM_NAME == __FILE__

BRITISH_ARTICLE_BODY = res
```

```
{{redirect|UK}}
{{基礎情報 国
|略名 = イギリス
|日本語国名 = グレートブリテン及び北アイルランド連合王国
|公式国名 = {{lang|en|United Kingdom of Great Britain and Northern Ireland}}<ref>英語以外での正式国名:<br/>
...
[[Category:欧州連合加盟国]]
[[Category:海洋国家]]
[[Category:君主国]]
[[Category:島国|くれいとふりてん]]
[[Category:1801年に設立された州・地域]]
```



### 21

> 記事中でカテゴリ名を宣言している行を抽出せよ．

```ruby
require_relative '20'

res = BRITISH_ARTICLE_BODY.scan(/^.*\[\[Category:.+\]\].*$/)
puts res
```

```
[[Category:イギリス|*]]
[[Category:英連邦王国|*]]
[[Category:G8加盟国]]
[[Category:欧州連合加盟国]]
[[Category:海洋国家]]
[[Category:君主国]]
[[Category:島国|くれいとふりてん]]
[[Category:1801年に設立された州・地域]]
```



### 22

> 記事のカテゴリ名を（行単位ではなく名前で）抽出せよ．

```ruby
require_relative '20'

res = BRITISH_ARTICLE_BODY.scan(/\[\[Category:(.+?)(?:\|.*)?\]\]/)
puts res
```

```
イギリス
英連邦王国
G8加盟国
欧州連合加盟国
海洋国家
君主国
島国
1801年に設立された州・地域
```



### 23

> 記事中に含まれるセクション名とそのレベル（例えば"== セクション名 =="なら1）を表示せよ．

```ruby
require_relative '20'

res = BRITISH_ARTICLE_BODY.scan(/(={2,}) ?(.+?) ?\1/).each_with_object([]) do |(mark, name), arr|
  arr << { name: name, level: mark.size - 1 }
end
puts res
```

```
{:name=>"国名", :level=>1}
{:name=>"歴史", :level=>1}
{:name=>"地理", :level=>1}
{:name=>"気候", :level=>2}
{:name=>"政治", :level=>1}
{:name=>"外交と軍事", :level=>1}
{:name=>"地方行政区分", :level=>1}
{:name=>"主要都市", :level=>2}
{:name=>"科学技術", :level=>1}
{:name=>"経済", :level=>1}
{:name=>"鉱業", :level=>2}
{:name=>"農業", :level=>2}
{:name=>"貿易", :level=>2}
{:name=>"通貨", :level=>2}
{:name=>"企業", :level=>2}
{:name=>"交通", :level=>1}
{:name=>"道路", :level=>2}
{:name=>"鉄道", :level=>2}
{:name=>"海運", :level=>2}
{:name=>"航空", :level=>2}
{:name=>"通信", :level=>1}
{:name=>"国民", :level=>1}
{:name=>"言語", :level=>2}
{:name=>"宗教", :level=>2}
{:name=>"婚姻", :level=>2}
{:name=>"教育", :level=>2}
{:name=>"文化", :level=>1}
{:name=>"食文化", :level=>2}
{:name=>"文学", :level=>2}
{:name=>"哲学", :level=>2}
{:name=>"音楽", :level=>2}
{:name=>"イギリスのポピュラー音楽", :level=>3}
{:name=>"映画", :level=>2}
{:name=>"コメディ", :level=>2}
{:name=>"国花", :level=>2}
{:name=>"世界遺産", :level=>2}
{:name=>"祝祭日", :level=>2}
{:name=>"スポーツ", :level=>1}
{:name=>"サッカー", :level=>2}
{:name=>"競馬", :level=>2}
{:name=>"モータースポーツ", :level=>2}
{:name=>"脚注", :level=>1}
{:name=>"関連項目", :level=>1}
{:name=>"外部リンク", :level=>1}
```



### 24

> 記事から参照されているメディアファイルをすべて抜き出せ．

```ruby
require_relative '20'

res = BRITISH_ARTICLE_BODY.scan(/(?:ファイル|File):(.+?)(?:\||\]\]|$)/i)
puts res
```

```
Royal Coat of Arms of the United Kingdom.svg
Battle of Waterloo 1815.PNG
The British Empire.png
Uk topo en.jpg
BenNevis2005.jpg
Elizabeth II greets NASA GSFC employees, May 8, 2007 edit.jpg
Palace of Westminster, London - Feb 2007.jpg
David Cameron and Barack Obama at the G20 Summit in Toronto.jpg
Soldiers Trooping the Colour, 16th June 2007.jpg
Scotland Parliament Holyrood.jpg
London.bankofengland.arp.jpg
City of London skyline from London City Hall - Oct 2008.jpg
Oil platform in the North SeaPros.jpg
Eurostar at St Pancras Jan 2008.jpg
Heathrow T5.jpg
Anglospeak.svg
CHANDOS3.jpg
The Fabs.JPG
PalaceOfWestminsterAtNight.jpg
Westminster Abbey - West Door.jpg
Edinburgh Cockburn St dsc06789.jpg
Canterbury Cathedral - Portal Nave Cross-spire.jpeg
Kew Gardens Palm House, London - July 2009.jpg
2005-06-27 - United Kingdom - England - London - Greenwich.jpg
Stonehenge2007 07 30.jpg
Yard2.jpg
Durham Kathedrale Nahaufnahme.jpg
Roman Baths in Bath Spa, England - July 2006.jpg
Fountains Abbey view02 2005-08-27.jpg
Blenheim Palace IMG 3673.JPG
Liverpool Pier Head by night.jpg
Hadrian's Wall view near Greenhead.jpg
London Tower (1).JPG
Wembley Stadium, illuminated.jpg
```



### 25

> 記事中に含まれる「基礎情報」テンプレートのフィールド名と値を抽出し，辞書オブジェクトとして格納せよ．

```ruby
require_relative '20'

basic_info = BRITISH_ARTICLE_BODY[/{{\s*基礎情報 国\s*((\|\s*.+?\s*=\s*.+?)*)}}/m, 1]
res        = basic_info.scan(/^\|\s*(.+?)\s*=\s*(.+?)(?=(?:\n\||\n\z))/m).each_with_object({}) do |(key, val), hash|
  hash[key] = val
end
pp res
```

```
{"略名"=>"イギリス",
 "日本語国名"=>"グレートブリテン及び北アイルランド連合王国",
 "公式国名"=>
  "{{lang|en|United Kingdom of Great Britain and Northern Ireland}}<ref>英語以外での正式国名:<br/>\n" +
  "*{{lang|gd|An Rìoghachd Aonaichte na Breatainn Mhòr agus Eirinn mu Thuath}}（[[スコットランド・ゲール語]]）<br/>\n" +
  "*{{lang|cy|Teyrnas Gyfunol Prydain Fawr a Gogledd Iwerddon}}（[[ウェールズ語]]）<br/>\n" +
  "*{{lang|ga|Ríocht Aontaithe na Breataine Móire agus Tuaisceart na hÉireann}}（[[アイルランド語]]）<br/>\n" +
  "*{{lang|kw|An Rywvaneth Unys a Vreten Veur hag Iwerdhon Glédh}}（[[コーンウォール語]]）<br/>\n" +
  "*{{lang|sco|Unitit Kinrick o Great Breetain an Northren Ireland}}（[[スコットランド語]]）<br/>\n" +
  "**{{lang|sco|Claught Kängrick o Docht Brätain an Norlin Airlann}}、{{lang|sco|Unitet Kängdom o Great Brittain an Norlin Airlann}}（アルスター・スコットランド語）</ref>",
 "国旗画像"=>"Flag of the United Kingdom.svg",
 "国章画像"=>"[[ファイル:Royal Coat of Arms of the United Kingdom.svg|85px|イギリスの国章]]",
 "国章リンク"=>"（[[イギリスの国章|国章]]）",
 "標語"=>"{{lang|fr|Dieu et mon droit}}<br/>（[[フランス語]]:神と私の権利）",
 "国歌"=>"[[女王陛下万歳|神よ女王陛下を守り給え]]",
 "位置画像"=>"Location_UK_EU_Europe_001.svg",
 "公用語"=>"[[英語]]（事実上）",
 "首都"=>"[[ロンドン]]",
 "最大都市"=>"ロンドン",
 "元首等肩書"=>"[[イギリスの君主|女王]]",
 "元首等氏名"=>"[[エリザベス2世]]",
 "首相等肩書"=>"[[イギリスの首相|首相]]",
 "首相等氏名"=>"[[デーヴィッド・キャメロン]]",
 "面積順位"=>"76",
 "面積大きさ"=>"1 E11",
 "面積値"=>"244,820",
 "水面積率"=>"1.3%",
 "人口統計年"=>"2011",
 "人口順位"=>"22",
 "人口大きさ"=>"1 E7",
 "人口値"=>
  "63,181,775<ref>[http://esa.un.org/unpd/wpp/Excel-Data/population.htm United Nations Department of Economic and Social Affairs>Population Division>Data>Population>Total Population]</ref>",
 "人口密度値"=>"246",
 "GDP統計年元"=>"2012",
 "GDP値元"=>
  "1兆5478億<ref name=\"imf-statistics-gdp\">[http://www.imf.org/external/pubs/ft/weo/2012/02/weodata/weorept.aspx?pr.x=70&pr.y=13&sy=2010&ey=2012&scsm=1&ssd=1&sort=country&ds=.&br=1&c=112&s=NGDP%2CNGDPD%2CPPPGDP%2CPPPPC&grp=0&a= IMF>Data and Statistics>World Economic Outlook Databases>By Countrise>United Kingdom]</ref>",
 "GDP統計年MER"=>"2012",
 "GDP順位MER"=>"5",
 "GDP値MER"=>"2兆4337億<ref name=\"imf-statistics-gdp\" />",
 "GDP統計年"=>"2012",
 "GDP順位"=>"6",
 "GDP値"=>"2兆3162億<ref name=\"imf-statistics-gdp\" />",
 "GDP/人"=>"36,727<ref name=\"imf-statistics-gdp\" />",
 "建国形態"=>"建国",
 "確立形態1"=>"[[イングランド王国]]／[[スコットランド王国]]<br />（両国とも[[連合法 (1707年)|1707年連合法]]まで）",
 "確立年月日1"=>"[[927年]]／[[843年]]",
 "確立形態2"=>"[[グレートブリテン王国]]建国<br />（[[連合法 (1707年)|1707年連合法]]）",
 "確立年月日2"=>"[[1707年]]",
 "確立形態3"=>"[[グレートブリテン及びアイルランド連合王国]]建国<br />（[[連合法 (1800年)|1800年連合法]]）",
 "確立年月日3"=>"[[1801年]]",
 "確立形態4"=>"現在の国号「'''グレートブリテン及び北アイルランド連合王国'''」に変更",
 "確立年月日4"=>"[[1927年]]",
 "通貨"=>"[[スターリング・ポンド|UKポンド]] (&pound;)",
 "通貨コード"=>"GBP",
 "時間帯"=>"±0",
 "夏時間"=>"+1",
 "ISO 3166-1"=>"GB / GBR",
 "ccTLD"=>"[[.uk]] / [[.gb]]<ref>使用は.ukに比べ圧倒的少数。</ref>",
 "国際電話番号"=>"44",
 "注記"=>"<references />"}
```



### 26

> 25の処理時に，テンプレートの値からMediaWikiの強調マークアップ（弱い強調，強調，強い強調のすべて）を除去してテキストに変換せよ．

```ruby
require_relative '20'

basic_info = BRITISH_ARTICLE_BODY[/{{\s*基礎情報 国\s*((\|\s*.+?\s*=\s*.+?)*)}}/m, 1]
res        = basic_info.scan(/^\|\s*(.+?)\s*=\s*(.+?)(?=(?:\n\||\n\z))/m).each_with_object({}) do |(key, val), hash|
  hash[key] = val.gsub(/('{2,5})(.+?)\1/, '\2')
end
pp res
```

```
{"略名"=>"イギリス",
 "日本語国名"=>"グレートブリテン及び北アイルランド連合王国",
 "公式国名"=>
  "{{lang|en|United Kingdom of Great Britain and Northern Ireland}}<ref>英語以外での正式国名:<br/>\n" +
  "*{{lang|gd|An Rìoghachd Aonaichte na Breatainn Mhòr agus Eirinn mu Thuath}}（[[スコットランド・ゲール語]]）<br/>\n" +
  "*{{lang|cy|Teyrnas Gyfunol Prydain Fawr a Gogledd Iwerddon}}（[[ウェールズ語]]）<br/>\n" +
  "*{{lang|ga|Ríocht Aontaithe na Breataine Móire agus Tuaisceart na hÉireann}}（[[アイルランド語]]）<br/>\n" +
  "*{{lang|kw|An Rywvaneth Unys a Vreten Veur hag Iwerdhon Glédh}}（[[コーンウォール語]]）<br/>\n" +
  "*{{lang|sco|Unitit Kinrick o Great Breetain an Northren Ireland}}（[[スコットランド語]]）<br/>\n" +
  "**{{lang|sco|Claught Kängrick o Docht Brätain an Norlin Airlann}}、{{lang|sco|Unitet Kängdom o Great Brittain an Norlin Airlann}}（アルスター・スコットランド語）</ref>",
 "国旗画像"=>"Flag of the United Kingdom.svg",
 "国章画像"=>"[[ファイル:Royal Coat of Arms of the United Kingdom.svg|85px|イギリスの国章]]",
 "国章リンク"=>"（[[イギリスの国章|国章]]）",
 "標語"=>"{{lang|fr|Dieu et mon droit}}<br/>（[[フランス語]]:神と私の権利）",
 "国歌"=>"[[女王陛下万歳|神よ女王陛下を守り給え]]",
 "位置画像"=>"Location_UK_EU_Europe_001.svg",
 "公用語"=>"[[英語]]（事実上）",
 "首都"=>"[[ロンドン]]",
 "最大都市"=>"ロンドン",
 "元首等肩書"=>"[[イギリスの君主|女王]]",
 "元首等氏名"=>"[[エリザベス2世]]",
 "首相等肩書"=>"[[イギリスの首相|首相]]",
 "首相等氏名"=>"[[デーヴィッド・キャメロン]]",
 "面積順位"=>"76",
 "面積大きさ"=>"1 E11",
 "面積値"=>"244,820",
 "水面積率"=>"1.3%",
 "人口統計年"=>"2011",
 "人口順位"=>"22",
 "人口大きさ"=>"1 E7",
 "人口値"=>
  "63,181,775<ref>[http://esa.un.org/unpd/wpp/Excel-Data/population.htm United Nations Department of Economic and Social Affairs>Population Division>Data>Population>Total Population]</ref>",
 "人口密度値"=>"246",
 "GDP統計年元"=>"2012",
 "GDP値元"=>
  "1兆5478億<ref name=\"imf-statistics-gdp\">[http://www.imf.org/external/pubs/ft/weo/2012/02/weodata/weorept.aspx?pr.x=70&pr.y=13&sy=2010&ey=2012&scsm=1&ssd=1&sort=country&ds=.&br=1&c=112&s=NGDP%2CNGDPD%2CPPPGDP%2CPPPPC&grp=0&a= IMF>Data and Statistics>World Economic Outlook Databases>By Countrise>United Kingdom]</ref>",
 "GDP統計年MER"=>"2012",
 "GDP順位MER"=>"5",
 "GDP値MER"=>"2兆4337億<ref name=\"imf-statistics-gdp\" />",
 "GDP統計年"=>"2012",
 "GDP順位"=>"6",
 "GDP値"=>"2兆3162億<ref name=\"imf-statistics-gdp\" />",
 "GDP/人"=>"36,727<ref name=\"imf-statistics-gdp\" />",
 "建国形態"=>"建国",
 "確立形態1"=>"[[イングランド王国]]／[[スコットランド王国]]<br />（両国とも[[連合法 (1707年)|1707年連合法]]まで）",
 "確立年月日1"=>"[[927年]]／[[843年]]",
 "確立形態2"=>"[[グレートブリテン王国]]建国<br />（[[連合法 (1707年)|1707年連合法]]）",
 "確立年月日2"=>"[[1707年]]",
 "確立形態3"=>"[[グレートブリテン及びアイルランド連合王国]]建国<br />（[[連合法 (1800年)|1800年連合法]]）",
 "確立年月日3"=>"[[1801年]]",
 "確立形態4"=>"現在の国号「グレートブリテン及び北アイルランド連合王国」に変更",
 "確立年月日4"=>"[[1927年]]",
 "通貨"=>"[[スターリング・ポンド|UKポンド]] (&pound;)",
 "通貨コード"=>"GBP",
 "時間帯"=>"±0",
 "夏時間"=>"+1",
 "ISO 3166-1"=>"GB / GBR",
 "ccTLD"=>"[[.uk]] / [[.gb]]<ref>使用は.ukに比べ圧倒的少数。</ref>",
 "国際電話番号"=>"44",
 "注記"=>"<references />"}
```



### 27

> 26の処理に加えて，テンプレートの値からMediaWikiの内部リンクマークアップを除去し，テキストに変換せよ

```ruby
require_relative '20'

basic_info = BRITISH_ARTICLE_BODY[/{{\s*基礎情報 国\s*((\|\s*.+?\s*=\s*.+?)*)}}/m, 1]
res        = basic_info.scan(/^\|\s*(.+?)\s*=\s*(.+?)(?=(?:\n\||\n\z))/m).each_with_object({}) do |(key, val), hash|
  val = val.gsub(/('{2,5})(.+?)\1/, '\2')
  val = val.gsub(/\[\[.+?\]\]/i) do |link|
    md = link.match(/\[\[(.+?)(?:\|(.+?))?\]\]/)
    if md[1].start_with?(/(ファイル|File):/i)
      link
    else
      md[2].nil? ? md[1] : md[2]
    end
  end
  val = val

  hash[key] = val
end
pp res
```

```
{"略名"=>"イギリス",
 "日本語国名"=>"グレートブリテン及び北アイルランド連合王国",
 "公式国名"=>
  "{{lang|en|United Kingdom of Great Britain and Northern Ireland}}<ref>英語以外での正式国名:<br/>\n" +
  "*{{lang|gd|An Rìoghachd Aonaichte na Breatainn Mhòr agus Eirinn mu Thuath}}（スコットランド・ゲール語）<br/>\n" +
  "*{{lang|cy|Teyrnas Gyfunol Prydain Fawr a Gogledd Iwerddon}}（ウェールズ語）<br/>\n" +
  "*{{lang|ga|Ríocht Aontaithe na Breataine Móire agus Tuaisceart na hÉireann}}（アイルランド語）<br/>\n" +
  "*{{lang|kw|An Rywvaneth Unys a Vreten Veur hag Iwerdhon Glédh}}（コーンウォール語）<br/>\n" +
  "*{{lang|sco|Unitit Kinrick o Great Breetain an Northren Ireland}}（スコットランド語）<br/>\n" +
  "**{{lang|sco|Claught Kängrick o Docht Brätain an Norlin Airlann}}、{{lang|sco|Unitet Kängdom o Great Brittain an Norlin Airlann}}（アルスター・スコットランド語）</ref>",
 "国旗画像"=>"Flag of the United Kingdom.svg",
 "国章画像"=>"[[ファイル:Royal Coat of Arms of the United Kingdom.svg|85px|イギリスの国章]]",
 "国章リンク"=>"（国章）",
 "標語"=>"{{lang|fr|Dieu et mon droit}}<br/>（フランス語:神と私の権利）",
 "国歌"=>"神よ女王陛下を守り給え",
 "位置画像"=>"Location_UK_EU_Europe_001.svg",
 "公用語"=>"英語（事実上）",
 "首都"=>"ロンドン",
 "最大都市"=>"ロンドン",
 "元首等肩書"=>"女王",
 "元首等氏名"=>"エリザベス2世",
 "首相等肩書"=>"首相",
 "首相等氏名"=>"デーヴィッド・キャメロン",
 "面積順位"=>"76",
 "面積大きさ"=>"1 E11",
 "面積値"=>"244,820",
 "水面積率"=>"1.3%",
 "人口統計年"=>"2011",
 "人口順位"=>"22",
 "人口大きさ"=>"1 E7",
 "人口値"=>
  "63,181,775<ref>[http://esa.un.org/unpd/wpp/Excel-Data/population.htm United Nations Department of Economic and Social Affairs>Population Division>Data>Population>Total Population]</ref>",
 "人口密度値"=>"246",
 "GDP統計年元"=>"2012",
 "GDP値元"=>
  "1兆5478億<ref name=\"imf-statistics-gdp\">[http://www.imf.org/external/pubs/ft/weo/2012/02/weodata/weorept.aspx?pr.x=70&pr.y=13&sy=2010&ey=2012&scsm=1&ssd=1&sort=country&ds=.&br=1&c=112&s=NGDP%2CNGDPD%2CPPPGDP%2CPPPPC&grp=0&a= IMF>Data and Statistics>World Economic Outlook Databases>By Countrise>United Kingdom]</ref>",
 "GDP統計年MER"=>"2012",
 "GDP順位MER"=>"5",
 "GDP値MER"=>"2兆4337億<ref name=\"imf-statistics-gdp\" />",
 "GDP統計年"=>"2012",
 "GDP順位"=>"6",
 "GDP値"=>"2兆3162億<ref name=\"imf-statistics-gdp\" />",
 "GDP/人"=>"36,727<ref name=\"imf-statistics-gdp\" />",
 "建国形態"=>"建国",
 "確立形態1"=>"イングランド王国／スコットランド王国<br />（両国とも1707年連合法まで）",
 "確立年月日1"=>"927年／843年",
 "確立形態2"=>"グレートブリテン王国建国<br />（1707年連合法）",
 "確立年月日2"=>"1707年",
 "確立形態3"=>"グレートブリテン及びアイルランド連合王国建国<br />（1800年連合法）",
 "確立年月日3"=>"1801年",
 "確立形態4"=>"現在の国号「グレートブリテン及び北アイルランド連合王国」に変更",
 "確立年月日4"=>"1927年",
 "通貨"=>"UKポンド (&pound;)",
 "通貨コード"=>"GBP",
 "時間帯"=>"±0",
 "夏時間"=>"+1",
 "ISO 3166-1"=>"GB / GBR",
 "ccTLD"=>".uk / .gb<ref>使用は.ukに比べ圧倒的少数。</ref>",
 "国際電話番号"=>"44",
 "注記"=>"<references />"}
```



### 28

> 27の処理に加えて，テンプレートの値からMediaWikiマークアップを可能な限り除去し，国の基本情報を整形せよ．

```ruby
require_relative '20'

basic_info = BRITISH_ARTICLE_BODY[/{{\s*基礎情報 国\s*((\|\s*.+?\s*=\s*.+?)*)}}/m, 1]
res        = basic_info.scan(/^\|\s*(.+?)\s*=\s*(.+?)(?=(?:\n\||\n\z))/m).each_with_object({}) do |(key, val), hash|
  val = val.gsub(/('{2,5})(.+?)\1/, '\2')
  val = val.gsub(/\[\[(?:ファイル|File):(.+?)(?:\|.+?)*\]\]/i, '\1')
  val = val.gsub(/\[\[.+?\]\]/i) do |link|
    md = link.match(/\[\[(.+?)(?:\|(.+?))?\]\]/)
    md[2].nil? ? md[1] : md[2]
  end
  val = val.gsub(/{{lang\|\w+?\|(.*?)}}/, '\1')
  val = val.gsub(%r{(<ref.*?>.*?</ref>|<ref.*?/>)}m, '')
  val = val.gsub(%r{<br ?/>}, "\n")

  hash[key] = val
end
pp res
```

```
{"略名"=>"イギリス",
 "日本語国名"=>"グレートブリテン及び北アイルランド連合王国",
 "公式国名"=>"United Kingdom of Great Britain and Northern Ireland",
 "国旗画像"=>"Flag of the United Kingdom.svg",
 "国章画像"=>"Royal Coat of Arms of the United Kingdom.svg",
 "国章リンク"=>"（国章）",
 "標語"=>"Dieu et mon droit\n" + "（フランス語:神と私の権利）",
 "国歌"=>"神よ女王陛下を守り給え",
 "位置画像"=>"Location_UK_EU_Europe_001.svg",
 "公用語"=>"英語（事実上）",
 "首都"=>"ロンドン",
 "最大都市"=>"ロンドン",
 "元首等肩書"=>"女王",
 "元首等氏名"=>"エリザベス2世",
 "首相等肩書"=>"首相",
 "首相等氏名"=>"デーヴィッド・キャメロン",
 "面積順位"=>"76",
 "面積大きさ"=>"1 E11",
 "面積値"=>"244,820",
 "水面積率"=>"1.3%",
 "人口統計年"=>"2011",
 "人口順位"=>"22",
 "人口大きさ"=>"1 E7",
 "人口値"=>"63,181,775",
 "人口密度値"=>"246",
 "GDP統計年元"=>"2012",
 "GDP値元"=>"1兆5478億",
 "GDP統計年MER"=>"2012",
 "GDP順位MER"=>"5",
 "GDP値MER"=>"2兆4337億",
 "GDP統計年"=>"2012",
 "GDP順位"=>"6",
 "GDP値"=>"2兆3162億",
 "GDP/人"=>"36,727",
 "建国形態"=>"建国",
 "確立形態1"=>"イングランド王国／スコットランド王国\n" + "（両国とも1707年連合法まで）",
 "確立年月日1"=>"927年／843年",
 "確立形態2"=>"グレートブリテン王国建国\n" + "（1707年連合法）",
 "確立年月日2"=>"1707年",
 "確立形態3"=>"グレートブリテン及びアイルランド連合王国建国\n" + "（1800年連合法）",
 "確立年月日3"=>"1801年",
 "確立形態4"=>"現在の国号「グレートブリテン及び北アイルランド連合王国」に変更",
 "確立年月日4"=>"1927年",
 "通貨"=>"UKポンド (&pound;)",
 "通貨コード"=>"GBP",
 "時間帯"=>"±0",
 "夏時間"=>"+1",
 "ISO 3166-1"=>"GB / GBR",
 "ccTLD"=>".uk / .gb",
 "国際電話番号"=>"44",
 "注記"=>""}
```



### 29

> テンプレートの内容を利用し，国旗画像のURLを取得せよ．
> （ヒント: MediaWiki APIのimageinfoを呼び出して，ファイル参照をURLに変換すればよい）

```ruby
require 'json'
require 'open-uri'
require 'uri'

require_relative '20'

flag_file_name = BRITISH_ARTICLE_BODY[/国旗画像\s*=\s*(.*)/, 1]

uri       = URI.parse('https://ja.wikipedia.org/w/api.php')
uri.query = URI.encode_www_form(
  action: 'query',
  titles: "File:#{flag_file_name}",
  prop:   'imageinfo',
  iiprop: 'url',
  format: 'json'
)

res = JSON.parse(uri.open.read)['query']['pages']['-1']['imageinfo'][0]['url']
puts res
```

```
https://upload.wikimedia.org/wikipedia/commons/a/ae/Flag_of_the_United_Kingdom.svg
```



## 第4章: 形態素解析
### 30

> 形態素解析結果（neko.txt.mecab）を読み込むプログラムを実装せよ．
> ただし，各形態素は表層形（surface），基本形（base），品詞（pos），品詞細分類1（pos1）をキーとするマッピング型に格納し，1文を形態素（マッピング型）のリストとして表現せよ．
> 第4章の残りの問題では，ここで作ったプログラムを活用せよ．

```ruby
file_path = File.expand_path('../data/neko.txt.mecab', __dir__)

res = []
File.open(file_path) do |file|
  morphs = []
  file.each_line(chomp: true) do |line|
    if line == 'EOS'
      res << morphs
      morphs = []
    else
      arr = line.split(/[\t,]/)
      morphs << { surface: arr[0], base: arr[7], pos: arr[1], pos1: arr[2] }
    end
  end
end

pp res.first(5) if $PROGRAM_NAME == __FILE__

NEKO_MORPHS_LIST = res
```

```
[[{:surface=>"一", :base=>"一", :pos=>"名詞", :pos1=>"数"}],
 [],
 [{:surface=>"　", :base=>"　", :pos=>"記号", :pos1=>"空白"},
  {:surface=>"吾輩", :base=>"吾輩", :pos=>"名詞", :pos1=>"代名詞"},
  {:surface=>"は", :base=>"は", :pos=>"助詞", :pos1=>"係助詞"},
  {:surface=>"猫", :base=>"猫", :pos=>"名詞", :pos1=>"一般"},
  {:surface=>"で", :base=>"だ", :pos=>"助動詞", :pos1=>"*"},
  {:surface=>"ある", :base=>"ある", :pos=>"助動詞", :pos1=>"*"},
  {:surface=>"。", :base=>"。", :pos=>"記号", :pos1=>"句点"}],
 [{:surface=>"名前", :base=>"名前", :pos=>"名詞", :pos1=>"一般"},
  {:surface=>"は", :base=>"は", :pos=>"助詞", :pos1=>"係助詞"},
  {:surface=>"まだ", :base=>"まだ", :pos=>"副詞", :pos1=>"助詞類接続"},
  {:surface=>"無い", :base=>"無い", :pos=>"形容詞", :pos1=>"自立"},
  {:surface=>"。", :base=>"。", :pos=>"記号", :pos1=>"句点"}],
 []]
```



### 31

> 動詞の表層形をすべて抽出せよ．

```ruby
require_relative '30'

res = NEKO_MORPHS_LIST.map do |morphs|
  morphs
    .select { |morph| morph[:pos] == '動詞' }
    .map { |morph| morph[:surface] }
end.flatten

p res.first(20)
File.open(File.expand_path('../output/31.txt', __dir__), 'w') { |f| f.puts res }
```

```
["生れ", "つか", "し", "泣い", "し", "いる", "始め", "見", "聞く", "捕え", "煮", "食う", "思わ", "載せ", "られ", "持ち上げ", "られ", "し", "あっ", "落ちつい"]
```



### 32

> 動詞の原形をすべて抽出せよ．

```ruby
require_relative '30'

res = NEKO_MORPHS_LIST.map do |morphs|
  morphs
    .select { |morph| morph[:pos] == '動詞' }
    .map { |morph| morph[:base] }
end.flatten

p res.first(20)
File.open(File.expand_path('../output/32.txt', __dir__), 'w') { |f| f.puts res }
```

```
["生れる", "つく", "する", "泣く", "する", "いる", "始める", "見る", "聞く", "捕える", "煮る", "食う", "思う", "載せる", "られる", "持ち上げる", "られる", "する", "ある", "落ちつく"]
```



### 33

> サ変接続の名詞をすべて抽出せよ．

```ruby
require_relative '30'

res = NEKO_MORPHS_LIST.map do |morphs|
  morphs
    .select { |morph| morph[:pos1] == 'サ変接続' && morph[:pos] == '名詞' }
    .map { |morph| morph[:base] }
end.flatten

p res.first(20)
File.open(File.expand_path('../output/33.txt', __dir__), 'w') { |f| f.puts res }
```

```
["見当", "記憶", "話", "装飾", "突起", "運転", "記憶", "分別", "決心", "我慢", "餓死", "訪問", "始末", "猶予", "遭遇", "我慢", "記憶", "返報", "勉強", "勉強"]
```



### 34

> 2つの名詞が「の」で連結されている名詞句を抽出せよ．

```ruby
require_relative '30'

res = NEKO_MORPHS_LIST.each_with_object([]) do |morphs, arr|
  morphs.each_cons(3).each do |ms|
    if ms[0][:pos] == '名詞' && ms[1][:surface] == 'の' && ms[2][:pos] == '名詞'
      arr << ms.map { |m| m[:surface] }.join
    end
  end
end

p res.first(20)
File.open(File.expand_path('../output/34.txt', __dir__), 'w') { |f| f.puts res }
```

```
["彼の掌", "掌の上", "書生の顔", "はずの顔", "顔の真中", "穴の中", "書生の掌", "掌の裏", "何の事", "肝心の母親", "藁の上", "笹原の中", "池の前", "池の上", "一樹の蔭", "垣根の穴", "隣家の三", "時の通路", "一刻の猶予", "家の内"]
```



### 35

> 名詞の連接（連続して出現する名詞）を最長一致で抽出せよ．

```ruby
require_relative '30'

res = NEKO_MORPHS_LIST.each_with_object([]) do |morphs, arr|
  nouns = []
  morphs.each do |morph|
    if morph[:pos] == '名詞'
      nouns << morph[:surface]
    else
      arr << nouns.join if nouns.size > 1
      nouns = []
    end
  end
end

p res.first(20)
File.open(File.expand_path('../output/35.txt', __dir__), 'w') { |f| f.puts res }
```

```
["人間中", "一番獰悪", "時妙", "一毛", "その後猫", "一度", "ぷうぷうと煙", "邸内", "三毛", "書生以外", "四五遍", "この間おさん", "三馬", "御台所", "まま奥", "住家", "終日書斎", "勉強家", "勉強家", "勤勉家"]
```



### 36

> 文章中に出現する単語とその出現頻度を求め，出現頻度の高い順に並べよ．

```ruby
require_relative '30'

res = NEKO_MORPHS_LIST.each_with_object(Hash.new(0)) do |morphs, hash|
  morphs.each do |morph|
    hash[morph[:base]] += 1
  end
end
res = res.sort_by { |_, count| -count }

puts res.first(10).to_h
File.open(File.expand_path('../output/36.txt', __dir__), 'w') { |f| f.puts(res.map { |e| e.join("\t") }) }
```

```
{"の"=>9194, "。"=>7486, "て"=>6848, "、"=>6772, "は"=>6420, "に"=>6243, "を"=>6071, "だ"=>5975, "と"=>5508, "が"=>5337}
```



### 37

> 出現頻度が高い10語とその出現頻度をグラフ（例えば棒グラフなど）で表示せよ．

```ruby
require 'gnuplotrb'

require_relative '30'

output_path = File.expand_path('../output/37.svg', __dir__)

res = NEKO_MORPHS_LIST.each_with_object(Hash.new(0)) do |morphs, hash|
  morphs.each do |morph|
    hash[morph[:base]] += 1
  end
end
res = res.sort_by { |_, count| -count }.first(10).transpose

ds   = GnuplotRB::Dataset.new(res, with: 'histograms', using: '2:xtic(1)', notitle: true)
plot = GnuplotRB::Plot.new(ds, yrange: '[0:]')
plot.to_svg(output_path)
puts 'See output/37.svg'
```

```
See output/37.svg
```

- [37.svg](37.svg)

### 38

> 単語の出現頻度のヒストグラム（横軸に出現頻度，縦軸に出現頻度をとる単語の種類数を棒グラフで表したもの）を描け．

```ruby
require 'gnuplotrb'

require_relative '30'

output_path = File.expand_path('../output/38.svg', __dir__)

word_to_count = NEKO_MORPHS_LIST.each_with_object(Hash.new(0)) do |morphs, hash|
  morphs.each do |morph|
    hash[morph[:base]] += 1
  end
end

res = Array.new(word_to_count.values.max + 1) { 0 }
word_to_count.each do |_, count|
  res[count] += 1
end

ds   = GnuplotRB::Dataset.new(res, with: 'histograms', notitle: true)
plot = GnuplotRB::Plot.new(ds)
plot.to_svg(output_path)
puts 'See output/38.svg'
```

```
See output/38.svg
```

- [38.svg](38.svg)

### 39

> 単語の出現頻度順位を横軸，その出現頻度を縦軸として，両対数グラフをプロットせよ．

```ruby
require 'gnuplotrb'

require_relative '30'

output_path = File.expand_path('../output/39.svg', __dir__)

word_to_count = NEKO_MORPHS_LIST.each_with_object(Hash.new(0)) do |morphs, hash|
  morphs.each do |morph|
    hash[morph[:base]] += 1
  end
end

res = word_to_count.values.sort.reverse

ds   = GnuplotRB::Dataset.new(res, with: 'points', ps: 0.5, pt: 7, notitle: true)
plot = GnuplotRB::Plot.new(ds, logscale: 'xy')
plot.to_svg(output_path)
puts 'See output/39.svg'
```

```
See output/39.svg
```

- [39.svg](39.svg)

## 第5章: 係り受け解析
### 40

> 形態素を表すクラス `Morph` を実装せよ．
> このクラスは表層形（`surface`），基本形（`base`），品詞（`pos`），品詞細分類1（`pos1`）をメンバ変数に持つこととする．
> さらに，CaboChaの解析結果（neko.txt.cabocha）を読み込み，各文を `Morph` オブジェクトのリストとして表現し，3文目の形態素列を表示せよ．

```ruby
Morph = Struct.new(:surface, :base, :pos, :pos1, keyword_init: true)

return if $PROGRAM_NAME != __FILE__

file_path = File.expand_path('../data/neko.txt.cabocha', __dir__)

res = []
File.open(file_path) do |file|
  morphs = []
  file.each_line(chomp: true) do |line|
    next if line.start_with?('*')

    if line == 'EOS'
      res << morphs
      morphs = []
    else
      arr = line.split(/[\t,]/)
      morphs << Morph.new(surface: arr[0], base: arr[7], pos: arr[1], pos1: arr[2])
    end
  end
end

pp res[2]
```

```
[#<struct Morph surface="　", base="　", pos="記号", pos1="空白">,
 #<struct Morph surface="吾輩", base="吾輩", pos="名詞", pos1="代名詞">,
 #<struct Morph surface="は", base="は", pos="助詞", pos1="係助詞">,
 #<struct Morph surface="猫", base="猫", pos="名詞", pos1="一般">,
 #<struct Morph surface="で", base="だ", pos="助動詞", pos1="*">,
 #<struct Morph surface="ある", base="ある", pos="助動詞", pos1="*">,
 #<struct Morph surface="。", base="。", pos="記号", pos1="句点">]
```



### 41

> 40に加えて，文節を表すクラス `Chunk` を実装せよ．
> このクラスは形態素（`Morph` オブジェクト）のリスト（`morphs`），係り先文節インデックス番号（`dst`），係り元文節インデックス番号のリスト（`srcs`）をメンバ変数に持つこととする．
> さらに，入力テキストのCaboChaの解析結果を読み込み，１文を `Chunk` オブジェクトのリストとして表現し，8文目の文節の文字列と係り先を表示せよ．
> 第5章の残りの問題では，ここで作ったプログラムを活用せよ．

```ruby
require_relative '40'

class Chunk
  attr_accessor :morphs
  attr_reader :dst, :srcs

  def initialize(dst: -1, srcs: [], morphs: [])
    @dst    = dst
    @srcs   = srcs
    @morphs = morphs
  end

  def original(symbol: false)
    ms = symbol ? morphs : morphs_without_symbol
    ms.map(&:surface).join
  end

  def dst?
    dst.positive?
  end

  def find_morph(options)
    manipulate_morphs(:find, options)
  end

  def find_last_morph(options)
    manipulate_morphs(:find, morphs: morphs.reverse_each, **options)
  end

  def any_morphs?(options)
    manipulate_morphs(:any?, options)
  end

  def chained_chunks(parent_chunks)
    chunks = [self]
    chunks << parent_chunks[chunks.last.dst] while chunks.last.dst?
    chunks
  end

  private

  def manipulate_morphs(symbol, morphs: self.morphs, **options)
    morphs.send(symbol) do |morph|
      options.all? { |key, val| morph[key] == val }
    end
  end

  def morphs_without_symbol
    manipulate_morphs(:reject, pos: '記号')
  end
end

file_path = File.expand_path('../data/neko.txt.cabocha', __dir__)

res = []
File.open(file_path) do |file|
  chunks = []
  morphs = []
  file.each_line(chomp: true) do |line|
    if line == 'EOS'
      chunks.last.morphs = morphs unless chunks.empty?

      res << chunks
      chunks = []
    elsif line.start_with?('*')
      chunks.last.morphs = morphs unless chunks.empty?

      md   = line.match(/\A\* (?<idx>\d+) (?<dst>-?\d+)D/)
      srcs = chunks.map.with_index { |chunk, i| chunk.dst == md[:idx].to_i ? i : nil }.compact
      chunks << Chunk.new(dst: md[:dst].to_i, srcs: srcs)
      morphs = []
    else
      arr = line.split(/[\t,]/)
      morphs << Morph.new(surface: arr[0], base: arr[7], pos: arr[1], pos1: arr[2])
    end
  end
end

puts(res[7].map.with_index { |chunk, i| "#{chunk.original}\t#{i} #{chunk.dst}D" }) if $PROGRAM_NAME == __FILE__

NEKO_CHUNKS_LIST = res
```

```
吾輩は	0 5D
ここで	1 2D
始めて	2 3D
人間という	3 4D
ものを	4 5D
見た	5 -1D
```



### 42

> 係り元の文節と係り先の文節のテキストをタブ区切り形式ですべて抽出せよ．
> ただし，句読点などの記号は出力しないようにせよ．

```ruby
require_relative '41'

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    next if !chunk.dst? || chunk.original.empty?
    arr << "#{chunk.original}\t#{chunks[chunk.dst].original}"
  end
end

puts res.first(10)
File.open(File.expand_path('../output/42.txt', __dir__), 'w') { |f| f.puts res }
```

```
吾輩は	猫である
名前は	無い
まだ	無い
どこで	生れたか
生れたか	つかぬ
とんと	つかぬ
見当が	つかぬ
何でも	薄暗い
薄暗い	所で
じめじめした	所で
```



### 43

> 名詞を含む文節が，動詞を含む文節に係るとき，これらをタブ区切り形式で抽出せよ．
> ただし，句読点などの記号は出力しないようにせよ．

```ruby
require_relative '41'

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    next if !chunk.dst? || chunk.any_morphs?(pos: '名詞')

    dst_chunk = chunks[chunk.dst]
    next if dst_chunk.any_morphs?(pos: '動詞')

    arr << "#{chunk.original}\t#{dst_chunk.original}"
  end
end

puts res.first(10)
File.open(File.expand_path('../output/43.txt', __dir__), 'w') { |f| f.puts res }
```

```
	猫である
まだ	無い
薄暗い	所で
じめじめした	所で
始めて	人間という
しかも	種族であったそうだ
聞くと	種族であったそうだ
この	書生というのは
食うという	話である
その	当時は
```



### 44

> 与えられた文の係り受け木を有向グラフとして可視化せよ．
> 可視化には，係り受け木をDOT言語に変換し，Graphvizを用いるとよい．
> また，Pythonから有向グラフを直接的に可視化するには，pydotを使うとよい．

```ruby
require 'ruby-graphviz'

require_relative '41'

sentence_idx = ARGV[0]&.to_i || 5
chunks       = NEKO_CHUNKS_LIST.fetch(sentence_idx)

output_path = File.expand_path('../output/44.svg', __dir__)

graph = GraphViz.new(:G) do |g|
  chunks.each_with_index do |chunk, idx|
    node = g.add_nodes(idx.to_s, label: chunk.original)
    chunk.srcs.each do |src_idx|
      g.add_edge(g.get_node(src_idx.to_s), node)
    end
  end
end

graph.output(svg: output_path)
puts 'See output/44.svg'
```

```
See output/44.svg
```

- [44.svg](44.svg)

### 45

> 今回用いている文章をコーパスと見なし，日本語の述語が取りうる格を調査したい．
> 動詞を述語，動詞に係っている文節の助詞を格と考え，述語と格をタブ区切り形式で出力せよ．
> ただし，出力は以下の仕様を満たすようにせよ．
>
> - 動詞を含む文節において，最左の動詞の基本形を述語とする
> - 述語に係る助詞を格とする
> - 述語に係る助詞（文節）が複数あるときは，すべての助詞をスペース区切りで辞書順に並べる
>
> 「吾輩はここで始めて人間というものを見た」という例文（neko.txt.cabochaの8文目）を考える．
> この文は「始める」と「見る」の２つの動詞を含み，「始める」に係る文節は「ここで」，「見る」に係る文節は「吾輩は」と「ものを」と解析された場合は，次のような出力になるはずである．
>
> ```
> 始める  で
> 見る    は を
> ```
>
> このプログラムの出力をファイルに保存し，以下の事項をUNIXコマンドを用いて確認せよ．
>
> - コーパス中で頻出する述語と格パターンの組み合わせ
> - 「する」「見る」「与える」という動詞の格パターン（コーパス中で出現頻度の高い順に並べよ）

```ruby
require_relative '41'

output_path = File.expand_path('../output/45.txt', __dir__)

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    next if chunk.srcs.empty?

    verb = chunk.find_morph(pos: '動詞')
    next if verb.nil?

    joshis = chunk.srcs.map do |src|
      c = chunks[src]
      c.find_last_morph(pos: '助詞', pos1: '格助詞')&.base || c.find_last_morph(pos: '助詞')&.base
    end.compact
    next if joshis.empty?

    arr << [verb.base, joshis.join(' ')].join("\t")
  end
end

File.open(output_path, 'w') { |f| f.puts res }

puts 'コーパス中で頻出する述語と格パターンの組み合わせ:'
system "sort #{output_path} | uniq -c | sort -r | head"

puts "\n「する」「見る」「与える」という動詞の格パターン:"
%w[する 見る 与える].each do |verb|
  system "grep '^#{verb}' #{output_path} | sort | uniq -c | sort -r | head"
  puts
end
```

```
コーパス中で頻出する述語と格パターンの組み合わせ:
 723 云う	と
 453 する	を
 342 思う	と
 217 なる	に
 203 する	に
 202 ある	が
 175 見る	て
 164 する	と
 117 する	が
  98 見える	と

「する」「見る」「与える」という動詞の格パターン:
 453 する	を
 203 する	に
 164 する	と
 117 する	が
  88 する	て を
  73 する	は
  61 する	を に
  61 する	て
  57 する	に を
  54 する	が を

 175 見る	て
  98 見る	を
  23 見る	て て
  20 見る	から
  18 見る	と
  13 見る	で
  12 見る	て を
  11 見る	から て
  11 見る	は て
   9 見る	に

   4 与える	に を
   2 与える	て に を
   1 与える	けれども に を
   1 与える	として を
   1 与える	に に対して も
   1 与える	が は は と て に を
   1 与える	は て に を に
   1 与える	は て に を
   1 与える	と は て を
   1 与える	て は に を

```



### 46

> 45のプログラムを改変し，述語と格パターンに続けて項（述語に係っている文節そのもの）をタブ区切り形式で出力せよ．
> 45の仕様に加えて，以下の仕様を満たすようにせよ．
>
> - 項は述語に係っている文節の単語列とする（末尾の助詞を取り除く必要はない）
> - 述語に係る文節が複数あるときは，助詞と同一の基準・順序でスペース区切りで並べる
>
> 「吾輩はここで始めて人間というものを見た」という例文（neko.txt.cabochaの8文目）を考える．
> この文は「始める」と「見る」の２つの動詞を含み，「始める」に係る文節は「ここで」，「見る」に係る文節は「吾輩は」と「ものを」と解析された場合は，次のような出力になるはずである．
>
> ```
> 始める  で      ここで
> 見る    は を   吾輩は ものを
> ```

```ruby
require_relative '41'

class Chunk
  def last_joshi
    morph = find_last_morph(pos: '助詞', pos1: '格助詞') || find_last_morph(pos: '助詞')
    morph&.base
  end
end

output_path = File.expand_path('../output/46.txt', __dir__)

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    next if chunk.srcs.empty?

    verb = chunk.find_morph(pos: '動詞')
    next if verb.nil?

    joshis, kous = chunk.srcs
                     .map { |src| chunks[src] }
                     .map { |c| [c.last_joshi, c.original] }
                     .reject { |joshi, _| joshi.nil? }
                     .transpose
    next if joshis.nil?

    arr << [verb.base, joshis.join(' '), kous.join(' ')].join("\t")
  end
end

File.open(output_path, 'w') { |f| f.puts res }

puts res.first(10)
```

```
生れる	で	どこで
つく	か が	生れたか 見当が
泣く	で	所で
する	て は	泣いて いた事だけは
始める	で	ここで
見る	は を	吾輩は ものを
聞く	で	あとで
捕える	を	我々を
煮る	て	捕えて
食う	て	煮て
```



### 47

> 動詞のヲ格にサ変接続名詞が入っている場合のみに着目したい．46のプログラムを以下の仕様を満たすように改変せよ．
>
> - 「サ変接続名詞+を（助詞）」で構成される文節が動詞に係る場合のみを対象とする
> - 述語は「サ変接続名詞+を+動詞の基本形」とし，文節中に複数の動詞があるときは，最左の動詞を用いる
> - 述語に係る助詞（文節）が複数あるときは，すべての助詞をスペース区切りで辞書順に並べる
> - 述語に係る文節が複数ある場合は，すべての項をスペース区切りで並べる（助詞の並び順と揃えよ）
>
> 例えば「別段くるにも及ばんさと、主人は手紙に返事をする。」という文から，以下の出力が得られるはずである．
>
> ```
> 返事をする      と に は        及ばんさと 手紙に 主人は
> ```
>
> このプログラムの出力をファイルに保存し，以下の事項をUNIXコマンドを用いて確認せよ．
>
> - コーパス中で頻出する述語（サ変接続名詞+を+動詞）
> - コーパス中で頻出する述語と助詞パターン

```ruby
require_relative '41'

class Chunk
  def last_joshi
    morph = find_last_morph(pos: '助詞', pos1: '格助詞') || find_last_morph(pos: '助詞')
    morph&.base
  end

  def sahen_setsuzoku_meishi_with_wo
    find_continuous_morphs({ pos: '名詞', pos1: 'サ変接続' }, { base: 'を', pos: '助詞' })&.map(&:base)&.join
  end

  private

  def find_continuous_morphs(*conditions)
    morphs.each_cons(conditions.size).find do |ms|
      ms.zip(conditions).all? do |morph, condition|
        condition.all? { |key, val| morph[key] == val }
      end
    end
  end
end

output_path = File.expand_path('../output/47.txt', __dir__)

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    next if chunk.srcs.empty?

    verb = chunk.find_morph(pos: '動詞')
    next if verb.nil?

    src_chunks   = chunk.srcs.map { |src| chunks[src] }
    target_chunk = src_chunks.find(&:sahen_setsuzoku_meishi_with_wo)
    next if target_chunk.nil?

    src_chunks.delete(target_chunk)
    joshis, kous = src_chunks
                     .map { |c| [c.last_joshi, c.original] }
                     .reject { |joshi, _| joshi.nil? }
                     .sort_by { |joshi, _| joshi }
                     .transpose

    arr << ["#{target_chunk.sahen_setsuzoku_meishi_with_wo}#{verb.base}", joshis&.join(' '), kous&.join(' ')].compact.join("\t")
  end
end

File.open(output_path, 'w') { |f| f.puts res }

puts 'コーパス中で頻出する述語:'
system "cut -f 1 #{output_path} | sort | uniq -c | sort -r | head"

puts "\nコーパス中で頻出する述語と助詞パターン:"
system "cut -f 1,2 #{output_path} | sort | uniq -c | sort -r | head"
```

```
コーパス中で頻出する述語:
  30 返事をする
  21 挨拶をする
  16 話をする
  14 真似をする
  13 喧嘩をする
   8 質問をする
   7 運動をする
   6 注意をする
   6 昼寝をする
   6 話を聞く

コーパス中で頻出する述語と助詞パターン:
   8 真似をする
   6 返事をする	と
   6 運動をする
   6 喧嘩をする
   4 挨拶をする	から
   4 返事をする	と は
   4 挨拶をする	と
   4 返事をする
   4 話を聞く
   4 話をする
```



### 48

> 文中のすべての名詞を含む文節に対し，その文節から構文木の根に至るパスを抽出せよ．
> ただし，構文木上のパスは以下の仕様を満たすものとする．
>
> - 各文節は（表層形の）形態素列で表現する
> - パスの開始文節から終了文節に至るまで，各文節の表現を"`->`"で連結する
>
> 「吾輩はここで始めて人間というものを見た」という文（neko.txt.cabochaの8文目）から，次のような出力が得られるはずである．
>
> ```
> 吾輩は -> 見た
> ここで -> 始めて -> 人間という -> ものを -> 見た
> 人間という -> ものを -> 見た
> ものを -> 見た
> ```

```ruby
require_relative '41'

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.select { |chunk| chunk.any_morphs?(pos: '名詞') }.each do |chunk|
    chained_chunks = chunk.chained_chunks(chunks)
    arr << chained_chunks.map(&:original).join(' -> ')
  end
end

puts res.first(10)
File.open(File.expand_path('../output/48.txt', __dir__), 'w') { |f| f.puts res }
```

```
一
吾輩は -> 猫である
猫である
名前は -> 無い
どこで -> 生れたか -> つかぬ
見当が -> つかぬ
何でも -> 薄暗い -> 所で -> 泣いて -> 記憶している
所で -> 泣いて -> 記憶している
ニャーニャー -> 泣いて -> 記憶している
いた事だけは -> 記憶している
```



### 49

> 文中のすべての名詞句のペアを結ぶ最短係り受けパスを抽出せよ．
> ただし，名詞句ペアの文節番号がiとj（i<j）のとき，係り受けパスは以下の仕様を満たすものとする．
>
> - 問題48と同様に，パスは開始文節から終了文節に至るまでの各文節の表現（表層形の形態素列）を"`->`"で連結して表現する
> - 文節iとjに含まれる名詞句はそれぞれ，XとYに置換する
>
> また，係り受けパスの形状は，以下の2通りが考えられる．
>
> - 文節iから構文木の根に至る経路上に文節jが存在する場合: 文節iから文節jのパスを表示
> - 上記以外で，文節iと文節jから構文木の根に至る経路上で共通の文節kで交わる場合: 文節iから文節kに至る直前のパスと文節jから文節kに至る直前までのパス，文節kの内容を"`|`"で連結して表示
>
> 例えば，「吾輩はここで始めて人間というものを見た。」という文（neko.txt.cabochaの8文目）から，次のような出力が得られるはずである．
>
> ```
> Xは | Yで -> 始めて -> 人間という -> ものを | 見た
> Xは | Yという -> ものを | 見た
> Xは | Yを | 見た
> Xで -> 始めて -> Y
> Xで -> 始めて -> 人間という -> Y
> Xという -> Y
> ```

```ruby
require_relative '41'

class Chunk
  def original_with_meishiku_replacement(replacement, symbol: false)
    ms = symbol ? morphs : morphs_without_symbol
    ms.map { |morph| morph.pos == '名詞' ? replacement : morph.surface }.join.sub(/(#{replacement})+/, replacement)
  end
end

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chained_chunk_combinations = chunks
                                 .select { |chunk| chunk.any_morphs?(pos: '名詞') }
                                 .map { |chunk| chunk.chained_chunks(chunks) }
                                 .combination(2)
  chained_chunk_combinations.each do |chained_chunks1, chained_chunks2|
    if (j = chained_chunks1.index(chained_chunks2.first))
      path = chained_chunks1[0...j].map.with_index do |chunk, i|
        i.zero? ? chunk.original_with_meishiku_replacement('X') : chunk.original
      end.push('Y').join(' -> ')
      arr << path
    else
      common_chunks = chained_chunks1 & chained_chunks2
      x_path        = (chained_chunks1 - common_chunks).map.with_index do |chunk, i|
        i.zero? ? chunk.original_with_meishiku_replacement('X') : chunk.original
      end.join(' -> ')
      y_path        = (chained_chunks2 - common_chunks).map.with_index do |chunk, i|
        i.zero? ? chunk.original_with_meishiku_replacement('Y') : chunk.original
      end.join(' -> ')
      common_path   = common_chunks.map(&:original).join(' -> ')
      arr << [x_path, y_path, common_path].join(' | ')
    end
  end
end

puts res.first(10)
File.open(File.expand_path('../output/49.txt', __dir__), 'w') { |f| f.puts res }
```

```
Xは -> Y
Xで -> 生れたか | Yが | つかぬ
Xでも -> 薄暗い -> Y
Xでも -> 薄暗い -> 所で | Y | 泣いて -> 記憶している
Xでも -> 薄暗い -> 所で -> 泣いて | Yだけは | 記憶している
Xでも -> 薄暗い -> 所で -> 泣いて -> Y
Xで | Y | 泣いて -> 記憶している
Xで -> 泣いて | Yだけは | 記憶している
Xで -> 泣いて -> Y
X -> 泣いて | Yだけは | 記憶している
```



## 第6章: 英語テキストの処理
### 50

> (. or ; or : or ? or !) → 空白文字 → 英大文字というパターンを文の区切りと見なし，入力された文書を1行1文の形式で出力せよ．

```ruby
file_path = File.expand_path('../data/nlp.txt', __dir__)

res = []
File.foreach(file_path, chomp: true) do |line|
  sentences = line.split(/(?<=[.;?!])\s+(?=[[:upper:]])/)
  res       += sentences
end

puts res.first(10)
File.open(File.expand_path('../output/50.txt', __dir__), 'w') { |f| f.puts res }
```

```
Natural language processing
From Wikipedia, the free encyclopedia
Natural language processing (NLP) is a field of computer science, artificial intelligence, and linguistics concerned with the interactions between computers and human (natural) languages.
As such, NLP is related to the area of humani-computer interaction.
Many challenges in NLP involve natural language understanding, that is, enabling computers to derive meaning from human or natural language input, and others involve natural language generation.
History
The history of NLP generally starts in the 1950s, although work can be found from earlier periods.
In 1950, Alan Turing published an article titled "Computing Machinery and Intelligence" which proposed what is now called the Turing test as a criterion of intelligence.
The Georgetown experiment in 1954 involved fully automatic translation of more than sixty Russian sentences into English.
The authors claimed that within three or five years, machine translation would be a solved problem.
```



### 51

> 空白を単語の区切りとみなし，50の出力を入力として受け取り，1行1単語の形式で出力せよ．ただし，文の終端では空行を出力せよ．

```ruby
input_file_path = File.expand_path('../output/50.txt', __dir__)
sentences       = File.readlines(input_file_path, chomp: true)

res = sentences.inject([]) do |arr, sentence|
  arr + sentence.split.push('')
end

puts res.first(10)
File.open(File.expand_path('../output/51.txt', __dir__), 'w') { |f| f.puts res }
```

```
Natural
language
processing

From
Wikipedia,
the
free
encyclopedia

```



### 52

> 51の出力を入力として受け取り，Porterのステミングアルゴリズムを適用し，単語と語幹をタブ区切り形式で出力せよ．
> Pythonでは，Porterのステミングアルゴリズムの実装としてstemmingモジュールを利用するとよい．

```ruby
require 'fast-stemmer'

input_file_path = File.expand_path('../output/51.txt', __dir__)
words           = File.readlines(input_file_path, chomp: true)

res = words.map do |word|
  word.empty? ? word : "#{word}\t#{word[/[[:word:]]*/].stem}"
end

puts res.first(10)
File.open(File.expand_path('../output/52.txt', __dir__), 'w') { |f| f.puts res }
```

```
Natural	Natur
language	languag
processing	process

From	From
Wikipedia,	Wikipedia
the	the
free	free
encyclopedia	encyclopedia

```



### 53

> Stanford Core NLPを用い，入力テキストの解析結果をXML形式で得よ．
> また，このXMLファイルを読み込み，入力テキストを1行1単語の形式で出力せよ．

```ruby
require 'rexml/document'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

res = []
doc.elements.each('/root/document/sentences/sentence/tokens/token/word') do |word|
  res << word.text
end

puts res.first(10)
File.open(File.expand_path('../output/53.txt', __dir__), 'w') { |f| f.puts res }
```

```
Natural
language
processing
From
Wikipedia
,
the
free
encyclopedia
Natural
```



### 54

> Stanford Core NLPの解析結果XMLを読み込み，単語，レンマ，品詞をタブ区切り形式で出力せよ．

```ruby
require 'rexml/document'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

res = []
doc.elements.each('/root/document/sentences/sentence/tokens/token') do |token|
  res << [token.elements['word'], token.elements['lemma'], token.elements['POS']].map(&:text).join("\t")
end

puts res.first(10)
File.open(File.expand_path('../output/54.txt', __dir__), 'w') { |f| f.puts res }
```

```
Natural	natural	JJ
language	language	NN
processing	processing	NN
From	from	IN
Wikipedia	Wikipedia	NNP
,	,	,
the	the	DT
free	free	JJ
encyclopedia	encyclopedia	NN
Natural	natural	JJ
```



### 55

> 入力文中の人名をすべて抜き出せ．

```ruby
require 'rexml/document'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

res = []
doc.elements.each('/root/document/sentences/sentence/tokens/token[NER/text()="PERSON"]') do |token|
  res << token.elements['word'].text
end
puts res
```

```
Alan
Turing
Joseph
Weizenbaum
MARGIE
Schank
Wilensky
Meehan
Lehnert
Carbonell
Lehnert
Racter
Jabberwacky
Moore
```



### 56

> Stanford Core NLPの共参照解析の結果に基づき，文中の参照表現（mention）を代表参照表現（representative mention）に置換せよ．
> ただし，置換するときは，「代表参照表現（参照表現）」のように，元の参照表現が分かるように配慮せよ．

```ruby
require 'rexml/document'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

sentences = []
doc.elements.each('/root/document/sentences/sentence') do |sentence|
  sentence_id = sentence.attributes['id']

  words         = []
  next_token_id = 0
  sentence.elements.each('tokens/token') do |token|
    token_id = token.attributes['id'].to_i
    next if token_id < next_token_id

    mention_predicate = "not(@representative='true') and sentence/text()=#{sentence_id} and start/text()=#{token_id}"
    mention           = doc.elements["/root/document/coreference/coreference/mention[#{mention_predicate}]"]
    next words << token.elements['word'].text if mention.nil?

    original_text       = mention.elements['text'].text
    representative_text = mention.elements['preceding-sibling::mention[@representative="true"]/text'].text
    words << "#{representative_text} (#{original_text})"

    next_token_id = mention.elements['end'].text.to_i
  end

  sentences << words.join(' ')
end

puts sentences.first(10)
File.open(File.expand_path('../output/56.txt', __dir__), 'w') { |f| f.puts sentences }
```

```
Natural language processing From Wikipedia , the free encyclopedia Natural language processing -LRB- NLP -RRB- is the free encyclopedia Natural language processing -LRB- NLP -RRB- (a field of computer science) , artificial intelligence , and linguistics concerned with the interactions between computers and human -LRB- natural -RRB- languages .
As such , NLP is related to the area of humani-computer interaction .
Many challenges in NLP involve natural language understanding , that is , enabling computers (computers) to derive meaning from human or natural language input , and others involve natural language generation .
History The history of NLP generally starts in the 1950s , although work can be found from earlier periods .
In 1950 , Alan Turing published an article titled `` Computing Machinery and Intelligence '' which proposed what is now called the Alan Turing (Turing) test as a criterion of intelligence .
The Georgetown experiment in 1954 involved fully automatic translation of more than sixty Russian sentences into English .
The authors claimed that within three or five years , a solved problem (machine translation) would be a solved problem .
However , real progress was much slower , and after the ALPAC report in 1966 , which found that ten year long research had failed to fulfill the expectations , funding for machine translation was dramatically reduced .
Little further research in a solved problem (machine translation) was conducted until the late 1980s , when the first statistical machine translation systems were developed .
Some notably successful NLP systems developed in the 1960s were SHRDLU , SHRDLU (a natural language system working in restricted `` blocks worlds '' with restricted vocabularies) , and ELIZA , a simulation of a Rogerian psychotherapist , written by Joseph Weizenbaum between 1964 to 1966 .
```



### 57

> Stanford Core NLPの係り受け解析の結果（collapsed-dependencies）を有向グラフとして可視化せよ．
> 可視化には，係り受け木をDOT言語に変換し，Graphvizを用いるとよい．
> また，Pythonから有向グラフを直接的に可視化するには，pydotを使うとよい．

```ruby
require 'rexml/document'
require 'ruby-graphviz'

sentence_id = ARGV[0]&.to_i || 2

file_path   = File.expand_path('../data/nlp.txt.xml', __dir__)
output_path = File.expand_path('../output/57.svg', __dir__)

doc = REXML::Document.new(File.open(file_path))

graph = GraphViz.new(:G) do |g|
  doc.elements.each("/root/document/sentences/sentence[@id='#{sentence_id}']/dependencies[@type='collapsed-dependencies']/dep") do |dep|
    governor  = dep.elements['governor']
    dependent = dep.elements['dependent']

    governor_node  = g.get_node(governor.attributes['idx']) || g.add_nodes(governor.attributes['idx'], label: governor.text)
    dependent_node = g.get_node(dependent.attributes['idx']) || g.add_nodes(dependent.attributes['idx'], label: dependent.text)

    g.add_edge(governor_node, dependent_node, label: dep.attributes['type'])
  end
end

graph.output(svg: output_path)
puts 'See output/57.svg'
```

```
See output/57.svg
```

- [57.svg](57.svg)

### 58

> Stanford Core NLPの係り受け解析の結果（collapsed-dependencies）に基づき，「主語 述語 目的語」の組をタブ区切り形式で出力せよ．
> ただし，主語，述語，目的語の定義は以下を参考にせよ．
>
> - 述語: nsubj関係とdobj関係の子（dependant）を持つ単語
> - 主語: 述語からnsubj関係にある子（dependent）
> - 目的語: 述語からdobj関係にある子（dependent）

```ruby
require 'rexml/document'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

res = []
doc.elements.each('/root/document/sentences/sentence/dependencies[@type="collapsed-dependencies"]') do |dependencies|
  dependencies.elements.each('dep[@type="nsubj"]') do |nsubj_dep|
    subject_element   = nsubj_dep.elements['dependent']
    predicate_element = nsubj_dep.elements['governor']
    dependencies.elements.each("dep[@type='dobj' and governor/@idx=#{predicate_element.attributes['idx']}]") do |dobj_dep|
      object_element = dobj_dep.elements['dependent']
      res << [subject_element, predicate_element, object_element].map(&:text).join("\t")
    end
  end
end

puts res.first(10)
File.open(File.expand_path('../output/58.txt', __dir__), 'w') { |f| f.puts res }
```

```
understanding	enabling	computers
others	involve	generation
Turing	published	article
experiment	involved	translation
ELIZA	provided	interaction
patient	exceeded	base
ELIZA	provide	response
which	structured	information
underpinnings	discouraged	sort
that	underlies	approach
```



### 59

> Stanford Core NLPの句構造解析の結果（S式）を読み込み，文中のすべての名詞句（NP）を表示せよ．
> 入れ子になっている名詞句もすべて表示すること．

```ruby
require 'rexml/document'
require 'sxp'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

def extract_np(sxp, res)
  if sxp[0] == :NP
    sxp[1..].map { |child| extract_np(child, res) }.join(' ').tap { |np| res << np }
  elsif sxp[1..].size > 1
    sxp[1..].map { |child| extract_np(child, res) }.join(' ')
  elsif sxp[1].is_a?(Array)
    extract_np(sxp[1], res)
  else
    sxp[1].to_s
  end
end

res = []
doc.elements.each('/root/document/sentences/sentence/parse') do |parse|
  sxp = SXP.read(parse.text)
  extract_np(sxp, res)
end

puts res.first(10)
File.open(File.expand_path('../output/59.txt', __dir__), 'w') { |f| f.puts res }
```

```
Natural language processing
Wikipedia
the free encyclopedia Natural language processing
NLP
the free encyclopedia Natural language processing -LRB- NLP -RRB-
a field
computer science
a field of computer science
artificial intelligence
linguistics
```



## 第7章: データベース
### 60

> Key-Value-Store (KVS) を用い，アーティスト名（name）から活動場所（area）を検索するためのデータベースを構築せよ．

```ruby
require 'json'
require 'zlib'
require 'redis'

file_path = File.expand_path('../data/artist.json.gz', __dir__)

redis = Redis.new(db: 0)

redis.flushdb

Zlib::GzipReader.open(file_path) do |gz|
  gz.each do |line|
    artist = JSON.parse(line)
    redis.sadd(artist['name'], artist['area']) if artist['area']
  end
end

puts redis.dbsize
```

```
309317
```



### 61

> 60で構築したデータベースを用い，特定の（指定された）アーティストの活動場所を取得せよ．

```ruby
require 'redis'

artist_name = ARGV[0] || 'Cornelius'

redis = Redis.new(db: 0)

areas = redis.smembers(artist_name)
puts areas.sort
```

```
Greece
Japan
```



### 62

> 60で構築したデータベースを用い，活動場所が「Japan」となっているアーティスト数を求めよ．

```ruby
require 'redis'

redis = Redis.new(db: 0)

res = redis.keys.count { |key| redis.sismember(key, 'Japan') }
puts res
```

```
22554
```



### 63

> KVSを用い，アーティスト名（name）からタグと被タグ数（タグ付けされた回数）のリストを検索するためのデータベースを構築せよ．
> さらに，ここで構築したデータベースを用い，アーティスト名からタグと被タグ数を検索せよ．

```ruby
require 'json'
require 'zlib'
require 'redis'

artist_name = ARGV[0] || 'Cornelius'

file_path = File.expand_path('../data/artist.json.gz', __dir__)

redis = Redis.new(db: 1)

unless redis.dbsize.positive?
  Zlib::GzipReader.open(file_path) do |gz|
    gz.each do |line|
      artist       = JSON.parse(line)
      name         = artist['name']
      tag_to_count = artist.fetch('tags', []).map { |tag| [tag['value'], tag['count']] }.to_h

      if redis.exists(name)
        existing_tag_to_count = redis.hgetall(name)
        tag_to_count.merge!(existing_tag_to_count) { |_, val, existing_val| val.to_i + existing_val.to_i }
      end

      redis.mapped_hmset(name, tag_to_count) unless tag_to_count.empty?
    end
  end
end

res = redis.hgetall(artist_name).sort_by { |_, val| -val.to_i }.to_h
puts res
```

```
{"japanese"=>"1", "dance and electronica"=>"1", "likedis auto"=>"1"}
```



### 64

> アーティスト情報（artist.json.gz）をデータベースに登録せよ．
> さらに，次のフィールドでインデックスを作成せよ: name, aliases.name, tags.value, rating.value

```ruby
require 'json'
require 'zlib'
require 'mongo'

file_path = File.expand_path('../data/artist.json.gz', __dir__)

Mongo::Logger.logger.level = Logger::INFO

client     = Mongo::Client.new('mongodb://127.0.0.1:27017/nlp100')
collection = client[:artist]

client.database.drop

collection.indexes.create_many(
  [
    { key: { name: 1 } },
    { key: { 'aliases.name': 1 } },
    { key: { 'tags.value': -1 } },
    { key: { 'rating.value': -1 } }
  ]
)

docs = []
Zlib::GzipReader.open(file_path) do |gz|
  gz.each do |line|
    docs << JSON.parse(line)
  end
end

res = collection.insert_many(docs)

puts 'Inserted count:', res.inserted_count
puts 'Indexes:'
collection.indexes.each(&method(:puts))
```

```
Inserted count:
921337
Indexes:
{"v"=>2, "key"=>{"_id"=>1}, "name"=>"_id_", "ns"=>"nlp100.artist"}
{"v"=>2, "key"=>{"name"=>1}, "name"=>"name_1", "ns"=>"nlp100.artist"}
{"v"=>2, "key"=>{"aliases.name"=>1}, "name"=>"aliases.name_1", "ns"=>"nlp100.artist"}
{"v"=>2, "key"=>{"tags.value"=>-1}, "name"=>"tags.value_-1", "ns"=>"nlp100.artist"}
{"v"=>2, "key"=>{"rating.value"=>-1}, "name"=>"rating.value_-1", "ns"=>"nlp100.artist"}
```



### 65

> MongoDBのインタラクティブシェルを用いて，"Queen"というアーティストに関する情報を取得せよ．
> さらに，これと同様の処理を行うプログラムを実装せよ．

```ruby
system %(mongo nlp100 --quiet --eval "db.artist.find({ name: 'Queen' })")
puts

require 'mongo'

artist_name = 'Queen'

Mongo::Logger.logger.level = Logger::INFO

client     = Mongo::Client.new('mongodb://127.0.0.1:27017/nlp100')
collection = client[:artist]

res = collection.find(name: artist_name).to_a

pp res
```

```
{ "_id" : ObjectId("5c6912d11b8dab2b71e9ee79"), "name" : "Queen", "area" : "Japan", "gender" : "Female", "tags" : [ { "count" : 1, "value" : "kamen rider w" }, { "count" : 1, "value" : "related-akb48" } ], "sort_name" : "Queen", "ended" : true, "gid" : "420ca290-76c5-41af-999e-564d7c71f1a7", "type" : "Character", "id" : 701492, "aliases" : [ { "name" : "Queen", "sort_name" : "Queen" } ] }
{ "_id" : ObjectId("5c6912d41b8dab2b71eab525"), "rating" : { "count" : 24, "value" : 92 }, "begin" : { "date" : 27, "month" : 6, "year" : 1970 }, "name" : "Queen", "area" : "United Kingdom", "tags" : [ { "count" : 2, "value" : "hard rock" }, { "count" : 1, "value" : "70s" }, { "count" : 1, "value" : "queen family" }, { "count" : 1, "value" : "90s" }, { "count" : 1, "value" : "80s" }, { "count" : 1, "value" : "glam rock" }, { "count" : 4, "value" : "british" }, { "count" : 1, "value" : "english" }, { "count" : 2, "value" : "uk" }, { "count" : 1, "value" : "pop/rock" }, { "count" : 1, "value" : "pop-rock" }, { "count" : 1, "value" : "britannique" }, { "count" : 1, "value" : "classic pop and rock" }, { "count" : 1, "value" : "queen" }, { "count" : 1, "value" : "united kingdom" }, { "count" : 1, "value" : "langham 1 studio bbc" }, { "count" : 1, "value" : "kind of magic" }, { "count" : 1, "value" : "band" }, { "count" : 6, "value" : "rock" }, { "count" : 1, "value" : "platinum" } ], "sort_name" : "Queen", "ended" : true, "gid" : "0383dadf-2a4e-4d10-a46a-e9e041da8eb3", "type" : "Group", "id" : 192, "aliases" : [ { "name" : "女王", "sort_name" : "女王" } ] }
{ "_id" : ObjectId("5c6912dc1b8dab2b71ec6f7d"), "ended" : true, "gid" : "5eecaf18-02ec-47af-a4f2-7831db373419", "sort_name" : "Queen", "id" : 992994, "name" : "Queen" }

[{"_id"=>BSON::ObjectId('5c6912d11b8dab2b71e9ee79'),
  "name"=>"Queen",
  "area"=>"Japan",
  "gender"=>"Female",
  "tags"=>
   [{"count"=>1, "value"=>"kamen rider w"},
    {"count"=>1, "value"=>"related-akb48"}],
  "sort_name"=>"Queen",
  "ended"=>true,
  "gid"=>"420ca290-76c5-41af-999e-564d7c71f1a7",
  "type"=>"Character",
  "id"=>701492,
  "aliases"=>[{"name"=>"Queen", "sort_name"=>"Queen"}]},
 {"_id"=>BSON::ObjectId('5c6912d41b8dab2b71eab525'),
  "rating"=>{"count"=>24, "value"=>92},
  "begin"=>{"date"=>27, "month"=>6, "year"=>1970},
  "name"=>"Queen",
  "area"=>"United Kingdom",
  "tags"=>
   [{"count"=>2, "value"=>"hard rock"},
    {"count"=>1, "value"=>"70s"},
    {"count"=>1, "value"=>"queen family"},
    {"count"=>1, "value"=>"90s"},
    {"count"=>1, "value"=>"80s"},
    {"count"=>1, "value"=>"glam rock"},
    {"count"=>4, "value"=>"british"},
    {"count"=>1, "value"=>"english"},
    {"count"=>2, "value"=>"uk"},
    {"count"=>1, "value"=>"pop/rock"},
    {"count"=>1, "value"=>"pop-rock"},
    {"count"=>1, "value"=>"britannique"},
    {"count"=>1, "value"=>"classic pop and rock"},
    {"count"=>1, "value"=>"queen"},
    {"count"=>1, "value"=>"united kingdom"},
    {"count"=>1, "value"=>"langham 1 studio bbc"},
    {"count"=>1, "value"=>"kind of magic"},
    {"count"=>1, "value"=>"band"},
    {"count"=>6, "value"=>"rock"},
    {"count"=>1, "value"=>"platinum"}],
  "sort_name"=>"Queen",
  "ended"=>true,
  "gid"=>"0383dadf-2a4e-4d10-a46a-e9e041da8eb3",
  "type"=>"Group",
  "id"=>192,
  "aliases"=>[{"name"=>"女王", "sort_name"=>"女王"}]},
 {"_id"=>BSON::ObjectId('5c6912dc1b8dab2b71ec6f7d'),
  "ended"=>true,
  "gid"=>"5eecaf18-02ec-47af-a4f2-7831db373419",
  "sort_name"=>"Queen",
  "id"=>992994,
  "name"=>"Queen"}]
```



### 66

> MongoDBのインタラクティブシェルを用いて，活動場所が「Japan」となっているアーティスト数を求めよ．

```ruby
system %(mongo nlp100 --quiet --eval "db.artist.distinct('name', { area: 'Japan' }).length")
```

```
22554
```



### 67

> 特定の（指定した）別名を持つアーティストを検索せよ．

```ruby
require 'mongo'

alias_name = ARGV[0] || '女王'

Mongo::Logger.logger.level = Logger::INFO

client     = Mongo::Client.new('mongodb://127.0.0.1:27017/nlp100')
collection = client[:artist]

res = collection.find('aliases.name': alias_name).to_a

pp res
```

```
[{"_id"=>BSON::ObjectId('5c6912d41b8dab2b71eab525'),
  "rating"=>{"count"=>24, "value"=>92},
  "begin"=>{"date"=>27, "month"=>6, "year"=>1970},
  "name"=>"Queen",
  "area"=>"United Kingdom",
  "tags"=>
   [{"count"=>2, "value"=>"hard rock"},
    {"count"=>1, "value"=>"70s"},
    {"count"=>1, "value"=>"queen family"},
    {"count"=>1, "value"=>"90s"},
    {"count"=>1, "value"=>"80s"},
    {"count"=>1, "value"=>"glam rock"},
    {"count"=>4, "value"=>"british"},
    {"count"=>1, "value"=>"english"},
    {"count"=>2, "value"=>"uk"},
    {"count"=>1, "value"=>"pop/rock"},
    {"count"=>1, "value"=>"pop-rock"},
    {"count"=>1, "value"=>"britannique"},
    {"count"=>1, "value"=>"classic pop and rock"},
    {"count"=>1, "value"=>"queen"},
    {"count"=>1, "value"=>"united kingdom"},
    {"count"=>1, "value"=>"langham 1 studio bbc"},
    {"count"=>1, "value"=>"kind of magic"},
    {"count"=>1, "value"=>"band"},
    {"count"=>6, "value"=>"rock"},
    {"count"=>1, "value"=>"platinum"}],
  "sort_name"=>"Queen",
  "ended"=>true,
  "gid"=>"0383dadf-2a4e-4d10-a46a-e9e041da8eb3",
  "type"=>"Group",
  "id"=>192,
  "aliases"=>[{"name"=>"女王", "sort_name"=>"女王"}]}]
```



### 68

> "dance"というタグを付与されたアーティストの中でレーティングの投票数が多いアーティスト・トップ10を求めよ．

```ruby
require 'mongo'

tag = 'dance'

Mongo::Logger.logger.level = Logger::INFO

client     = Mongo::Client.new('mongodb://127.0.0.1:27017/nlp100')
collection = client[:artist]

res = collection
        .find('tags.value': tag)
        .sort('rating.count': -1)
        .projection(name: 1, area: 1, rating: 1)
        .limit(10)
        .to_a

pp res
```

```
[{"_id"=>BSON::ObjectId('5c6912d71b8dab2b71ebc876'),
  "rating"=>{"count"=>26, "value"=>88},
  "name"=>"Madonna",
  "area"=>"United States"},
 {"_id"=>BSON::ObjectId('5c6912d41b8dab2b71eaf200'),
  "rating"=>{"count"=>23, "value"=>84},
  "name"=>"Björk",
  "area"=>"Iceland"},
 {"_id"=>BSON::ObjectId('5c6912e41b8dab2b71ee2541'),
  "rating"=>{"count"=>23, "value"=>90},
  "name"=>"The Prodigy",
  "area"=>"United Kingdom"},
 {"_id"=>BSON::ObjectId('5c6912e61b8dab2b71ee4eea'),
  "rating"=>{"count"=>15, "value"=>68},
  "name"=>"Rihanna",
  "area"=>"New York"},
 {"_id"=>BSON::ObjectId('5c6912b41b8dab2b71e2e50e'),
  "rating"=>{"count"=>13, "value"=>83},
  "name"=>"Britney Spears",
  "area"=>"United States"},
 {"_id"=>BSON::ObjectId('5c6912e61b8dab2b71ee5717'),
  "rating"=>{"count"=>11, "value"=>60},
  "name"=>"Maroon 5",
  "area"=>"United States"},
 {"_id"=>BSON::ObjectId('5c6912c21b8dab2b71e6baab'),
  "rating"=>{"count"=>7, "value"=>100},
  "name"=>"Adam Lambert",
  "area"=>"United States"},
 {"_id"=>BSON::ObjectId('5c6912d11b8dab2b71ea23a5'),
  "rating"=>{"count"=>7, "value"=>77},
  "name"=>"Fatboy Slim",
  "area"=>"United Kingdom"},
 {"_id"=>BSON::ObjectId('5c6912d71b8dab2b71eb6eeb'),
  "rating"=>{"count"=>6, "value"=>83},
  "name"=>"Basement Jaxx",
  "area"=>"United Kingdom"},
 {"_id"=>BSON::ObjectId('5c6912d41b8dab2b71eb3cca'),
  "rating"=>{"count"=>5, "value"=>68},
  "name"=>"Cornershop",
  "area"=>"United Kingdom"}]
```



### 69

> ユーザから入力された検索条件に合致するアーティストの情報を表示するWebアプリケーションを作成せよ．
> アーティスト名，アーティストの別名，タグ等で検索条件を指定し，アーティスト情報のリストをレーティングの高い順などで整列して表示せよ．

```ruby
require 'erb'
require 'webrick'
require 'mongo'

HTML_TEMPLATE = <<~'HTML'.freeze
  <!DOCTYPE html>
  <html lang="ja">
    <head>
      <meta charset="utf-8">
      <title>言語処理100本ノック 69</title>
    </head>
    <body>
      <form action="/" method="get">
        <div>
          <label for="name">名前</label>
          <input type="text" id="name" name="name" value="<%= h query['name']&.force_encoding('utf-8') %>">
        </div>
        <div>
          <label for="alias_name">別名</label>
          <input type="text" id="alias_name" name="aliases.name" value="<%= h query['aliases.name']&.force_encoding('utf-8') %>">
        </div>
        <div>
          <label for="tag">タグ</label>
          <input type="text" id="tag" name="tags.value" value="<%= h query['tags.value']&.force_encoding('utf-8') %>">
        </div>
        <div>
          <button type="submit">送信</button>
        </div>
      </form>
      <% if !query.empty? && results.empty? %>
        <p>
          該当するアーティストは見つかりませんでした。
        </p>
      <% elsif !results.empty? %>
        <hr>
        <table>
          <thead>
            <tr>
              <th>名前</th>
              <th>別名</th>
              <th>活動場所</th>
              <th>活動開始年</th>
              <th>活動終了年</th>
              <th>タグ</th>
              <th>レーティング</th>
            </tr>
          </thead>
          <tbody>
            <% results.each do |artist| %>
              <tr>
                <td><%= artist['name'] %></td>
                <td><%= artist['aliases']&.map { |a| a['name'] }&.join(', ') %></td>
                <td><%= artist['area'] %></td>
                <td><%= artist.dig('begin', 'year') %></td>
                <td><%= artist.dig('end', 'year') %></td>
                <td><%= artist['tags']&.map { |tag| "#{tag['value']} (#{tag['count']})" }&.join(' / ') %></td>
                <td><%= artist['rating'] ? "#{artist['rating']['value']} (#{artist['rating']['count']})" : '' %></td>
              </tr>
            <% end %>
          </tbody>
        </table>
      <% end %>
    </body>
  </html>
HTML

mongo_client = Mongo::Client.new('mongodb://127.0.0.1:27017/nlp100')
collection   = mongo_client[:artist]

server = WEBrick::HTTPServer.new(BindAddress: '127.0.0.1', Port: 10080)
server.mount_proc('/') do |req, res|
  include ERB::Util

  query   = req.query.slice('name', 'aliases.name', 'tags.value').reject { |_, val| val.nil? || val.empty? }
  results = if query.empty?
              []
            else
              collection.find(query).sort('rating.value': -1).limit(50).to_a
            end

  res.body = ERB.new(HTML_TEMPLATE).result(binding)
end
server.start
```

```
（省略）
```



