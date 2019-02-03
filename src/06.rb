# "paraparaparadise"と"paragraph"に含まれる文字bi-gramの集合を，それぞれ, XとYとして求め，XとYの和集合，積集合，差集合を求めよ．
# さらに，'se'というbi-gramがXおよびYに含まれるかどうかを調べよ．

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
