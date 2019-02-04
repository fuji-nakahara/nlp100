# 1列目の文字列の種類（異なる文字列の集合）を求めよ．
# 確認にはsort, uniqコマンドを用いよ．

require 'csv'

file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = CSV.read(file_path, col_sep: "\t").map { |row| row[0] }.uniq.sort

raise 'Failed!' if res != `cut -f 1 #{file_path} | sort | uniq`.lines(chomp: true).sort

puts res
