# 各行の1列目の文字列の出現頻度を求め，その高い順に並べて表示せよ．
# 確認にはcut, uniq, sortコマンドを用いよ．

require 'csv'

file_path = File.expand_path('../data/hightemp.txt', __dir__)

col1 = CSV.read(file_path, col_sep: "\t").map { |row| row[0] }
res  = col1.each_with_object(Hash.new(0)) { |str, hash| hash[str] += 1 }.sort_by { |_, val| -val }.to_h

answer = `cut -f 1 #{file_path} | sort | uniq -c | sort -r`
raise 'Failed' if res != answer.lines(chomp: true).map(&:split).map { |count, val| [val, count.to_i] }.to_h

puts res
