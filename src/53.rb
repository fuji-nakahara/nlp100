# Stanford Core NLPを用い，入力テキストの解析結果をXML形式で得よ．
# また，このXMLファイルを読み込み，入力テキストを1行1単語の形式で出力せよ．

require 'rexml/document'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

res = []
doc.elements.each('/root/document/sentences/sentence/tokens/token/word') do |word|
  res << word.text
end

puts res.first(10)
File.open(File.expand_path('../output/53.txt', __dir__), 'w') { |f| f.puts res }
