# Stanford Core NLPの係り受け解析の結果（collapsed-dependencies）を有向グラフとして可視化せよ．
# 可視化には，係り受け木をDOT言語に変換し，Graphvizを用いるとよい．
# また，Pythonから有向グラフを直接的に可視化するには，pydotを使うとよい．

require 'rexml/document'
require 'ruby-graphviz'

sentence_id = ARGV[0]&.to_i || 2

file_path   = File.expand_path('../data/nlp.txt.xml', __dir__)
output_path = File.expand_path('../output/57.svg', __dir__)

doc = REXML::Document.new(File.open(file_path))

graph = GraphViz.new(:G) do |g|
  doc.elements.each("/root/document/sentences/sentence[@id='#{sentence_id}']/dependencies[@type='collapsed-dependencies']/dep") do |dep|
    governor  = dep.elements['governor']
    dependent = dep.elements['dependent']

    governor_node  = g.get_node(governor.attributes['idx']) || g.add_nodes(governor.attributes['idx'], label: governor.text)
    dependent_node = g.get_node(dependent.attributes['idx']) || g.add_nodes(dependent.attributes['idx'], label: dependent.text)

    g.add_edge(governor_node, dependent_node, label: dep.attributes['type'])
  end
end

graph.output(svg: output_path)
puts 'See output/57.svg'
