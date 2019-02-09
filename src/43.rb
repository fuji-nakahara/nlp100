# 名詞を含む文節が，動詞を含む文節に係るとき，これらをタブ区切り形式で抽出せよ．
# ただし，句読点などの記号は出力しないようにせよ．

require_relative '41'

class Chunk
  def any_morphs?(options)
    manipulate_morphs(:any?, options)
  end
end

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    next if !chunk.dst? || chunk.any_morphs?(pos: '名詞')

    dst_chunk = chunks[chunk.dst]
    next if dst_chunk.any_morphs?(pos: '動詞')

    arr << "#{chunk.original}\t#{dst_chunk.original}"
  end
end

puts res.first(10)
File.open(File.expand_path('../output/43.txt', __dir__), 'w') { |f| f.puts res }
