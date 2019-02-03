# 「パトカー」＋「タクシー」の文字を先頭から交互に連結して文字列「パタトクカシーー」を得よ．

s1  = 'パトカー'
s2  = 'タクシー'
res = [s1, s2].map(&:chars).transpose.join
puts res
