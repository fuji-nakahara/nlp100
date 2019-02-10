# (. or ; or : or ? or !) → 空白文字 → 英大文字というパターンを文の区切りと見なし，入力された文書を1行1文の形式で出力せよ．

file_path = File.expand_path('../data/nlp.txt', __dir__)

res = []
File.foreach(file_path, chomp: true) do |line|
  sentences = line.split(/(?<=[.;?!])\s+(?=[[:upper:]])/)
  res       += sentences
end

puts res.first(10)
File.open(File.expand_path('../output/50.txt', __dir__), 'w') { |f| f.puts res }
