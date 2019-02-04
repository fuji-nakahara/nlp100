# 自然数Nをコマンドライン引数などの手段で受け取り，入力のうち先頭のN行だけを表示せよ．
# 確認にはheadコマンドを用いよ．

n = ARGV[0]&.to_i || 10

file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = File.foreach(file_path).first(n).join

raise 'Failed!' if res != `head -n #{n} #{file_path}`

puts res
