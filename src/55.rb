# 入力文中の人名をすべて抜き出せ．

require 'rexml/document'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

res = []
doc.elements.each('/root/document/sentences/sentence/tokens/token[NER/text()="PERSON"]') do |token|
  res << token.elements['word'].text
end
puts res
