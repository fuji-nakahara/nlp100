# 「パタトクカシーー」という文字列の1,3,5,7文字目を取り出して連結した文字列を得よ．

str = 'パタトクカシーー'
res = str.chars.values_at(0, 2, 4, 6).join
puts res
