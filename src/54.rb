# Stanford Core NLPの解析結果XMLを読み込み，単語，レンマ，品詞をタブ区切り形式で出力せよ．

require 'rexml/document'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

res = []
doc.elements.each('/root/document/sentences/sentence/tokens/token') do |token|
  res << [token.elements['word'], token.elements['lemma'], token.elements['POS']].map(&:text).join("\t")
end

puts res.first(10)
File.open(File.expand_path('../output/54.txt', __dir__), 'w') { |f| f.puts res }
