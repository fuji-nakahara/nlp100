# Stanford Core NLPの句構造解析の結果（S式）を読み込み，文中のすべての名詞句（NP）を表示せよ．
# 入れ子になっている名詞句もすべて表示すること．

require 'rexml/document'
require 'sxp'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

def extract_np(sxp, res)
  if sxp[0] == :NP
    sxp[1..].map { |child| extract_np(child, res) }.join(' ').tap { |np| res << np }
  elsif sxp[1..].size > 1
    sxp[1..].map { |child| extract_np(child, res) }.join(' ')
  elsif sxp[1].is_a?(Array)
    extract_np(sxp[1], res)
  else
    sxp[1].to_s
  end
end

res = []
doc.elements.each('/root/document/sentences/sentence/parse') do |parse|
  sxp = SXP.read(parse.text)
  extract_np(sxp, res)
end

puts res.first(10)
File.open(File.expand_path('../output/59.txt', __dir__), 'w') { |f| f.puts res }
