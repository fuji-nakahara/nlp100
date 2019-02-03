# 行数をカウントせよ．
# 確認にはwcコマンドを用いよ．

file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = File.readlines(file_path).size

raise 'Failed!' if res != `wc -l #{file_path}`.split[0].to_i

puts res
