# タブ1文字につきスペース1文字に置換せよ．
# 確認にはsedコマンド，trコマンド，もしくはexpandコマンドを用いよ．

file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = File.read(file_path).tr("\t", ' ')

raise 'Failed!' if res != `tr '\t' ' ' < #{file_path}`

puts res
