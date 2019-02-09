# 係り元の文節と係り先の文節のテキストをタブ区切り形式ですべて抽出せよ．
# ただし，句読点などの記号は出力しないようにせよ．

require_relative '41'

class Chunk
  def original_without_symbol
    morphs.reject { |morph| morph.pos == '記号' }.map(&:surface).join
  end
end

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    str = chunk.original_without_symbol
    next if !chunk.dst? || str.empty?
    arr << "#{chunk.original_without_symbol}\t#{chunks[chunk.dst].original_without_symbol}"
  end
end

puts res.first(10)
File.open(File.expand_path('../output/42.txt', __dir__), 'w') { |f| f.puts res }
