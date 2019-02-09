# 与えられた文の係り受け木を有向グラフとして可視化せよ．
# 可視化には，係り受け木をDOT言語に変換し，Graphvizを用いるとよい．
# また，Pythonから有向グラフを直接的に可視化するには，pydotを使うとよい．

require 'ruby-graphviz'

require_relative '41'

sentence_idx = ARGV[0]&.to_i || 5
chunks       = NEKO_CHUNKS_LIST.fetch(sentence_idx)

output_path = File.expand_path('../output/44.svg', __dir__)

graph = GraphViz.new(:G) do |g|
  chunks.each_with_index do |chunk, idx|
    node = g.add_nodes(idx.to_s, label: chunk.original)
    chunk.srcs.each do |src_idx|
      g.add_edge(g.get_node(src_idx.to_s), node)
    end
  end
end

graph.output(svg: output_path)
puts 'See output/44.svg'
