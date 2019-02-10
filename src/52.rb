# 51の出力を入力として受け取り，Porterのステミングアルゴリズムを適用し，単語と語幹をタブ区切り形式で出力せよ．
# Pythonでは，Porterのステミングアルゴリズムの実装としてstemmingモジュールを利用するとよい．

require 'fast-stemmer'

input_file_path = File.expand_path('../output/51.txt', __dir__)
words           = File.readlines(input_file_path, chomp: true)

res = words.map do |word|
  word.empty? ? word : "#{word}\t#{word[/[[:word:]]*/].stem}"
end

puts res.first(10)
File.open(File.expand_path('../output/52.txt', __dir__), 'w') { |f| f.puts res }
