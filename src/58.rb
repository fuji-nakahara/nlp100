# Stanford Core NLPの係り受け解析の結果（collapsed-dependencies）に基づき，「主語 述語 目的語」の組をタブ区切り形式で出力せよ．
# ただし，主語，述語，目的語の定義は以下を参考にせよ．
#
# - 述語: nsubj関係とdobj関係の子（dependant）を持つ単語
# - 主語: 述語からnsubj関係にある子（dependent）
# - 目的語: 述語からdobj関係にある子（dependent）

require 'rexml/document'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

res = []
doc.elements.each('/root/document/sentences/sentence/dependencies[@type="collapsed-dependencies"]') do |dependencies|
  dependencies.elements.each('dep[@type="nsubj"]') do |nsubj_dep|
    subject_element   = nsubj_dep.elements['dependent']
    predicate_element = nsubj_dep.elements['governor']
    dependencies.elements.each("dep[@type='dobj' and governor/@idx=#{predicate_element.attributes['idx']}]") do |dobj_dep|
      object_element = dobj_dep.elements['dependent']
      res << [subject_element, predicate_element, object_element].map(&:text).join("\t")
    end
  end
end

puts res.first(10)
File.open(File.expand_path('../output/58.txt', __dir__), 'w') { |f| f.puts res }
