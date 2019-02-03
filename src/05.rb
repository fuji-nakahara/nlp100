# 与えられたシーケンス（文字列やリストなど）からn-gramを作る関数を作成せよ．
# この関数を用い，"I am an NLPer"という文から単語bi-gram，文字bi-gramを得よ．

def n_gram(arr, n: 2)
  arr.each_cons(n).to_a
end

sentence = 'I am an NLPer'

puts "単語bi-gram: #{n_gram(sentence.split)}"
puts "文字bi-gram: #{n_gram(sentence.chars)}"
