# 各行の1列目だけを抜き出したものをcol1.txtに，2列目だけを抜き出したものをcol2.txtとしてファイルに保存せよ．
# 確認にはcutコマンドを用いよ．

require 'csv'

data_path = File.expand_path('../data/hightemp.txt', __dir__)

col1_path = File.expand_path('../output/col1.txt', __dir__)
col2_path = File.expand_path('../output/col2.txt', __dir__)

col1 = []
col2 = []
CSV.foreach(data_path, col_sep: "\t") do |row|
  col1 << row[0]
  col2 << row[1]
end

raise 'Failed!' if col1 != `cut -f 1 #{data_path}`.lines(chomp: true) || col2 != `cut -f 2 #{data_path}`.lines(chomp: true)

File.open(col1_path, 'w') { |f| f.puts col1 }
File.open(col2_path, 'w') { |f| f.puts col2 }
puts 'See output/col1.txt and output/col2.txt'
