# 空白を単語の区切りとみなし，50の出力を入力として受け取り，1行1単語の形式で出力せよ．ただし，文の終端では空行を出力せよ．

input_file_path = File.expand_path('../output/50.txt', __dir__)
sentences       = File.readlines(input_file_path, chomp: true)

res = sentences.inject([]) do |arr, sentence|
  arr + sentence.split.push('')
end

puts res.first(10)
File.open(File.expand_path('../output/51.txt', __dir__), 'w') { |f| f.puts res }
