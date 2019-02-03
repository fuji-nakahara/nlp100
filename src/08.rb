# 与えられた文字列の各文字を，以下の仕様で変換する関数cipherを実装せよ．
#
# - 英小文字ならば(219 - 文字コード)の文字に置換
# - その他の文字はそのまま出力
#
# この関数を用い，英語のメッセージを暗号化・復号化せよ．

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
