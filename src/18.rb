# 各行を3コラム目の数値の逆順で整列せよ（注意: 各行の内容は変更せずに並び替えよ）．
# 確認にはsortコマンドを用いよ（この問題はコマンドで実行した時の結果と合わなくてもよい）．

require 'csv'

file_path = File.expand_path('../data/hightemp.txt', __dir__)

res = CSV.read(file_path, col_sep: "\t").sort_by { |row| -row[2].to_f }.map { |row| row.join("\t") }

# raise 'Failed' if res != `sort -k 3 -r #{file_path}`.lines(chomp: true)

puts res
