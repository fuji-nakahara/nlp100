# 12で作ったcol1.txtとcol2.txtを結合し，元のファイルの1列目と2列目をタブ区切りで並べたテキストファイルを作成せよ．
# 確認にはpasteコマンドを用いよ．

require 'csv'

col1_path = File.expand_path('../output/col1.txt', __dir__)
col2_path = File.expand_path('../output/col2.txt', __dir__)

output_path = File.expand_path('../output/13.txt', __dir__)

col1 = File.readlines(col1_path, chomp: true)
col2 = File.readlines(col2_path, chomp: true)

res = [col1, col2].transpose.map { |row| row.join("\t") }

raise 'Failed!' if res != `paste #{col1_path} #{col2_path}`.lines(chomp: true)

File.open(output_path, 'w') { |f| f.puts res }
puts 'See output/13.txt'
